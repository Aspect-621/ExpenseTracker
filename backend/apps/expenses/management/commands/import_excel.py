import datetime
from decimal import Decimal
from django.core.management.base import BaseCommand


def classify(name, amount):
    """Auto-classify a row from the Excel sheet into a transaction type."""
    n = name.lower().strip()
    if amount > 0:
        if any(k in n for k in ['salary', 'wage', 'payroll']):
            return 'income'
        if any(k in n for k in ['withdraw', 'withdrawal']):
            return 'transfer'   # Bank → Cash
        if any(k in n for k in ['top up', 'topup', 'top-up', 'laba', 'load', 'converted to cash', 'convert to cash']):
            return 'transfer'
        if any(k in n for k in ['discount', 'refund', 'cashback', 'rebate']):
            return 'income'
        # Generic positive = income
        return 'income'
    else:
        return 'expense'


def resolve_transfer_accounts(name, amount, payment_method_name, pm_map):
    """
    For transfer rows, determine from_pm and to_pm.
    Returns (from_pm, to_pm) PaymentMethod objects or (pm, None).
    """
    n = name.lower()
    cash   = pm_map.get('Cash')
    ipass  = pm_map.get('iPass')
    bank   = pm_map.get('Taishin Bank')
    linepay = pm_map.get('LINE Pay')
    current = pm_map.get(payment_method_name)

    if amount > 0:
        # Positive on cash = money coming IN to cash
        if 'withdraw' in n:
            return (bank, cash)   # Bank → Cash
        if 'converted to cash' in n or 'convert to cash' in n:
            return (current, cash)
        if 'laba' in n or 'top' in n:
            # Top-up for LINE Pay from cash
            return (cash, linepay if linepay else current)
        if 'ipass' in n:
            return (cash, ipass)
        # Default: current account receives money from bank
        return (bank, current)

    return (current, None)


class Command(BaseCommand):
    help = 'Import all transactions from the Taiwan Excel file'

    def add_arguments(self, parser):
        parser.add_argument(
            '--file',
            default='/app/import_data/Expenses_V2_Taiwan_1.xlsx',
            help='Path to Excel file'
        )
        parser.add_argument('--clear', action='store_true', help='Clear existing transactions before import')

    def handle(self, *args, **options):
        import openpyxl
        from apps.expenses.models import Transaction, PaymentMethod, Category

        filepath = options['file']
        try:
            wb = openpyxl.load_workbook(filepath, data_only=True)
        except FileNotFoundError:
            self.stderr.write(f"File not found: {filepath}")
            return

        if options['clear']:
            Transaction.objects.all().delete()
            self.stdout.write("Cleared existing transactions.")

        # Build lookup maps
        pm_map  = {pm.name: pm for pm in PaymentMethod.objects.all()}
        cat_map = {c.name: c  for c in Category.objects.all()}

        # Ensure we have a General and Income category
        general_cat, _ = Category.objects.get_or_create(
            name='General', defaults={'color': '#6c757d', 'icon': 'bag', 'order': 3}
        )
        income_cat, _ = Category.objects.get_or_create(
            name='Income', defaults={'color': '#198754', 'icon': 'cash-stack', 'order': 4}
        )
        cat_map['General'] = general_cat
        cat_map['Income']  = income_cat

        monthly_sheets = ['December 2025', 'January 2026', 'February 2026']
        imported = skipped = errors = 0

        for sheet_name in monthly_sheets:
            if sheet_name not in wb.sheetnames:
                self.stdout.write(f"Sheet '{sheet_name}' not found, skipping.")
                continue

            ws = wb[sheet_name]
            self.stdout.write(f"\nProcessing: {sheet_name}")

            for row in ws.iter_rows(min_row=4, values_only=True):
                raw_date  = row[0]
                raw_name  = row[1]
                raw_pm    = row[2]
                raw_type  = row[3]
                raw_price = row[4]

                # Skip empty or header-like rows
                if not raw_name or not raw_pm or raw_price is None:
                    continue
                if str(raw_name).strip().lower() in ('name', 'description', ''):
                    continue

                # Parse date
                if isinstance(raw_date, datetime.datetime):
                    txn_date = raw_date.date()
                elif isinstance(raw_date, datetime.date):
                    txn_date = raw_date
                else:
                    txn_date = datetime.date.today()

                name     = str(raw_name).strip()
                pm_name  = str(raw_pm).strip()
                cat_name = str(raw_type).strip() if raw_type else 'General'
                amount   = float(raw_price)
                abs_amount = abs(amount)

                # Resolve payment method
                pm = pm_map.get(pm_name)
                if not pm:
                    self.stderr.write(f"  Unknown payment method '{pm_name}' for '{name}' — skipping")
                    errors += 1
                    continue

                # Resolve category
                cat = cat_map.get(cat_name, general_cat)

                # Classify transaction type
                txn_type = classify(name, amount)

                # Defaults
                from_pm = pm
                to_pm   = None

                if txn_type == 'transfer':
                    from_pm, to_pm = resolve_transfer_accounts(name, amount, pm_name, pm_map)
                    if from_pm is None:
                        from_pm = pm
                    cat = general_cat

                if txn_type == 'income':
                    cat = income_cat

                # Create transaction
                try:
                    Transaction.objects.create(
                        date=txn_date,
                        name=name,
                        amount=Decimal(str(abs_amount)),
                        currency='TWD',
                        transaction_type=txn_type,
                        payment_method=from_pm,
                        to_payment_method=to_pm,
                        category=cat,
                        notes='',
                        is_hidden=False,
                    )
                    imported += 1
                except Exception as e:
                    self.stderr.write(f"  Error importing '{name}': {e}")
                    errors += 1

        self.stdout.write(self.style.SUCCESS(
            f"\n✅ Import complete: {imported} imported, {skipped} skipped, {errors} errors"
        ))
