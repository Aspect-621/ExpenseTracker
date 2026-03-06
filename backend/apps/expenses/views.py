from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.http import JsonResponse, HttpResponse
from django.db.models import Sum, Q
from django.core.paginator import Paginator
import datetime
import json
from decimal import Decimal

from .models import Transaction, Category, PaymentMethod, BudgetLimit, RecurringExpense
from .forms import TransactionForm, CategoryForm, PaymentMethodForm, BudgetLimitForm, RecurringExpenseForm
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


def get_balances_context(user):
    """Return list of {pm, balance} for visible payment methods."""
    pms = get_visible_payment_methods(user)
    balances = []
    total = Decimal('0')
    for pm in pms:
        bal = pm.get_balance()
        balances.append({'pm': pm, 'balance': bal})
        total += bal
    return balances, total


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

    # Last month
    lms = (ms.replace(month=ms.month-1) if ms.month > 1 else ms.replace(year=ms.year-1, month=12))
    total_last_month = expenses.filter(date__gte=lms, date__lt=ms).aggregate(t=Sum('amount'))['t'] or Decimal('0')

    # By category this month
    by_category = list(
        this_month_exp.values('category__name', 'category__color')
        .annotate(total=Sum('amount')).order_by('-total')
    )

    # By payment method this month (expenses only)
    by_payment = list(
        this_month_exp.values('payment_method__name', 'payment_method__color')
        .annotate(total=Sum('amount')).order_by('-total')
    )

    # 6 month trend
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

    # Balances
    balances, net_worth = get_balances_context(request.user)

    # Budget
    budgets = []
    if request.user.is_admin_user or (hasattr(request.user, 'permissions') and request.user.permissions.can_view_budget):
        budgets = BudgetLimit.objects.filter(month=ms).select_related('category')

    recent = txns[:10]

    # Income this month
    total_income = txns.filter(
        transaction_type=Transaction.TYPE_INCOME, date__gte=ms, date__lt=me
    ).aggregate(t=Sum('amount'))['t'] or Decimal('0')

    # Live PHP->TWD rate
    live_rate = None
    php_per_twd = None
    try:
        import urllib.request, json as _json
        with urllib.request.urlopen('https://open.er-api.com/v6/latest/PHP', timeout=3) as r:
            data = _json.loads(r.read())
            live_rate = round(data['rates']['TWD'], 4)
            php_per_twd = round(1 / live_rate, 4) if live_rate else None
    except Exception:
        pass

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

    # Filters
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

    allowed_sorts = ['date', '-date', 'amount', '-amount', 'name', '-name']
    if sort in allowed_sorts:
        qs = qs.order_by(sort)

    # Totals by type
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
    })


# ── Add / Edit / Delete ──────────────────────────────────────────────────────

def _handle_transfer_paired_logs(txn):
    """
    For Transfer / Top-up transactions saved via the regular form,
    ensure balances reflect correctly.  These types rely solely on
    payment_method (source) and to_payment_method (destination) being
    set — get_balance() already handles the maths, so no extra DB rows
    are needed.  This hook is here as a future extension point.
    """
    pass


@login_required
def expense_create(request):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied.")
        return redirect('expense_list')
    if request.method == 'POST':
        form = TransactionForm(request.POST)
        if form.is_valid():
            txn = form.save()
            _handle_transfer_paired_logs(txn)
            messages.success(request, "Transaction added.")
            if request.POST.get('add_another'):
                return redirect('expense_create')
            return redirect('expense_list')
    else:
        form = TransactionForm()
    return render(request, 'expenses/expense_form.html', {
        'form': form,
        'title': 'Add Transaction',
        'balances': get_balances_context(request.user)[0],
    })


@login_required
def expense_edit(request, pk):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied.")
        return redirect('expense_list')
    txn = get_object_or_404(Transaction, pk=pk)
    if request.method == 'POST':
        form = TransactionForm(request.POST, instance=txn)
        if form.is_valid():
            txn = form.save()
            _handle_transfer_paired_logs(txn)
            messages.success(request, "Transaction updated.")
            return redirect('expense_list')
    else:
        form = TransactionForm(instance=txn)
    return render(request, 'expenses/expense_form.html', {
        'form': form,
        'title': 'Edit Transaction',
        'expense': txn,
        'balances': get_balances_context(request.user)[0],
    })


