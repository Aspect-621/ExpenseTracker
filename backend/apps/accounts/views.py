from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import login, logout, authenticate
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.http import JsonResponse
from .models import User, MemberPermission, HiddenPaymentMethod
from .forms import LoginForm, MemberCreateForm, MemberPermissionForm
from apps.expenses.models import PaymentMethod


def login_view(request):
    if request.user.is_authenticated:
        return redirect('dashboard')
    form = LoginForm(request, data=request.POST or None)
    if request.method == 'POST' and form.is_valid():
        user = form.get_user()
        login(request, user)
        return redirect('dashboard')
    return render(request, 'accounts/login.html', {'form': form})


def logout_view(request):
    logout(request)
    return redirect('login')


@login_required
def members_list(request):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied.")
        return redirect('dashboard')
    members = User.objects.filter(role=User.ROLE_MEMBER).prefetch_related('permissions')
    return render(request, 'accounts/members.html', {'members': members})


@login_required
def member_create(request):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied.")
        return redirect('dashboard')
    if request.method == 'POST':
        form = MemberCreateForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            user.role = User.ROLE_MEMBER
            user.save()
            # Create default permissions
            perm = MemberPermission.objects.create(user=user)
            # Hide bank account payment methods by default
            for pm in PaymentMethod.objects.filter(is_bank_account=True):
                HiddenPaymentMethod.objects.create(permission=perm, payment_method_id=pm.id)
            messages.success(request, f"Member '{user.username}' created successfully.")
            return redirect('member_permissions', pk=user.pk)
    else:
        form = MemberCreateForm()
    return render(request, 'accounts/member_form.html', {'form': form, 'title': 'Create Member'})


@login_required
def member_permissions(request, pk):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied.")
        return redirect('dashboard')
    member = get_object_or_404(User, pk=pk, role=User.ROLE_MEMBER)
    perm, _ = MemberPermission.objects.get_or_create(user=member)
    payment_methods = PaymentMethod.objects.filter(is_active=True)
    hidden_ids = set(perm.hidden_payment_methods.values_list('payment_method_id', flat=True))

    if request.method == 'POST':
        perm.can_view_expenses = 'can_view_expenses' in request.POST
        perm.can_view_dashboard = 'can_view_dashboard' in request.POST
        perm.can_view_budget = 'can_view_budget' in request.POST
        perm.can_filter_search = 'can_filter_search' in request.POST
        perm.save()

        # Update hidden payment methods
        perm.hidden_payment_methods.all().delete()
        for pm in payment_methods:
            if f'hide_pm_{pm.id}' in request.POST:
                HiddenPaymentMethod.objects.create(permission=perm, payment_method_id=pm.id)

        messages.success(request, "Permissions updated successfully.")
        return redirect('members_list')

    return render(request, 'accounts/member_permissions.html', {
        'member': member,
        'perm': perm,
        'payment_methods': payment_methods,
        'hidden_ids': hidden_ids,
    })


@login_required
def member_delete(request, pk):
    if not request.user.is_admin_user:
        messages.error(request, "Access denied.")
        return redirect('dashboard')
    member = get_object_or_404(User, pk=pk, role=User.ROLE_MEMBER)
    if request.method == 'POST':
        member.delete()
        messages.success(request, "Member deleted.")
    return redirect('members_list')


@login_required
def member_toggle_active(request, pk):
    if not request.user.is_admin_user:
        return JsonResponse({'error': 'Access denied'}, status=403)
    member = get_object_or_404(User, pk=pk, role=User.ROLE_MEMBER)
    member.is_active = not member.is_active
    member.save()
    return JsonResponse({'active': member.is_active})
