from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.http import JsonResponse, HttpResponse
from django.db.models import Sum, Q
from django.core.paginator import Paginator
import datetime
import json
from decimal import Decimal

from .models import (Transaction, Category, PaymentMethod, BudgetLimit,
                      RecurringExpense, TransactionAuditLog, TransactionTemplate,
                      TransactionAttachment, SharedExpense, UserPreference)
from .forms import (TransactionForm, CategoryForm, PaymentMethodForm, BudgetLimitForm,
                    RecurringExpenseForm, TransactionTemplateForm, SharedExpenseForm)
from .utils import export_to_excel
from django.conf import settings


# ── Helpers ────────────────────────────────────────────────────────────────

def get_visible_transactions(user):
    qs = Transaction.objects.select_related('category', 'payment_method', 'to_payment_method')
    if user.is_admin_user:
        return qs
    qs = qs.filter(is_hidden=False)
    try:
        hidden_ids = list(user.permissions.hidden_payment_methods.values_list('payment_method_id', flat=True))
        if hidden_ids:
            qs = qs.exclude(payment_method_id__in=hidden_ids)
    except Exception:
        pass
    return qs


def get_visible_payment_methods(user):
    qs = PaymentMethod.objects.filter(is_active=True)
    if user.is_admin_user:
        return qs
    try:
        hidden_ids = list(user.permissions.hidden_payment_methods.values_list('payment_method_id', flat=True))
        return qs.exclude(id__in=hidden_ids)
    except Exception:
        return qs


def fetch_live_rate():
    """Fetch live PHP→TWD rate. Returns (live_rate, php_per_twd) or (None, None)."""
    try:
        import urllib.request, json as _json
        with urllib.request.urlopen('https://open.er-api.com/v6/latest/PHP', timeout=4) as r:
            data = _json.loads(r.read())
            rate = round(data['rates']['TWD'], 4)
            inverse = round(1 / rate, 4) if rate else None
            return rate, inverse
    except Exception:
        return None, None


def get_balances_context(user, live_rate=None):
    """Return list of {pm, balance, twd_equivalent} for visible payment methods."""
    pms = get_visible_payment_methods(user)
    balances = []
    total = Decimal('0')
    for pm in pms:
        bal = pm.get_balance()
        twd_equivalent = None
        if pm.currency == 'PHP' and live_rate:
            twd_equivalent = round(float(bal) * float(live_rate), 0)
        balances.append({'pm': pm, 'balance': bal, 'twd_equivalent': twd_equivalent})
        total += bal
    return balances, total


def _log_audit(user, txn, action, old_data=None):
    """Create an audit log entry for a transaction change."""
    import json
    changes = {}
    if action == TransactionAuditLog.ACTION_UPDATE and old_data:
        new_data = {
            'name':             txn.name,
            'amount':           str(txn.amount),
            'currency':         txn.currency,
            'transaction_type': txn.transaction_type,
            'payment_method':   txn.payment_method.name if txn.payment_method else None,
            'category':         txn.category.name if txn.category else None,
            'date':             str(txn.date),
            'notes':            txn.notes,
        }
        for key in new_data:
            if str(old_data.get(key)) != str(new_data[key]):
                changes[key] = {'from': old_data.get(key), 'to': new_data[key]}
    TransactionAuditLog.objects.create(
        transaction_id=txn.pk,
        transaction_name=txn.name,
        user=user if user.is_authenticated else None,
        action=action,
        changes=json.dumps(changes),
    )


# ── Dashboard ───────────────────────────────────────────────────────────────

@login_required
def dashboard(request):
    today = datetime.date.today()
    ms = today.replace(day=1)
    me = ms.replace(month=ms.month % 12 + 1, day=1) if ms.month < 12 else ms.replace(year=ms.year+1, month=1, day=1)

    txns = get_visible_transactions(user=request.user)
    expenses = txns.filter(transaction_type=Transaction.TYPE_EXPENSE)

    this_month_exp = expenses.filter(date__gte=ms, date__lt=me)
    total_this_month = this_month_exp.aggregate(t=Sum('amount'))['t'] or Decimal('0')

    lms = (ms.replace(month=ms.month-1) if ms.month > 1 else ms.replace(year=ms.year-1, month=12))
    total_last_month = expenses.filter(date__gte=lms, date__lt=ms).aggregate(t=Sum('amount'))['t'] or Decimal('0')

    by_category = list(
        this_month_exp.values('category__name', 'category__color')
        .annotate(total=Sum('amount')).order_by('-total')
    )
    by_payment = list(
        this_month_exp.values('payment_method__name', 'payment_method__color')
        .annotate(total=Sum('amount')).order_by('-total')
    )

    monthly_trend = []
    for i in range(5, -1, -1):
        m = today.month - i
        y = today.year
        while m <= 0:
            m += 12; y -= 1
        s = datetime.date(y, m, 1)
        e = datetime.date(y, m % 12 + 1, 1) if m < 12 else datetime.date(y+1, 1, 1)
        t = expenses.filter(date__gte=s, date__lt=e).aggregate(t=Sum('amount'))['t'] or 0
        monthly_trend.append({'month': s.strftime('%b %Y'), 'total': float(t)})

    live_rate, php_per_twd = fetch_live_rate()
    balances, net_worth = get_balances_context(request.user, live_rate=live_rate)

    # Currency breakdown totals
    twd_total = sum(b['balance'] for b in balances if b['pm'].currency == 'TWD')
    php_total = sum(b['balance'] for b in balances if b['pm'].currency == 'PHP')
    php_in_twd = round(float(php_total) * float(live_rate), 2) if live_rate and php_total else None

    budgets = []
    if request.user.is_admin_user or (hasattr(request.user, 'permissions') and request.user.permissions.can_view_budget):
        budgets = BudgetLimit.objects.filter(month=ms).select_related('category')

    recent = txns[:10]

    total_income = txns.filter(
        transaction_type=Transaction.TYPE_INCOME, date__gte=ms, date__lt=me
    ).aggregate(t=Sum('amount'))['t'] or Decimal('0')

    # Total savings from discounts this month and all time
    total_savings_month = this_month_exp.aggregate(
        t=Sum('discount_amount'))['t'] or Decimal('0')
    total_savings_alltime = expenses.aggregate(
        t=Sum('discount_amount'))['t'] or Decimal('0')

    return render(request, 'expenses/dashboard.html', {
        'total_this_month': total_this_month,
        'total_last_month': total_last_month,
        'total_income': total_income,
        'net_this_month': total_income - total_this_month,
        'by_category': by_category,
        'by_payment': by_payment,
        'monthly_trend': json.dumps(monthly_trend),
        'recent': recent,
        'budgets': budgets,
        'balances': balances,
        'net_worth': net_worth,
        'current_month': today.strftime('%B %Y'),
        'currency': settings.DEFAULT_CURRENCY,
        'live_rate': live_rate,
        'php_per_twd': php_per_twd,
        'twd_total': twd_total,
        'php_total': php_total,
        'php_in_twd': php_in_twd,
        'total_savings_month': total_savings_month,
        'total_savings_alltime': total_savings_alltime,
    })


