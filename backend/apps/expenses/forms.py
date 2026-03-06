from django import forms
from .models import Transaction, Category, PaymentMethod, BudgetLimit, RecurringExpense, TransactionTemplate, SharedExpense
from django.conf import settings
import datetime

CURRENCY_CHOICES = [(c, c) for c in settings.SUPPORTED_CURRENCIES]


class TransactionForm(forms.ModelForm):
    date = forms.DateField(
        widget=forms.DateInput(attrs={'type': 'date', 'class': 'form-control'}),
        initial=datetime.date.today
    )
    currency = forms.ChoiceField(
        choices=CURRENCY_CHOICES, initial='TWD',
        widget=forms.Select(attrs={'class': 'form-select'})
    )

    class Meta:
        model = Transaction
        fields = [
            'date', 'name', 'transaction_type', 'amount', 'currency',
            'payment_method', 'to_payment_method', 'category',
            'discount_amount', 'notes', 'is_hidden'
        ]
        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Description'}),
            'transaction_type': forms.Select(attrs={'class': 'form-select', 'id': 'id_transaction_type'}),
            'amount': forms.NumberInput(attrs={'class': 'form-control', 'step': '0.01', 'placeholder': '0.00', 'min': '0'}),
            'payment_method': forms.Select(attrs={'class': 'form-select'}),
            'to_payment_method': forms.Select(attrs={'class': 'form-select', 'id': 'id_to_payment_method'}),
            'category': forms.Select(attrs={'class': 'form-select', 'id': 'id_category'}),
            'discount_amount': forms.NumberInput(attrs={'class': 'form-control', 'step': '0.01', 'placeholder': '0.00', 'min': '0'}),
            'notes': forms.Textarea(attrs={'class': 'form-control', 'rows': 2, 'placeholder': 'Optional notes...'}),
            'is_hidden': forms.CheckboxInput(attrs={'class': 'form-check-input'}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        active_pms = PaymentMethod.objects.filter(is_active=True)
        self.fields['payment_method'].queryset = active_pms
        self.fields['to_payment_method'].queryset = active_pms
        self.fields['to_payment_method'].required = False
        self.fields['to_payment_method'].label = 'To Account'
        self.fields['category'].queryset = Category.objects.filter(is_active=True)
        self.fields['category'].required = False
        self.fields['payment_method'].label = 'From Account'

    def clean(self):
        cleaned_data = super().clean()
        txn_type = cleaned_data.get('transaction_type')
        to_pm = cleaned_data.get('to_payment_method')
        from_pm = cleaned_data.get('payment_method')
        if txn_type in (Transaction.TYPE_TRANSFER, Transaction.TYPE_TOPUP):
            if not to_pm:
                self.add_error('to_payment_method', 'Please select a destination account.')
            if from_pm and to_pm and from_pm == to_pm:
                self.add_error('to_payment_method', 'Source and destination must be different.')
        return cleaned_data


ExpenseForm = TransactionForm


class CategoryForm(forms.ModelForm):
    class Meta:
        model = Category
        fields = ['name', 'color', 'icon', 'is_active']
        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control'}),
            'color': forms.TextInput(attrs={'type': 'color', 'class': 'form-control form-control-color'}),
            'icon': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'e.g. cart, car-front, bag'}),
            'is_active': forms.CheckboxInput(attrs={'class': 'form-check-input'}),
            'order': forms.NumberInput(attrs={'class': 'form-control'}),
        }


class PaymentMethodForm(forms.ModelForm):
    class Meta:
        model = PaymentMethod
        fields = ['name', 'color', 'is_bank_account', 'is_active', 'starting_balance', 'starting_balance_date']
        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control'}),
            'color': forms.TextInput(attrs={'type': 'color', 'class': 'form-control form-control-color'}),
            'is_bank_account': forms.CheckboxInput(attrs={'class': 'form-check-input'}),
            'is_active': forms.CheckboxInput(attrs={'class': 'form-check-input'}),
            'order': forms.NumberInput(attrs={'class': 'form-control'}),
            'starting_balance': forms.NumberInput(attrs={'class': 'form-control', 'step': '0.01'}),
            'starting_balance_date': forms.DateInput(attrs={'type': 'date', 'class': 'form-control'}),
        }