@login_required
def expense_delete(request, pk):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied.")
        return redirect('expense_list')
    txn = get_object_or_404(Transaction, pk=pk)
    if request.method == 'POST':
        # Also delete paired transaction if it exists
        if hasattr(txn, 'paired_transaction') and txn.paired_transaction:
            txn.paired_transaction.delete()
        if hasattr(txn, 'pair') and txn.pair:
            txn.pair.delete()
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
    # Apply same filters
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
                'id': b['pm'].id,
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
        form = PaymentMethodForm(request.POST, instance=method)
        if form.is_valid():
            form.save()
            return JsonResponse({'success': True})
        return JsonResponse({'success': False, 'errors': form.errors})
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
    ms = today.replace(day=1)
    month_str = request.GET.get('month', ms.isoformat())
    try:
        ms = datetime.date.fromisoformat(month_str).replace(day=1)
    except ValueError:
        pass
    budgets = BudgetLimit.objects.filter(month=ms).select_related('category')
    form = BudgetLimitForm()
    if request.method == 'POST':
        if not request.user.is_admin_user:
            messages.error(request, "Access denied."); return redirect('budget_list')
        form = BudgetLimitForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, "Budget limit set.")
            return redirect('budget_list')
    return render(request, 'expenses/budget.html', {
        'budgets': budgets, 'form': form,
        'current_month': ms, 'balances': get_balances_context(request.user)[0],
    })


@login_required
def budget_delete(request, pk):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied."); return redirect('budget_list')
    budget = get_object_or_404(BudgetLimit, pk=pk)
    if request.method == 'POST':
        budget.delete()
        messages.success(request, "Budget deleted.")
    return redirect('budget_list')


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
    cash_account = PaymentMethod.objects.filter(name='Cash').first()

    live_rate = None
    try:
        import urllib.request, json as _json
        with urllib.request.urlopen('https://open.er-api.com/v6/latest/PHP', timeout=4) as r:
            data = _json.loads(r.read())
            live_rate = round(data['rates']['TWD'], 4)
    except Exception:
        pass

    if request.method == 'POST':
        ph_account_id = request.POST.get('ph_account')
        php_amount    = request.POST.get('php_amount')
        exchange_rate = request.POST.get('exchange_rate')
        date_str      = request.POST.get('date')
        notes         = request.POST.get('notes', '')
        errs = []
        if not ph_account_id: errs.append("Select a PH account.")
        if not php_amount:    errs.append("Enter PHP amount.")
        if not exchange_rate: errs.append("Enter exchange rate.")
        if not errs:
            try:
                ph_acc  = PaymentMethod.objects.get(pk=ph_account_id, currency='PHP')
                php_amt = Decimal(str(php_amount))
                rate    = Decimal(str(exchange_rate))
                twd_amt = (php_amt * rate).quantize(Decimal('0.01'))
                txn_date = datetime.date.fromisoformat(date_str) if date_str else datetime.date.today()
                gen_cat  = Category.objects.filter(name='General').first()
                log1 = Transaction.objects.create(
                    date=txn_date, name=f"ATM Withdrawal ({ph_acc.name})",
                    amount=php_amt, currency='PHP',
                    transaction_type=Transaction.TYPE_PH_WITHDRAWAL,
                    payment_method=ph_acc, category=gen_cat,
                    exchange_rate=rate, converted_amount=twd_amt, notes=notes,
                )
                log2 = Transaction.objects.create(
                    date=txn_date, name=f"Cash from {ph_acc.name} (₱{php_amt} × {rate})",
                    amount=twd_amt, currency='TWD',
                    transaction_type=Transaction.TYPE_INCOME,
                    payment_method=cash_account, category=gen_cat, notes=notes,
                )
                log1.paired_transaction = log2
                log1.save()
                messages.success(request, f"✅ ₱{php_amt} → TWD {twd_amt} logged! (rate: {rate})")
                return redirect('ph_withdrawal')
            except Exception as e:
                errs.append(str(e))
        for e in errs:
            messages.error(request, e)

    return render(request, 'expenses/ph_withdrawal.html', {
        'php_accounts': php_accounts,
        'cash_account': cash_account,
        'live_rate': live_rate,
        'today': datetime.date.today().isoformat(),
        'balances': get_balances_context(request.user)[0],
    })