# ── Transaction List ─────────────────────────────────────────────────────────

@login_required
def expense_list(request):
    if not request.user.is_admin_user:
        try:
            if not request.user.permissions.can_view_expenses:
                messages.error(request, "You don't have permission to view transactions.")
                return redirect('dashboard')
        except Exception:
            pass

    qs = get_visible_transactions(request.user)
    search     = request.GET.get('search', '').strip()
    cat_id     = request.GET.get('category', '')
    pm_id      = request.GET.get('payment', '')
    date_from  = request.GET.get('date_from', '')
    date_to    = request.GET.get('date_to', '')
    txn_type   = request.GET.get('type', '')
    sort       = request.GET.get('sort', '-date')

    if search:
        qs = qs.filter(Q(name__icontains=search) | Q(notes__icontains=search))
    if cat_id:
        qs = qs.filter(category_id=cat_id)
    if pm_id:
        qs = qs.filter(Q(payment_method_id=pm_id) | Q(to_payment_method_id=pm_id))
    if date_from:
        try: qs = qs.filter(date__gte=datetime.date.fromisoformat(date_from))
        except ValueError: pass
    if date_to:
        try: qs = qs.filter(date__lte=datetime.date.fromisoformat(date_to))
        except ValueError: pass
    if txn_type:
        qs = qs.filter(transaction_type=txn_type)

    allowed_sorts = ['date','-date','amount','-amount','name','-name']
    if sort in allowed_sorts:
        qs = qs.order_by(sort)

    totals = {
        'expenses': qs.filter(transaction_type=Transaction.TYPE_EXPENSE).aggregate(t=Sum('amount'))['t'] or 0,
        'income':   qs.filter(transaction_type=Transaction.TYPE_INCOME).aggregate(t=Sum('amount'))['t'] or 0,
    }

    paginator = Paginator(qs, 25)
    page = request.GET.get('page', 1)
    transactions = paginator.get_page(page)
    categories      = Category.objects.filter(is_active=True)
    payment_methods = get_visible_payment_methods(request.user)

    return render(request, 'expenses/expense_list.html', {
        'expenses': transactions,
        'categories': categories,
        'payment_methods': payment_methods,
        'totals': totals,
        'count': qs.count(),
        'search': search,
        'selected_category': cat_id,
        'selected_payment': pm_id,
        'selected_type': txn_type,
        'date_from': date_from,
        'date_to': date_to,
        'sort': sort,
        'txn_types': Transaction.TYPE_CHOICES,
        'balances': get_balances_context(request.user)[0],
        'categories': Category.objects.filter(is_active=True),
    })


# ── Add / Edit / Delete ──────────────────────────────────────────────────────

@login_required
def expense_create(request):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied.")
        return redirect('expense_list')
    if request.method == 'POST':
        form = TransactionForm(request.POST)
        if form.is_valid():
            txn = form.save()
            _log_audit(request.user, txn, TransactionAuditLog.ACTION_CREATE)
            messages.success(request, "Transaction added.")
            if request.POST.get('add_another'):
                return redirect('expense_create')
            return redirect('expense_list')
    else:
        form = TransactionForm()
    return render(request, 'expenses/expense_form.html', {
        'form': form, 'title': 'Add Transaction',
        'balances': get_balances_context(request.user)[0],
    })


@login_required
def expense_edit(request, pk):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied.")
        return redirect('expense_list')
    txn = get_object_or_404(Transaction, pk=pk)
    if request.method == 'POST':
        # Capture old data before update for audit diff
        old_data = {
            'name':             txn.name,
            'amount':           str(txn.amount),
            'currency':         txn.currency,
            'transaction_type': txn.transaction_type,
            'payment_method':   txn.payment_method.name if txn.payment_method else None,
            'category':         txn.category.name if txn.category else None,
            'date':             str(txn.date),
            'notes':            txn.notes,
        }
        form = TransactionForm(request.POST, instance=txn)
        if form.is_valid():
            txn = form.save()
            _log_audit(request.user, txn, TransactionAuditLog.ACTION_UPDATE, old_data)
            messages.success(request, "Transaction updated.")
            return redirect('expense_list')
    else:
        form = TransactionForm(instance=txn)
    attachments = txn.attachments.all()
    shared      = txn.shared_with.all()
    return render(request, 'expenses/expense_form.html', {
        'form': form, 'title': 'Edit Transaction', 'expense': txn,
        'balances': get_balances_context(request.user)[0],
        'attachments': attachments,
        'shared': shared,
        'shared_form': SharedExpenseForm(),
    })


@login_required
def expense_delete(request, pk):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied.")
        return redirect('expense_list')
    txn = get_object_or_404(Transaction, pk=pk)
    if request.method == 'POST':
        _log_audit(request.user, txn, TransactionAuditLog.ACTION_DELETE)
        txn.delete()
        messages.success(request, "Transaction deleted.")
    return redirect('expense_list')


@login_required
def expense_toggle_hidden(request, pk):
    if not request.user.is_admin_user:
        return JsonResponse({'error': 'Access denied'}, status=403)
    txn = get_object_or_404(Transaction, pk=pk)
    txn.is_hidden = not txn.is_hidden
    txn.save()
    return JsonResponse({'is_hidden': txn.is_hidden})


