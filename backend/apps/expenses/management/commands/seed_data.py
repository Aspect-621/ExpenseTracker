import datetime
from django.core.management.base import BaseCommand

class Command(BaseCommand):
    help = 'Seed initial categories and payment methods'

    def handle(self, *args, **options):
        from apps.expenses.models import Category, PaymentMethod

        categories = [
            {'name': 'Food',           'color': '#fd7e14', 'icon': 'cart',       'order': 1},
            {'name': 'Transportation', 'color': '#0d6efd', 'icon': 'car-front',  'order': 2},
            {'name': 'General',        'color': '#6c757d', 'icon': 'bag',        'order': 3},
            {'name': 'Income',         'color': '#198754', 'icon': 'cash-stack', 'order': 4},
            {'name': 'Discount',       'color': '#4ade80', 'icon': 'tag',        'order': 5},
        ]
        for d in categories:
            Category.objects.get_or_create(name=d['name'], defaults=d)
            self.stdout.write(f"Category: {d['name']}")

        start_date = datetime.date(2025, 12, 26)
        today = datetime.date.today()
        payment_methods = [
            {'name': 'Cash',         'color': '#198754', 'is_bank_account': False, 'order': 1, 'currency': 'TWD', 'starting_balance': 5432, 'starting_balance_date': start_date},
            {'name': 'iPass',        'color': '#0dcaf0', 'is_bank_account': False, 'order': 2, 'currency': 'TWD', 'starting_balance': 449,  'starting_balance_date': start_date},
            {'name': 'Taishin Bank', 'color': '#dc3545', 'is_bank_account': True,  'order': 3, 'currency': 'TWD', 'starting_balance': 0,    'starting_balance_date': start_date},
            {'name': 'LINE Pay',     'color': '#00b900', 'is_bank_account': False, 'order': 4, 'currency': 'TWD', 'starting_balance': 0,    'starting_balance_date': start_date},
            {'name': 'BDO',          'color': '#003087', 'is_bank_account': True,  'order': 5, 'currency': 'PHP', 'starting_balance': 0,    'starting_balance_date': today},
            {'name': 'Landbank',     'color': '#00843D', 'is_bank_account': True,  'order': 6, 'currency': 'PHP', 'starting_balance': 0,    'starting_balance_date': today},
            {'name': 'GoTyme',       'color': '#FF6B35', 'is_bank_account': True,  'order': 7, 'currency': 'PHP', 'starting_balance': 0,    'starting_balance_date': today},
            {'name': 'GCash',        'color': '#007DFF', 'is_bank_account': False, 'order': 8, 'currency': 'PHP', 'starting_balance': 0,    'starting_balance_date': today},
        ]
        for d in payment_methods:
            obj, created = PaymentMethod.objects.get_or_create(name=d['name'], defaults=d)
            if not created:
                obj.color = d['color']
                obj.order = d['order']
                obj.save()
            self.stdout.write(f"Payment Method: {d['name']} ({d['currency']})")

        self.stdout.write(self.style.SUCCESS('Seed complete!'))