class BudgetLimitForm(forms.ModelForm):
    month = forms.DateField(
        widget=forms.DateInput(attrs={'type': 'month', 'class': 'form-control'}),
        input_formats=['%Y-%m', '%Y-%m-%d'],
    )
    currency = forms.ChoiceField(choices=CURRENCY_CHOICES, widget=forms.Select(attrs={'class': 'form-select'}))

    class Meta:
        model = BudgetLimit
        fields = ['category', 'month', 'amount', 'currency']
        widgets = {
            'category': forms.Select(attrs={'class': 'form-select'}),
            'amount': forms.NumberInput(attrs={'class': 'form-control', 'step': '0.01'}),
        }

    def clean_month(self):
        val = self.cleaned_data['month']
        if isinstance(val, str):
            val = datetime.datetime.strptime(val + '-01', '%Y-%m-%d').date()
        return val.replace(day=1)


class RecurringExpenseForm(forms.ModelForm):
    currency = forms.ChoiceField(choices=CURRENCY_CHOICES, widget=forms.Select(attrs={'class': 'form-select'}))
    start_date = forms.DateField(
        widget=forms.DateInput(attrs={'type': 'date', 'class': 'form-control'}),
        initial=datetime.date.today
    )
    end_date = forms.DateField(
        required=False,
        widget=forms.DateInput(attrs={'type': 'date', 'class': 'form-control'})
    )

    class Meta:
        model = RecurringExpense
        fields = [
            'name', 'amount', 'currency', 'transaction_type',
            'payment_method', 'to_payment_method', 'category',
            'notes', 'day_of_month', 'is_active', 'start_date', 'end_date'
        ]
        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control'}),
            'amount': forms.NumberInput(attrs={'class': 'form-control', 'step': '0.01'}),
            'transaction_type': forms.Select(attrs={'class': 'form-select'}),
            'payment_method': forms.Select(attrs={'class': 'form-select'}),
            'to_payment_method': forms.Select(attrs={'class': 'form-select'}),
            'category': forms.Select(attrs={'class': 'form-select'}),
            'notes': forms.Textarea(attrs={'class': 'form-control', 'rows': 2}),
            'day_of_month': forms.NumberInput(attrs={'class': 'form-control', 'min': 1, 'max': 28}),
            'is_active': forms.CheckboxInput(attrs={'class': 'form-check-input'}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        active_pms = PaymentMethod.objects.filter(is_active=True)
        self.fields['payment_method'].queryset = active_pms
        self.fields['to_payment_method'].queryset = active_pms
        self.fields['to_payment_method'].required = False
        self.fields['category'].queryset = Category.objects.filter(is_active=True)
        self.fields['category'].required = False


class TransactionTemplateForm(forms.ModelForm):
    currency = forms.ChoiceField(
        choices=CURRENCY_CHOICES,
        widget=forms.Select(attrs={'class': 'form-select form-select-sm'})
    )

    class Meta:
        model = TransactionTemplate
        fields = ['label', 'name', 'amount', 'currency', 'transaction_type', 'payment_method', 'category', 'notes']
        widgets = {
            'label':            forms.TextInput(attrs={'class': 'form-control form-control-sm', 'placeholder': 'e.g. Grab Food'}),
            'name':             forms.TextInput(attrs={'class': 'form-control form-control-sm', 'placeholder': 'Transaction description'}),
            'amount':           forms.NumberInput(attrs={'class': 'form-control form-control-sm', 'step': '0.01'}),
            'transaction_type': forms.Select(attrs={'class': 'form-select form-select-sm'}),
            'payment_method':   forms.Select(attrs={'class': 'form-select form-select-sm'}),
            'category':         forms.Select(attrs={'class': 'form-select form-select-sm'}),
            'notes':            forms.Textarea(attrs={'class': 'form-control form-control-sm', 'rows': 2}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['payment_method'].queryset = PaymentMethod.objects.filter(is_active=True)
        self.fields['payment_method'].required = False
        self.fields['category'].queryset = Category.objects.filter(is_active=True)
        self.fields['category'].required = False


class SharedExpenseForm(forms.ModelForm):
    currency = forms.ChoiceField(
        choices=CURRENCY_CHOICES,
        widget=forms.Select(attrs={'class': 'form-select form-select-sm'})
    )

    class Meta:
        model = SharedExpense
        fields = ['member_name', 'share_amount', 'currency', 'notes']
        widgets = {
            'member_name':  forms.TextInput(attrs={'class': 'form-control form-control-sm', 'placeholder': 'Who shares this?'}),
            'share_amount': forms.NumberInput(attrs={'class': 'form-control form-control-sm', 'step': '0.01'}),
            'notes':        forms.Textarea(attrs={'class': 'form-control form-control-sm', 'rows': 2}),
        }