@login_required
def expense_export(request):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied.")
        return redirect('expense_list')
    qs = Transaction.objects.select_related('category', 'payment_method', 'to_payment_method').order_by('date')
    search    = request.GET.get('search', '').strip()
    cat_id    = request.GET.get('category', '')
    pm_id     = request.GET.get('payment', '')
    date_from = request.GET.get('date_from', '')
    date_to   = request.GET.get('date_to', '')
    txn_type  = request.GET.get('type', '')
    if search:
        qs = qs.filter(Q(name__icontains=search) | Q(notes__icontains=search))
    if cat_id:  qs = qs.filter(category_id=cat_id)
    if pm_id:   qs = qs.filter(Q(payment_method_id=pm_id) | Q(to_payment_method_id=pm_id))
    if date_from:
        try: qs = qs.filter(date__gte=datetime.date.fromisoformat(date_from))
        except ValueError: pass
    if date_to:
        try: qs = qs.filter(date__lte=datetime.date.fromisoformat(date_to))
        except ValueError: pass
    if txn_type:
        qs = qs.filter(transaction_type=txn_type)
    wb = export_to_excel(qs, PaymentMethod.objects.filter(is_active=True))
    response = HttpResponse(content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
    fname = f"wallet_{datetime.date.today().strftime('%Y%m%d')}.xlsx"
    response['Content-Disposition'] = f'attachment; filename="{fname}"'
    wb.save(response)
    return response


# ── Balance API ──────────────────────────────────────────────────────────────

@login_required
def balance_api(request):
    balances, total = get_balances_context(request.user)
    return JsonResponse({
        'balances': [
            {
                'name': b['pm'].name,
                'balance': float(b['balance']),
                'color': b['pm'].color,
                'currency': b['pm'].currency,
            }
            for b in balances
        ],
        'total': float(total),
    })


# ── Categories ───────────────────────────────────────────────────────────────

@login_required
def categories_list(request):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied."); return redirect('dashboard')
    categories = Category.objects.all()
    form = CategoryForm()
    if request.method == 'POST':
        form = CategoryForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, "Category created.")
            return redirect('categories_list')
    return render(request, 'expenses/categories.html', {'categories': categories, 'form': form})


@login_required
def category_edit(request, pk):
    if not request.user.is_admin_user:
        return JsonResponse({'error': 'Access denied'}, status=403)
    cat = get_object_or_404(Category, pk=pk)
    if request.method == 'POST':
        form = CategoryForm(request.POST, instance=cat)
        if form.is_valid():
            form.save()
            return JsonResponse({'success': True})
        return JsonResponse({'success': False, 'errors': form.errors})
    return JsonResponse({'name': cat.name, 'color': cat.color, 'icon': cat.icon, 'is_active': cat.is_active})


@login_required
def category_delete(request, pk):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied."); return redirect('categories_list')
    cat = get_object_or_404(Category, pk=pk)
    if request.method == 'POST':
        if cat.transactions.exists():
            messages.error(request, f"Cannot delete '{cat.name}' — it has existing transactions.")
        else:
            cat.delete()
            messages.success(request, "Category deleted.")
    return redirect('categories_list')


# ── Payment Methods ──────────────────────────────────────────────────────────

@login_required
def payment_methods_list(request):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied."); return redirect('dashboard')
    methods = PaymentMethod.objects.all()
    form = PaymentMethodForm()
    if request.method == 'POST':
        form = PaymentMethodForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, "Payment method created.")
            return redirect('payment_methods_list')
    return render(request, 'expenses/payment_methods.html', {'methods': methods, 'form': form})


@login_required
def payment_method_edit(request, pk):
    if not request.user.is_admin_user:
        return JsonResponse({'error': 'Access denied'}, status=403)
    method = get_object_or_404(PaymentMethod, pk=pk)
    if request.method == 'POST':
        # Only update the fields the edit modal actually sends — never touch starting_balance
        method.name = request.POST.get('name', method.name).strip()
        method.color = request.POST.get('color', method.color)
        method.is_bank_account = request.POST.get('is_bank_account') in ('true', 'True', '1', 'on')
        method.is_active = request.POST.get('is_active') in ('true', 'True', '1', 'on')
        if not method.name:
            return JsonResponse({'success': False, 'errors': {'name': ['Name is required.']}})
        method.save()
        return JsonResponse({'success': True})
    return JsonResponse({
        'name': method.name, 'color': method.color,
        'is_bank_account': method.is_bank_account,
        'is_active': method.is_active,
        'starting_balance': float(method.starting_balance),
    })


@login_required
def payment_method_delete(request, pk):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied."); return redirect('payment_methods_list')
    method = get_object_or_404(PaymentMethod, pk=pk)
    if request.method == 'POST':
        if method.transactions.exists():
            messages.error(request, f"Cannot delete '{method.name}' — it has existing transactions.")
        else:
            method.delete()
            messages.success(request, "Payment method deleted.")
    return redirect('payment_methods_list')


@login_required
def payment_method_set_balance(request, pk):
    if not request.user.is_admin_user:
        return JsonResponse({'error': 'Access denied'}, status=403)
    pm = get_object_or_404(PaymentMethod, pk=pk)
    if request.method == 'POST':
        try:
            pm.starting_balance = Decimal(str(request.POST.get('starting_balance', 0)))
            date_str = request.POST.get('starting_balance_date', '')
            if date_str:
                pm.starting_balance_date = datetime.date.fromisoformat(date_str)
            pm.save()
            return JsonResponse({'success': True, 'balance': float(pm.starting_balance)})
        except Exception as e:
            return JsonResponse({'success': False, 'error': str(e)})
    return JsonResponse({'error': 'POST required'}, status=405)


# ── Budget ───────────────────────────────────────────────────────────────────

@login_required
def budget_list(request):
    if not request.user.is_admin_user:
        try:
            if not request.user.permissions.can_view_budget:
                messages.error(request, "Access denied."); return redirect('dashboard')
        except Exception:
            messages.error(request, "Access denied."); return redirect('dashboard')

    today = datetime.date.today()
    selected_month = request.GET.get('month', today.strftime('%Y-%m'))
    try:
        month_date = datetime.datetime.strptime(selected_month + '-01', '%Y-%m-%d').date()
    except ValueError:
        month_date = today.replace(day=1)

    budgets  = BudgetLimit.objects.filter(month=month_date).select_related('category')
    form     = BudgetLimitForm(initial={'month': month_date, 'currency': settings.DEFAULT_CURRENCY})

    if request.method == 'POST' and request.user.is_admin_user:
        form = BudgetLimitForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, "Budget limit set.")
            return redirect(f'/budget/?month={selected_month}')

    budget_data = []
    for b in budgets:
        spent = b.get_spent()
        budget_data.append({
            'budget': b, 'spent': spent,
            'remaining': b.amount - spent,
            'percentage': b.percentage, 'status': b.status,
        })

    return render(request, 'expenses/budget.html', {
        'budget_data': budget_data,
        'categories': Category.objects.filter(is_active=True),
        'form': form,
        'selected_month': selected_month,
        'month_date': month_date,
        'currencies': settings.SUPPORTED_CURRENCIES,
    })


