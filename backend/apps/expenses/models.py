from django.db import models
from django.conf import settings
from django.db.models import Sum, Q
import datetime
from decimal import Decimal


class PaymentMethod(models.Model):
    name = models.CharField(max_length=100, unique=True)
    color = models.CharField(max_length=7, default='#6c757d')
    is_bank_account = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)
    order = models.IntegerField(default=0)
    currency = models.CharField(max_length=3, default='TWD')
    starting_balance = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    starting_balance_date = models.DateField(null=True, blank=True)

    class Meta:
        ordering = ['order', 'name']

    def __str__(self):
        return self.name

    @property
    def is_php(self):
        return self.currency == 'PHP'

    def get_balance(self):
        balance = self.starting_balance
        for txn in Transaction.objects.filter(
            Q(payment_method=self) | Q(to_payment_method=self)
        ):
            if txn.transaction_type == Transaction.TYPE_EXPENSE:
                if txn.payment_method == self:
                    balance -= txn.amount
            elif txn.transaction_type == Transaction.TYPE_INCOME:
                if txn.payment_method == self:
                    balance += txn.amount
            elif txn.transaction_type in (Transaction.TYPE_TRANSFER, Transaction.TYPE_TOPUP, Transaction.TYPE_PH_WITHDRAWAL):
                if txn.payment_method == self:
                    balance -= txn.amount
                if txn.to_payment_method == self:
                    balance += (txn.converted_amount if txn.converted_amount else txn.amount)
        return balance


class Category(models.Model):
    name = models.CharField(max_length=100, unique=True)
    color = models.CharField(max_length=7, default='#0d6efd')
    icon = models.CharField(max_length=50, default='tag')
    is_active = models.BooleanField(default=True)
    order = models.IntegerField(default=0)

    class Meta:
        ordering = ['order', 'name']
        verbose_name_plural = 'Categories'

    def __str__(self):
        return self.name


class BudgetLimit(models.Model):
    category = models.ForeignKey(Category, on_delete=models.CASCADE, related_name='budgets')
    month = models.DateField()
    amount = models.DecimalField(max_digits=12, decimal_places=2)
    currency = models.CharField(max_length=3, default='TWD')

    class Meta:
        unique_together = ('category', 'month')
        ordering = ['-month', 'category']

    def __str__(self):
        return f"{self.category.name} - {self.month.strftime('%B %Y')}"

    def get_spent(self):
        start = self.month
        end = self.month.replace(month=self.month.month % 12 + 1, day=1) if self.month.month < 12 else self.month.replace(year=self.month.year + 1, month=1, day=1)
        return Transaction.objects.filter(
            category=self.category, transaction_type=Transaction.TYPE_EXPENSE,
            date__gte=start, date__lt=end, currency=self.currency
        ).aggregate(t=Sum('amount'))['t'] or 0

    @property
    def percentage(self):
        spent = self.get_spent()
        return min(int((spent / self.amount) * 100), 100) if self.amount else 0

    @property
    def status(self):
        p = self.percentage
        return 'danger' if p >= 100 else 'warning' if p >= 80 else 'success'


class Transaction(models.Model):
    TYPE_EXPENSE       = 'expense'
    TYPE_INCOME        = 'income'
    TYPE_TRANSFER      = 'transfer'
    TYPE_TOPUP         = 'topup'
    TYPE_PH_WITHDRAWAL = 'ph_withdrawal'
    TYPE_CHOICES = [
        (TYPE_EXPENSE,       'Expense'),
        (TYPE_INCOME,        'Income'),
        (TYPE_TRANSFER,      'Transfer'),
        (TYPE_TOPUP,         'Top-up'),
        (TYPE_PH_WITHDRAWAL, 'PH Withdrawal'),
    ]

    date = models.DateField(default=datetime.date.today)
    name = models.CharField(max_length=255, verbose_name='Description')
    amount = models.DecimalField(max_digits=12, decimal_places=2)
    currency = models.CharField(max_length=3, default='TWD')
    transaction_type = models.CharField(max_length=15, choices=TYPE_CHOICES, default=TYPE_EXPENSE)
    payment_method = models.ForeignKey(PaymentMethod, on_delete=models.PROTECT, related_name='transactions', null=True, blank=True)
    to_payment_method = models.ForeignKey(PaymentMethod, on_delete=models.PROTECT, related_name='incoming_transfers', null=True, blank=True)
    category = models.ForeignKey(Category, on_delete=models.PROTECT, related_name='transactions', null=True, blank=True)
    notes = models.TextField(blank=True, default='')
    is_hidden = models.BooleanField(default=False)
    is_recurring_instance = models.BooleanField(default=False)
    # Discount applied to this expense (savings tracking)
    discount_amount = models.DecimalField(max_digits=12, decimal_places=2, null=True, blank=True)
    # For withdrawals/transfers: exchange rate and converted amount
    exchange_rate = models.DecimalField(max_digits=10, decimal_places=6, null=True, blank=True)
    converted_amount = models.DecimalField(max_digits=12, decimal_places=2, null=True, blank=True)
    # Link paired transactions (PH withdrawal creates 2 logs)
    paired_transaction = models.OneToOneField('self', null=True, blank=True, on_delete=models.SET_NULL, related_name='pair')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['-date', '-created_at']

    def __str__(self):
        return f"{self.date} [{self.transaction_type}] {self.name} {self.currency} {self.amount}"

    @property
    def type_badge_color(self):
        return {
            self.TYPE_EXPENSE:       'danger',
            self.TYPE_INCOME:        'success',
            self.TYPE_TRANSFER:      'info',
            self.TYPE_TOPUP:         'warning',
            self.TYPE_PH_WITHDRAWAL: 'purple',
        }.get(self.transaction_type, 'secondary')


