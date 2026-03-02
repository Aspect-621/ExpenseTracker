from django.contrib import admin
from .models import Transaction, Category, PaymentMethod, BudgetLimit, RecurringExpense

@admin.register(Transaction)
class TransactionAdmin(admin.ModelAdmin):
    list_display = ['date', 'name', 'transaction_type', 'amount', 'currency', 'payment_method', 'to_payment_method', 'category', 'is_hidden']
    list_filter  = ['transaction_type', 'category', 'payment_method', 'currency', 'is_hidden']
    search_fields = ['name', 'notes']
    date_hierarchy = 'date'

@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ['name', 'color', 'is_active', 'order']

@admin.register(PaymentMethod)
class PaymentMethodAdmin(admin.ModelAdmin):
    list_display = ['name', 'color', 'is_bank_account', 'is_active', 'starting_balance']

@admin.register(BudgetLimit)
class BudgetLimitAdmin(admin.ModelAdmin):
    list_display = ['category', 'month', 'amount', 'currency']

@admin.register(RecurringExpense)
class RecurringExpenseAdmin(admin.ModelAdmin):
    list_display = ['name', 'transaction_type', 'amount', 'currency', 'day_of_month', 'is_active', 'last_added']