@login_required
def budget_delete(request, pk):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied."); return redirect('budget_list')
    budget = get_object_or_404(BudgetLimit, pk=pk)
    month_str = budget.month.strftime('%Y-%m')
    if request.method == 'POST':
        budget.delete()
        messages.success(request, "Budget limit removed.")
    return redirect(f'/budget/?month={month_str}')


# ── Recurring ────────────────────────────────────────────────────────────────

@login_required
def recurring_list(request):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied."); return redirect('dashboard')
    recurring = RecurringExpense.objects.select_related('category', 'payment_method', 'to_payment_method')
    form = RecurringExpenseForm()
    if request.method == 'POST':
        form = RecurringExpenseForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, "Recurring transaction created.")
            return redirect('recurring_list')
    return render(request, 'expenses/recurring.html', {'recurring': recurring, 'form': form})


@login_required
def recurring_edit(request, pk):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied."); return redirect('recurring_list')
    rec = get_object_or_404(RecurringExpense, pk=pk)
    form = RecurringExpenseForm(request.POST or None, instance=rec)
    if request.method == 'POST' and form.is_valid():
        form.save()
        messages.success(request, "Updated.")
        return redirect('recurring_list')
    return render(request, 'expenses/expense_form.html', {'form': form, 'title': 'Edit Recurring', 'balances': []})


@login_required
def recurring_delete(request, pk):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied."); return redirect('recurring_list')
    rec = get_object_or_404(RecurringExpense, pk=pk)
    if request.method == 'POST':
        rec.delete()
        messages.success(request, "Deleted.")
    return redirect('recurring_list')


# ── PH Withdrawal ────────────────────────────────────────────────────────────

@login_required
def ph_withdrawal(request):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied.")
        return redirect('dashboard')

    php_accounts = PaymentMethod.objects.filter(currency='PHP', is_active=True)
    twd_cash_account = PaymentMethod.objects.filter(name__icontains='cash', currency='TWD').first()
    php_cash_accounts = PaymentMethod.objects.filter(
        currency='PHP', is_active=True, name__iregex=r'(cash|wallet)'
    )
    live_rate, php_per_twd = fetch_live_rate()

    if request.method == 'POST':
        mode          = request.POST.get('mode', 'twd')
        ph_account_id = request.POST.get('ph_account')
        php_amount    = request.POST.get('php_amount')
        exchange_rate = request.POST.get('exchange_rate')
        to_account_id = request.POST.get('to_account')
        date_str      = request.POST.get('date')
        notes         = request.POST.get('notes', '')
        errs = []

        if not ph_account_id: errs.append("Select a PH source account.")
        if not php_amount:    errs.append("Enter PHP amount.")
        if mode == 'twd' and not exchange_rate: errs.append("Enter exchange rate.")
        if mode == 'php' and not to_account_id: errs.append("Select a PHP cash destination.")

        if not errs:
            try:
                ph_acc   = PaymentMethod.objects.get(pk=ph_account_id, currency='PHP')
                php_amt  = Decimal(str(php_amount))
                txn_date = datetime.date.fromisoformat(date_str) if date_str else datetime.date.today()
                gen_cat  = Category.objects.filter(name='General').first()

                if mode == 'twd':
                    rate    = Decimal(str(exchange_rate))
                    twd_amt = (php_amt * rate).quantize(Decimal('0.01'))
                    dest    = twd_cash_account
                    log1 = Transaction.objects.create(
                        date=txn_date,
                        name=f"ATM Withdrawal → TWD ({ph_acc.name})",
                        amount=php_amt, currency='PHP',
                        transaction_type=Transaction.TYPE_PH_WITHDRAWAL,
                        payment_method=ph_acc, category=gen_cat,
                        exchange_rate=rate, converted_amount=twd_amt, notes=notes,
                    )
                    log2 = Transaction.objects.create(
                        date=txn_date,
                        name=f"Cash (TWD) from {ph_acc.name} (₱{php_amt} × {rate})",
                        amount=twd_amt, currency='TWD',
                        transaction_type=Transaction.TYPE_INCOME,
                        payment_method=dest, category=gen_cat, notes=notes,
                    )
                    log1.paired_transaction = log2
                    log1.save()
                    messages.success(request, f"✅ ₱{php_amt} → TWD {twd_amt} logged! (rate: {rate})")

                else:
                    to_acc = PaymentMethod.objects.get(pk=to_account_id, currency='PHP')
                    if ph_acc == to_acc:
                        raise ValueError("Source and destination cannot be the same account.")
                    log1 = Transaction.objects.create(
                        date=txn_date,
                        name=f"Cash Withdrawal → PHP Wallet ({ph_acc.name})",
                        amount=php_amt, currency='PHP',
                        transaction_type=Transaction.TYPE_PH_WITHDRAWAL,
                        payment_method=ph_acc, category=gen_cat, notes=notes,
                    )
                    log2 = Transaction.objects.create(
                        date=txn_date,
                        name=f"Cash (PHP) from {ph_acc.name}",
                        amount=php_amt, currency='PHP',
                        transaction_type=Transaction.TYPE_INCOME,
                        payment_method=to_acc, category=gen_cat, notes=notes,
                    )
                    log1.paired_transaction = log2
                    log1.save()
                    messages.success(request, f"✅ ₱{php_amt} moved from {ph_acc.name} → {to_acc.name}")

                return redirect('ph_withdrawal')

            except Exception as e:
                errs.append(str(e))
        for e in errs:
            messages.error(request, e)

    history = Transaction.objects.filter(
        transaction_type=Transaction.TYPE_PH_WITHDRAWAL
    ).select_related('payment_method', 'paired_transaction__payment_method').order_by('-date', '-created_at')[:15]

    return render(request, 'expenses/ph_withdrawal.html', {
        'php_accounts': php_accounts,
        'php_cash_accounts': php_cash_accounts,
        'twd_cash_account': twd_cash_account,
        'live_rate': live_rate,
        'php_per_twd': php_per_twd,
        'today': datetime.date.today().isoformat(),
        'balances': get_balances_context(request.user, live_rate=live_rate)[0],
        'history': history,
    })