Expense = Transaction


class TransactionAuditLog(models.Model):
    ACTION_CREATE = 'created'
    ACTION_UPDATE = 'updated'
    ACTION_DELETE = 'deleted'
    ACTION_CHOICES = [
        (ACTION_CREATE, 'Created'),
        (ACTION_UPDATE, 'Updated'),
        (ACTION_DELETE, 'Deleted'),
    ]
    transaction_id   = models.IntegerField()
    transaction_name = models.CharField(max_length=255, default='')
    user             = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.SET_NULL, null=True, blank=True)
    action           = models.CharField(max_length=10, choices=ACTION_CHOICES)
    changes          = models.TextField(blank=True, default='{}')  # JSON
    timestamp        = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-timestamp']

    def __str__(self):
        return f"{self.timestamp:%Y-%m-%d %H:%M} [{self.action}] {self.transaction_name}"

    def get_changes(self):
        import json
        try:
            return json.loads(self.changes)
        except Exception:
            return {}


class TransactionTemplate(models.Model):
    label            = models.CharField(max_length=100)
    name             = models.CharField(max_length=255)
    amount           = models.DecimalField(max_digits=12, decimal_places=2)
    currency         = models.CharField(max_length=3, default='TWD')
    transaction_type = models.CharField(max_length=15, choices=Transaction.TYPE_CHOICES, default=Transaction.TYPE_EXPENSE)
    payment_method   = models.ForeignKey(PaymentMethod, on_delete=models.SET_NULL, null=True, blank=True)
    category         = models.ForeignKey(Category, on_delete=models.SET_NULL, null=True, blank=True)
    notes            = models.TextField(blank=True, default='')
    created_at       = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['label']

    def __str__(self):
        return self.label


class TransactionAttachment(models.Model):
    transaction   = models.ForeignKey(Transaction, on_delete=models.CASCADE, related_name='attachments')
    file          = models.FileField(upload_to='attachments/')
    original_name = models.CharField(max_length=255)
    uploaded_at   = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-uploaded_at']

    def __str__(self):
        return f"{self.original_name} → {self.transaction}"

    @property
    def is_image(self):
        return self.original_name.lower().endswith(('.jpg', '.jpeg', '.png', '.gif', '.webp'))

    @property
    def file_size_kb(self):
        try:
            return round(self.file.size / 1024, 1)
        except Exception:
            return 0


class SharedExpense(models.Model):
    transaction  = models.ForeignKey(Transaction, on_delete=models.CASCADE, related_name='shared_with')
    member_name  = models.CharField(max_length=100)
    share_amount = models.DecimalField(max_digits=12, decimal_places=2)
    currency     = models.CharField(max_length=3, default='TWD')
    is_settled   = models.BooleanField(default=False)
    settled_date = models.DateField(null=True, blank=True)
    notes        = models.TextField(blank=True, default='')
    created_at   = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.transaction.name} → {self.member_name} ({self.currency} {self.share_amount})"


class UserPreference(models.Model):
    THEME_DARK  = 'dark'
    THEME_LIGHT = 'light'
    THEME_CHOICES = [(THEME_DARK, 'Dark'), (THEME_LIGHT, 'Light')]

    user             = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='preference')
    theme            = models.CharField(max_length=5, choices=THEME_CHOICES, default=THEME_DARK)
    default_currency = models.CharField(max_length=3, default='TWD')

    def __str__(self):
        return f"{self.user.username} preferences"


class RecurringExpense(models.Model):
    name = models.CharField(max_length=255)
    amount = models.DecimalField(max_digits=12, decimal_places=2)
    currency = models.CharField(max_length=3, default='TWD')
    transaction_type = models.CharField(max_length=15, choices=Transaction.TYPE_CHOICES, default=Transaction.TYPE_EXPENSE)
    payment_method = models.ForeignKey(PaymentMethod, on_delete=models.PROTECT, related_name='recurring')
    to_payment_method = models.ForeignKey(PaymentMethod, on_delete=models.PROTECT, related_name='recurring_incoming', null=True, blank=True)
    category = models.ForeignKey(Category, on_delete=models.PROTECT, null=True, blank=True)
    notes = models.TextField(blank=True, default='')
    day_of_month = models.IntegerField(default=1)
    is_active = models.BooleanField(default=True)
    start_date = models.DateField(default=datetime.date.today)
    end_date = models.DateField(null=True, blank=True)
    last_added = models.DateField(null=True, blank=True)

    class Meta:
        ordering = ['name']

    def __str__(self):
        return f"[Recurring] {self.name}"

    def should_add_this_month(self):
        today = datetime.date.today()
        if not self.is_active: return False
        if self.end_date and today > self.end_date: return False
        if today < self.start_date: return False
        due = today.replace(day=min(self.day_of_month, 28))
        if today < due: return False
        if self.last_added and self.last_added.year == today.year and self.last_added.month == today.month:
            return False
        return True