# ── TW Withdrawal ─────────────────────────────────────────────────────────────
# Logs a TWD bank-to-cash withdrawal as two paired transactions:
#   Log 1: Deduct from source TWD bank account  (TYPE_TW_WITHDRAWAL)
#   Log 2: Add to destination Cash account       (TYPE_INCOME)
# Both legs are linked via paired_transaction so they can be found/deleted together.

@login_required
def tw_withdrawal(request):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied.")
        return redirect('dashboard')

    # Only TWD bank accounts are valid sources
    twd_bank_accounts = PaymentMethod.objects.filter(
        currency='TWD', is_bank_account=True, is_active=True
    )
    # Default destination: Cash account
    cash_account = PaymentMethod.objects.filter(name='Cash', currency='TWD').first()
    # All active TWD accounts available as destination (in case user wants to move to iPass etc.)
    twd_accounts = PaymentMethod.objects.filter(currency='TWD', is_active=True)

    if request.method == 'POST':
        source_id  = request.POST.get('source_account')
        dest_id    = request.POST.get('dest_account')
        amount_str = request.POST.get('amount')
        date_str   = request.POST.get('date')
        notes      = request.POST.get('notes', '')

        errs = []
        if not source_id:  errs.append("Please select a source bank account.")
        if not dest_id:    errs.append("Please select a destination account.")
        if not amount_str: errs.append("Please enter the withdrawal amount.")

        if not errs:
            try:
                source_acc = PaymentMethod.objects.get(pk=source_id, currency='TWD', is_bank_account=True)
                dest_acc   = PaymentMethod.objects.get(pk=dest_id, currency='TWD')

                if source_acc == dest_acc:
                    errs.append("Source and destination accounts must be different.")
                else:
                    amount   = Decimal(str(amount_str))
                    txn_date = datetime.date.fromisoformat(date_str) if date_str else datetime.date.today()
                    gen_cat  = Category.objects.filter(name='General').first()

                    # Log 1: Deduct from bank (TW Withdrawal)
                    log1 = Transaction.objects.create(
                        date=txn_date,
                        name=f"ATM Withdrawal ({source_acc.name} → {dest_acc.name})",
                        amount=amount,
                        currency='TWD',
                        transaction_type=Transaction.TYPE_TW_WITHDRAWAL,
                        payment_method=source_acc,
                        to_payment_method=dest_acc,
                        category=gen_cat,
                        notes=notes,
                    )
                    # Log 2: Add to destination (Income)
                    log2 = Transaction.objects.create(
                        date=txn_date,
                        name=f"Cash from {source_acc.name} ATM (TWD {amount:,.0f})",
                        amount=amount,
                        currency='TWD',
                        transaction_type=Transaction.TYPE_INCOME,
                        payment_method=dest_acc,
                        category=gen_cat,
                        notes=notes,
                    )
                    # Link both legs
                    log1.paired_transaction = log2
                    log1.save()

                    messages.success(
                        request,
                        f"✅ TWD {amount:,.0f} withdrawn from {source_acc.name} → {dest_acc.name} logged!"
                    )
                    return redirect('tw_withdrawal')
            except PaymentMethod.DoesNotExist:
                errs.append("Invalid account selected.")
            except Exception as e:
                errs.append(str(e))

        for e in errs:
            messages.error(request, e)

    return render(request, 'expenses/tw_withdrawal.html', {
        'twd_bank_accounts': twd_bank_accounts,
        'twd_accounts': twd_accounts,
        'cash_account': cash_account,
        'today': datetime.date.today().isoformat(),
        'balances': get_balances_context(request.user)[0],
    })


# ── Delete All Data ────────────────────────────────────────────────────────────

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
            return redirect('dashboard')
        else:
            messages.error(request, "❌ Incorrect password. No data was deleted.")
    return redirect('dashboard')


# ── Edit Starting Balance ────────────────────────────────────────────────────

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