# ── TW Withdrawal ────────────────────────────────────────────────────────────

@login_required
def tw_withdrawal(request):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied.")
        return redirect('dashboard')

    twd_accounts = PaymentMethod.objects.filter(
        currency='TWD', is_active=True
    ).exclude(name__icontains='cash')
    twd_cash_account = PaymentMethod.objects.filter(name__icontains='cash', currency='TWD').first()
    php_cash_accounts = PaymentMethod.objects.filter(
        currency='PHP', is_active=True, name__iregex=r'(cash|wallet)'
    )
    live_rate, php_per_twd = fetch_live_rate()

    if request.method == 'POST':
        mode          = request.POST.get('mode', 'twd')
        tw_account_id = request.POST.get('tw_account')
        twd_amount    = request.POST.get('twd_amount')
        exchange_rate = request.POST.get('exchange_rate')
        to_account_id = request.POST.get('to_account')
        date_str      = request.POST.get('date')
        notes         = request.POST.get('notes', '')
        errs = []

        if not tw_account_id: errs.append("Select a TW source account.")
        if not twd_amount:    errs.append("Enter TWD amount.")
        if mode == 'php' and not exchange_rate: errs.append("Enter exchange rate.")
        if mode == 'php' and not to_account_id: errs.append("Select a PHP cash destination.")

        if not errs:
            try:
                tw_acc   = PaymentMethod.objects.get(pk=tw_account_id, currency='TWD')
                twd_amt  = Decimal(str(twd_amount))
                txn_date = datetime.date.fromisoformat(date_str) if date_str else datetime.date.today()
                gen_cat  = Category.objects.filter(name='General').first()

                if mode == 'twd':
                    dest = twd_cash_account
                    log1 = Transaction.objects.create(
                        date=txn_date,
                        name=f"ATM Withdrawal → TWD Cash ({tw_acc.name})",
                        amount=twd_amt, currency='TWD',
                        transaction_type=Transaction.TYPE_TW_WITHDRAWAL,
                        payment_method=tw_acc, category=gen_cat, notes=notes,
                    )
                    log2 = Transaction.objects.create(
                        date=txn_date,
                        name=f"Cash (TWD) from {tw_acc.name}",
                        amount=twd_amt, currency='TWD',
                        transaction_type=Transaction.TYPE_INCOME,
                        payment_method=dest, category=gen_cat, notes=notes,
                    )
                    log1.paired_transaction = log2
                    log1.save()
                    messages.success(request, f"✅ TWD {twd_amt} moved from {tw_acc.name} → {dest.name}")

                else:
                    rate    = Decimal(str(exchange_rate))
                    php_amt = (twd_amt * rate).quantize(Decimal('0.01'))
                    to_acc  = PaymentMethod.objects.get(pk=to_account_id, currency='PHP')
                    log1 = Transaction.objects.create(
                        date=txn_date,
                        name=f"ATM Withdrawal → PHP Wallet ({tw_acc.name})",
                        amount=twd_amt, currency='TWD',
                        transaction_type=Transaction.TYPE_TW_WITHDRAWAL,
                        payment_method=tw_acc, category=gen_cat,
                        exchange_rate=rate, converted_amount=php_amt, notes=notes,
                    )
                    log2 = Transaction.objects.create(
                        date=txn_date,
                        name=f"Cash (PHP) from {tw_acc.name} (TWD {twd_amt} × {rate})",
                        amount=php_amt, currency='PHP',
                        transaction_type=Transaction.TYPE_INCOME,
                        payment_method=to_acc, category=gen_cat, notes=notes,
                    )
                    log1.paired_transaction = log2
                    log1.save()
                    messages.success(request, f"✅ TWD {twd_amt} → ₱{php_amt} logged! (rate: {rate})")

                return redirect('tw_withdrawal')

            except Exception as e:
                errs.append(str(e))
        for e in errs:
            messages.error(request, e)

    history = Transaction.objects.filter(
        transaction_type=Transaction.TYPE_TW_WITHDRAWAL
    ).select_related('payment_method', 'paired_transaction__payment_method').order_by('-date', '-created_at')[:15]

    return render(request, 'expenses/tw_withdrawal.html', {
        'twd_accounts': twd_accounts,
        'php_cash_accounts': php_cash_accounts,
        'twd_cash_account': twd_cash_account,
        'live_rate': live_rate,
        'php_per_twd': php_per_twd,
        'today': datetime.date.today().isoformat(),
        'balances': get_balances_context(request.user, live_rate=live_rate)[0],
        'history': history,
    })


# ── Audit Log ────────────────────────────────────────────────────────────────

@login_required
def audit_log(request):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied.")
        return redirect('dashboard')
    logs = TransactionAuditLog.objects.select_related('user').order_by('-timestamp')
    txn_id = request.GET.get('txn')
    if txn_id:
        logs = logs.filter(transaction_id=txn_id)
    paginator = Paginator(logs, 50)
    page = request.GET.get('page', 1)
    return render(request, 'expenses/audit_log.html', {
        'logs': paginator.get_page(page),
        'txn_filter': txn_id,
    })


# ── Templates ─────────────────────────────────────────────────────────────────

@login_required
def template_list(request):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied.")
        return redirect('dashboard')
    templates = TransactionTemplate.objects.select_related('payment_method', 'category')
    form = TransactionTemplateForm()
    if request.method == 'POST':
        form = TransactionTemplateForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, "Template created.")
            return redirect('template_list')
    return render(request, 'expenses/templates_list.html', {
        'templates': templates, 'form': form,
    })


@login_required
def template_delete(request, pk):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied.")
        return redirect('template_list')
    tpl = get_object_or_404(TransactionTemplate, pk=pk)
    if request.method == 'POST':
        tpl.delete()
        messages.success(request, "Template deleted.")
    return redirect('template_list')


@login_required
def template_quick_add(request, pk):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied.")
        return redirect('template_list')
    tpl = get_object_or_404(TransactionTemplate, pk=pk)
    if request.method == 'POST':
        txn = Transaction.objects.create(
            date=datetime.date.today(),
            name=tpl.name,
            amount=tpl.amount,
            currency=tpl.currency,
            transaction_type=tpl.transaction_type,
            payment_method=tpl.payment_method,
            category=tpl.category,
            notes=tpl.notes,
        )
        _log_audit(request.user, txn, TransactionAuditLog.ACTION_CREATE)
        messages.success(request, f"✅ '{tpl.label}' added as transaction.")
    return redirect('expense_list')


