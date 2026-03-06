from django.core.management.base import BaseCommand
from django.db import connection


class Command(BaseCommand):
    help = 'Reset PostgreSQL sequences to match current max IDs (fixes duplicate key errors after bulk import)'

    def handle(self, *args, **options):
        tables = [
            'expenses_transaction',
            'expenses_category',
            'expenses_paymentmethod',
            'expenses_user',
            'expenses_recurringexpense',
            'expenses_budgetlimit',
            'expenses_transactiontemplate',
            'expenses_transactionauditlog',
            'expenses_sharedexpense',
        ]
        with connection.cursor() as cursor:
            for table in tables:
                try:
                    cursor.execute(f"""
                        SELECT setval(
                            pg_get_serial_sequence('{table}', 'id'),
                            COALESCE((SELECT MAX(id) FROM {table}), 1)
                        );
                    """)
                    self.stdout.write(f"  ✅ Reset sequence for {table}")
                except Exception as e:
                    self.stdout.write(f"  ⚠ Skipped {table}: {e}")
        self.stdout.write(self.style.SUCCESS("✅ All sequences reset."))
