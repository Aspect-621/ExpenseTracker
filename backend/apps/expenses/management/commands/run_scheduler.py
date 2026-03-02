import time, datetime
from django.core.management.base import BaseCommand

class Command(BaseCommand):
    help = 'Background scheduler for recurring transactions'

    def handle(self, *args, **options):
        self.stdout.write("Scheduler started.")
        while True:
            try:
                self.process_recurring()
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