# ── Attachments ───────────────────────────────────────────────────────────────

@login_required
def attachment_upload(request, txn_pk):
    if not request.user.is_admin_user:
        return JsonResponse({'error': 'Access denied'}, status=403)
    txn = get_object_or_404(Transaction, pk=txn_pk)
    if request.method == 'POST' and request.FILES.get('file'):
        f = request.FILES['file']
        att = TransactionAttachment.objects.create(
            transaction=txn,
            file=f,
            original_name=f.name,
        )
        return JsonResponse({
            'success': True,
            'id': att.pk,
            'name': att.original_name,
            'size_kb': att.file_size_kb,
            'is_image': att.is_image,
            'url': att.file.url,
        })
    return JsonResponse({'error': 'No file'}, status=400)


@login_required
def attachment_delete(request, pk):
    if not request.user.is_admin_user:
        return JsonResponse({'error': 'Access denied'}, status=403)
    att = get_object_or_404(TransactionAttachment, pk=pk)
    if request.method == 'POST':
        try:
            att.file.delete(save=False)
        except Exception:
            pass
        att.delete()
        return JsonResponse({'success': True})
    return JsonResponse({'error': 'POST required'}, status=405)


# ── Shared Expenses ───────────────────────────────────────────────────────────

@login_required
def shared_expense_list(request):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied.")
        return redirect('dashboard')
    unsettled = SharedExpense.objects.filter(is_settled=False).select_related('transaction')
    settled   = SharedExpense.objects.filter(is_settled=True).select_related('transaction').order_by('-settled_date')[:30]
    return render(request, 'expenses/shared_expenses.html', {
        'unsettled': unsettled,
        'settled': settled,
    })


@login_required
def shared_expense_create(request, txn_pk):
    if not request.user.is_admin_user:
        return JsonResponse({'error': 'Access denied'}, status=403)
    txn = get_object_or_404(Transaction, pk=txn_pk)
    if request.method == 'POST':
        form = SharedExpenseForm(request.POST)
        if form.is_valid():
            se = form.save(commit=False)
            se.transaction = txn
            se.currency = txn.currency
            se.save()
            return JsonResponse({
                'success': True,
                'id': se.pk,
                'member_name': se.member_name,
                'share_amount': str(se.share_amount),
                'currency': se.currency,
            })
        return JsonResponse({'success': False, 'errors': form.errors})
    return JsonResponse({'error': 'POST required'}, status=405)


@login_required
def shared_expense_settle(request, pk):
    if not request.user.is_admin_user:
        return JsonResponse({'error': 'Access denied'}, status=403)
    se = get_object_or_404(SharedExpense, pk=pk)
    if request.method == 'POST':
        se.is_settled = not se.is_settled
        se.settled_date = datetime.date.today() if se.is_settled else None
        se.save()
        return JsonResponse({'success': True, 'is_settled': se.is_settled})
    return JsonResponse({'error': 'POST required'}, status=405)


@login_required
def shared_expense_delete(request, pk):
    if not request.user.is_admin_user:
        return JsonResponse({'error': 'Access denied'}, status=403)
    se = get_object_or_404(SharedExpense, pk=pk)
    if request.method == 'POST':
        se.delete()
        return JsonResponse({'success': True})
    return JsonResponse({'error': 'POST required'}, status=405)


# ── User Preferences ──────────────────────────────────────────────────────────

@login_required
def save_preference(request):
    if request.method == 'POST':
        pref, _ = UserPreference.objects.get_or_create(user=request.user)
        theme = request.POST.get('theme', 'dark')
        if theme in ('dark', 'light'):
            pref.theme = theme
            pref.save()
        return JsonResponse({'success': True, 'theme': pref.theme})
    return JsonResponse({'error': 'POST required'}, status=405)


# ── Duplicate Detection ───────────────────────────────────────────────────────

@login_required
def duplicate_check(request):
    amount     = request.GET.get('amount')
    pm_id      = request.GET.get('payment_method')
    date_str   = request.GET.get('date')
    exclude_pk = request.GET.get('exclude')
    if not all([amount, pm_id, date_str]):
        return JsonResponse({'duplicate': False})
    try:
        check_date = datetime.date.fromisoformat(date_str)
        qs = Transaction.objects.filter(
            amount=Decimal(str(amount)),
            payment_method_id=pm_id,
            date=check_date,
            transaction_type=Transaction.TYPE_EXPENSE,
        )
        if exclude_pk:
            qs = qs.exclude(pk=exclude_pk)
        duplicate = qs.first()
        if duplicate:
            return JsonResponse({
                'duplicate': True,
                'name': duplicate.name,
                'date': str(duplicate.date),
            })
    except Exception:
        pass
    return JsonResponse({'duplicate': False})


# ── Bulk Actions ──────────────────────────────────────────────────────────────

@login_required
def expense_bulk_action(request):
    if not request.user.is_admin_user:
        return JsonResponse({'error': 'Access denied'}, status=403)
    if request.method != 'POST':
        return JsonResponse({'error': 'POST required'}, status=405)

    pks    = request.POST.getlist('pks')
    action = request.POST.get('action')

    if not pks or not action:
        return JsonResponse({'error': 'Missing pks or action'}, status=400)

    qs = Transaction.objects.filter(pk__in=pks)

    if action == 'delete':
        for txn in qs:
            _log_audit(request.user, txn, TransactionAuditLog.ACTION_DELETE)
        count = qs.count()
        qs.delete()
        return JsonResponse({'success': True, 'message': f'Deleted {count} transactions.'})

    elif action == 'hide':
        count = qs.update(is_hidden=True)
        return JsonResponse({'success': True, 'message': f'Hidden {count} transactions.'})

    elif action == 'show':
        count = qs.update(is_hidden=False)
        return JsonResponse({'success': True, 'message': f'Unhidden {count} transactions.'})

    elif action == 'recategorize':
        cat_id = request.POST.get('category_id')
        if not cat_id:
            return JsonResponse({'error': 'No category selected'}, status=400)
        cat = get_object_or_404(Category, pk=cat_id)
        count = qs.update(category=cat)
        return JsonResponse({'success': True, 'message': f'Recategorized {count} transactions to {cat.name}.'})

    return JsonResponse({'error': 'Unknown action'}, status=400)


