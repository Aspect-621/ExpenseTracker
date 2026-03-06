import time
import datetime
import os
import subprocess
import glob

from django.core.management.base import BaseCommand


BACKUP_DIR = '/app/backups'
BACKUP_RETENTION_DAYS = 30


class Command(BaseCommand):
    help = 'Background scheduler for recurring transactions and daily backups'

    def handle(self, *args, **options):
        self.stdout.write("Scheduler started.")
        os.makedirs(BACKUP_DIR, exist_ok=True)
        last_backup_date = None

        while True:
            try:
                now = datetime.datetime.now()

                # ── Recurring expenses ────────────────────────────────────────
                self.process_recurring()

                # ── Daily backup at 02:00 ─────────────────────────────────────
                if now.hour == 2 and last_backup_date != now.date():
                    self.stdout.write(f"[{now:%Y-%m-%d %H:%M}] Running scheduled backup...")
                    success, path = self.run_backup(label='scheduled')
                    if success:
                        last_backup_date = now.date()
                        self.stdout.write(f"  ✅ Backup saved: {path}")
                        self.cleanup_old_backups()
                    else:
                        self.stderr.write(f"  ❌ Backup failed: {path}")

            except Exception as e:
                self.stderr.write(f"Scheduler error: {e}")

            time.sleep(3600)

    def process_recurring(self):
        from apps.expenses.models import RecurringExpense, Transaction
        today = datetime.date.today()
        for rec in RecurringExpense.objects.filter(is_active=True):
            if rec.should_add_this_month():
                due_date = today.replace(day=min(rec.day_of_month, 28))
                Transaction.objects.create(
                    date=due_date,
                    name=rec.name,
                    amount=rec.amount,
                    currency=rec.currency,
                    transaction_type=rec.transaction_type,
                    payment_method=rec.payment_method,
                    to_payment_method=rec.to_payment_method,
                    category=rec.category,
                    notes=rec.notes,
                    is_recurring_instance=True,
                )
                rec.last_added = today
                rec.save()
                self.stdout.write(f"Auto-added recurring: {rec.name}")

    @staticmethod
    def run_backup(label='manual'):
        os.makedirs(BACKUP_DIR, exist_ok=True)
        ts = datetime.datetime.now().strftime('%Y-%m-%d_%H-%M')
        filename = f"backup_{ts}_{label}.sql"
        filepath = os.path.join(BACKUP_DIR, filename)

        env = os.environ.copy()
        env['PGPASSWORD'] = os.environ.get('POSTGRES_PASSWORD', 'expensepass')

        cmd = [
            'pg_dump',
            '-h', os.environ.get('POSTGRES_HOST', 'db'),
            '-p', os.environ.get('POSTGRES_PORT', '5432'),
            '-U', os.environ.get('POSTGRES_USER', 'expenseuser'),
            '-d', os.environ.get('POSTGRES_DB', 'expensetracker'),
            '-f', filepath,
            '--no-password',
            '--clean',
            '--if-exists',
        ]

        try:
            result = subprocess.run(cmd, env=env, capture_output=True, text=True, timeout=120)
            if result.returncode == 0:
                return True, filepath
            return False, result.stderr.strip()
        except Exception as e:
            return False, str(e)

    @staticmethod
    def cleanup_old_backups():
        cutoff = datetime.datetime.now() - datetime.timedelta(days=BACKUP_RETENTION_DAYS)
        for f in glob.glob(os.path.join(BACKUP_DIR, 'backup_*.sql')):
            try:
                mtime = datetime.datetime.fromtimestamp(os.path.getmtime(f))
                if mtime < cutoff:
                    os.remove(f)
            except Exception:
                pass