# ── Backup & Restore ─────────────────────────────────────────────────────────

import os, glob, subprocess
BACKUP_DIR = '/app/backups'


def _get_backup_files():
    """Return list of backup dicts sorted newest first."""
    os.makedirs(BACKUP_DIR, exist_ok=True)
    files = []
    for f in glob.glob(os.path.join(BACKUP_DIR, 'backup_*.sql')):
        stat = os.stat(f)
        files.append({
            'filename': os.path.basename(f),
            'size_kb': round(stat.st_size / 1024, 1),
            'modified': datetime.datetime.fromtimestamp(stat.st_mtime),
        })
    return sorted(files, key=lambda x: x['modified'], reverse=True)


def _run_backup(label='manual'):
    from apps.expenses.management.commands.run_scheduler import Command as Sched
    return Sched.run_backup(label=label)


def _run_restore(filepath):
    """Restore a .sql file into the database. Returns (success, error_msg)."""
    env = os.environ.copy()
    env['PGPASSWORD'] = os.environ.get('POSTGRES_PASSWORD', 'expensepass')
    cmd = [
        'psql',
        '-h', os.environ.get('POSTGRES_HOST', 'db'),
        '-p', os.environ.get('POSTGRES_PORT', '5432'),
        '-U', os.environ.get('POSTGRES_USER', 'expenseuser'),
        '-d', os.environ.get('POSTGRES_DB', 'expensetracker'),
        '-f', filepath,
        '--no-password',
    ]
    try:
        result = subprocess.run(cmd, env=env, capture_output=True, text=True, timeout=180)
        if result.returncode == 0:
            return True, ''
        return False, result.stderr.strip()
    except Exception as e:
        return False, str(e)


@login_required
def backup_list(request):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied.")
        return redirect('dashboard')
    return render(request, 'expenses/backup.html', {
        'backups': _get_backup_files(),
        'backup_dir': BACKUP_DIR,
    })


@login_required
def backup_now(request):
    if not request.user.is_admin_user:
        return redirect('dashboard')
    if request.method == 'POST':
        success, result = _run_backup(label='manual')
        if success:
            messages.success(request, f"✅ Backup created: {os.path.basename(result)}")
        else:
            messages.error(request, f"❌ Backup failed: {result}")
    return redirect('backup_list')


@login_required
def backup_download(request, filename):
    if not request.user.is_admin_user:
        return redirect('dashboard')
    # Sanitise — only allow safe filenames
    safe = os.path.basename(filename)
    filepath = os.path.join(BACKUP_DIR, safe)
    if not os.path.exists(filepath) or not safe.endswith('.sql'):
        messages.error(request, "Backup file not found.")
        return redirect('backup_list')
    with open(filepath, 'rb') as f:
        response = HttpResponse(f.read(), content_type='application/octet-stream')
        response['Content-Disposition'] = f'attachment; filename="{safe}"'
        return response


@login_required
def backup_restore(request, filename):
    if not request.user.is_admin_user:
        return redirect('dashboard')
    if request.method != 'POST':
        return redirect('backup_list')

    confirm_word = request.POST.get('confirm_word', '').strip()
    password     = request.POST.get('password', '')

    if confirm_word != 'DELETE':
        messages.error(request, "❌ You must type DELETE to confirm.")
        return redirect('backup_list')
    if not request.user.check_password(password):
        messages.error(request, "❌ Wrong password.")
        return redirect('backup_list')

    safe = os.path.basename(filename)
    filepath = os.path.join(BACKUP_DIR, safe)
    if not os.path.exists(filepath):
        messages.error(request, "Backup file not found.")
        return redirect('backup_list')

    # Auto-backup before restoring
    pre_success, pre_path = _run_backup(label='pre-restore')
    if pre_success:
        messages.info(request, f"📦 Safety backup created: {os.path.basename(pre_path)}")

    success, err = _run_restore(filepath)
    if success:
        messages.success(request, f"✅ Restored from {safe} successfully.")
        return redirect('dashboard')
    else:
        messages.error(request, f"❌ Restore failed: {err}")
        return redirect('backup_list')


@login_required
def backup_import_sql(request):
    if not request.user.is_admin_user:
        return redirect('dashboard')
    if request.method != 'POST':
        return redirect('backup_list')

    confirm_word = request.POST.get('confirm_word', '').strip()
    password     = request.POST.get('password', '')
    sql_file     = request.FILES.get('sql_file')

    if not sql_file:
        messages.error(request, "No file uploaded.")
        return redirect('backup_list')
    if not sql_file.name.endswith('.sql'):
        messages.error(request, "Only .sql files are accepted.")
        return redirect('backup_list')
    if confirm_word != 'DELETE':
        messages.error(request, "❌ You must type DELETE to confirm.")
        return redirect('backup_list')
    if not request.user.check_password(password):
        messages.error(request, "❌ Wrong password.")
        return redirect('backup_list')

    # Save uploaded file temporarily
    import tempfile
    with tempfile.NamedTemporaryFile(delete=False, suffix='.sql', dir=BACKUP_DIR) as tmp:
        for chunk in sql_file.chunks():
            tmp.write(chunk)
        tmp_path = tmp.name

    # Auto-backup before importing
    pre_success, pre_path = _run_backup(label='pre-import')
    if pre_success:
        messages.info(request, f"📦 Safety backup created: {os.path.basename(pre_path)}")

    success, err = _run_restore(tmp_path)
    os.unlink(tmp_path)

    if success:
        messages.success(request, f"✅ SQL import from '{sql_file.name}' completed.")
        return redirect('dashboard')
    else:
        messages.error(request, f"❌ SQL import failed: {err}")
        return redirect('backup_list')


@login_required
def backup_import_excel(request):
    if not request.user.is_admin_user:
        return redirect('dashboard')
    if request.method != 'POST':
        return redirect('backup_list')

    xlsx_file  = request.FILES.get('xlsx_file')
    mode       = request.POST.get('mode', 'append')
    preview    = request.POST.get('preview', '')
    saved_path = request.POST.get('tmp_path', '')   # set after preview

    import tempfile, openpyxl
    from decimal import Decimal as D
    from apps.expenses.models import Transaction, PaymentMethod, Category

    # Confirm flow: reuse already-saved temp file
    if not xlsx_file and saved_path and os.path.exists(saved_path):
        tmp_path       = saved_path
        orig_filename  = request.POST.get('original_filename', 'import.xlsx')
    elif xlsx_file:
        if not xlsx_file.name.endswith('.xlsx'):
            messages.error(request, "Only .xlsx files are accepted.")
            return redirect('backup_list')
        with tempfile.NamedTemporaryFile(delete=False, suffix='.xlsx') as tmp:
            for chunk in xlsx_file.chunks():
                tmp.write(chunk)
            tmp_path = tmp.name
        orig_filename = xlsx_file.name
    else:
        messages.error(request, "No file uploaded.")
        return redirect('backup_list')

    try:
        wb = openpyxl.load_workbook(tmp_path, data_only=True)
    except Exception as e:
        os.unlink(tmp_path)
        messages.error(request, f"Could not open file: {e}")
        return redirect('backup_list')

    # Collect preview rows from all sheets
    # New 11-col format: Date|Description|Payment Method|Category|Amount|Currency|Transaction Type|To Account|Exchange Rate|Notes|Flag
    # Legacy 5-col format: Date|Name|Payment Method|Category|Amount
    preview_rows = []
    all_rows = []
    for sheet_name in wb.sheetnames:
        if sheet_name.lower() in ('legend',):
            continue
        ws = wb[sheet_name]
        for row in ws.iter_rows(min_row=2, values_only=True):
            if not row or len(row) < 5:
                continue
            if not row[1] or not row[2] or row[4] is None:
                continue
            if str(row[1]).strip().lower() in ('name', 'description', 'date', ''):
                continue
            txn_type_override = str(row[6]).strip().lower() if len(row) > 6 and row[6] else ''
            to_account        = str(row[7]).strip()         if len(row) > 7 and row[7] else ''
            exchange_rate     = row[8]                      if len(row) > 8 else None
            discount_amount   = row[9]                      if len(row) > 9 and row[9] else None
            currency          = str(row[5]).strip()         if len(row) > 5 and row[5] else 'TWD'
            all_rows.append({
                'sheet':         sheet_name,
                'date':          str(row[0])[:10] if row[0] else '—',
                'name':          str(row[1]).strip(),
                'pm':            str(row[2]).strip(),
                'cat':           str(row[3]).strip() if row[3] else 'General',
                'amount':        row[4],
                'currency':      currency,
                'txn_type':      txn_type_override,
                'to_account':    to_account,
                'exchange_rate': exchange_rate,
                'discount_amount': discount_amount,
            })

    preview_rows = all_rows[:10]
    total_rows   = len(all_rows)

    if preview == 'yes':
        # Keep temp file — pass its path to the confirm form
        return render(request, 'expenses/backup.html', {
            'backups': _get_backup_files(),
            'preview_rows': preview_rows,
            'total_rows': total_rows,
            'preview_mode': True,
            'mode': mode,
            'original_filename': orig_filename,
            'tmp_path': tmp_path,
        })

    # ── Actually import ───────────────────────────────────────────────────────
    from apps.expenses.management.commands.import_excel import classify, resolve_transfer_accounts

    pm_map  = {pm.name: pm for pm in PaymentMethod.objects.all()}
    cat_map = {c.name: c  for c in Category.objects.all()}
    gen_cat, _ = Category.objects.get_or_create(
        name='General', defaults={'color': '#6c757d', 'icon': 'bag', 'order': 3}
    )
    inc_cat, _ = Category.objects.get_or_create(
        name='Income', defaults={'color': '#198754', 'icon': 'cash-stack', 'order': 4}
    )

    if mode == 'clear':
        # Auto-backup before clearing
        pre_success, pre_path = _run_backup(label='pre-excel-import')
        if pre_success:
            messages.info(request, f"📦 Safety backup created: {os.path.basename(pre_path)}")
        Transaction.objects.all().delete()

    imported = errors = 0
    for row in all_rows:
        pm = pm_map.get(row['pm'])
        if not pm:
            errors += 1
            continue
        cat     = cat_map.get(row['cat'], gen_cat)
        amount  = float(row['amount'])
        abs_amt = abs(amount)

        # Use explicit txn_type from file if present, else auto-classify
        txn_type_raw = row.get('txn_type', '')
        valid_types  = ('expense', 'income', 'transfer', 'topup', 'ph_withdrawal', 'tw_withdrawal')
        if txn_type_raw in valid_types:
            txn_type = txn_type_raw
        else:
            txn_type = classify(row['name'], amount)

        from_pm = pm
        to_pm   = None

        if txn_type == 'transfer':
            # Use explicit to_account if provided
            to_acc_name = row.get('to_account', '')
            if to_acc_name:
                to_pm = pm_map.get(to_acc_name)
            if not to_pm:
                from_pm, to_pm = resolve_transfer_accounts(row['name'], amount, row['pm'], pm_map)
                if not from_pm:
                    from_pm = pm
            cat = gen_cat

        if txn_type == 'income':
            cat = inc_cat

        currency = row.get('currency', 'TWD') or 'TWD'

        try:
            raw_date = row['date']
            if isinstance(raw_date, str):
                try:
                    txn_date = datetime.date.fromisoformat(raw_date)
                except Exception:
                    txn_date = datetime.date.today()
            else:
                txn_date = datetime.date.today()

            discount_val = row.get('discount_amount')
            discount_dec = D(str(abs(float(discount_val)))) if discount_val else None
            Transaction.objects.create(
                date=txn_date, name=row['name'],
                amount=D(str(abs_amt)), currency=currency,
                transaction_type=txn_type,
                payment_method=from_pm,
                to_payment_method=to_pm,
                category=cat, notes='',
                discount_amount=discount_dec,
            )
            imported += 1
        except Exception:
            errors += 1

    os.unlink(tmp_path)
    messages.success(request, f"✅ Excel import complete: {imported} imported, {errors} errors.")
    return redirect('expense_list')


# ── Delete All Data ──────────────────────────────────────────────────────────

@login_required
def delete_all_data(request):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied.")
        return redirect('dashboard')
    if request.method == 'POST':
        password = request.POST.get('password', '')
        if request.user.check_password(password):
            count = Transaction.objects.count()
            Transaction.objects.all().delete()
            messages.success(request, f"✅ {count} transactions deleted.")
        else:
            messages.error(request, "❌ Wrong password. Nothing deleted.")
    return redirect('dashboard')
