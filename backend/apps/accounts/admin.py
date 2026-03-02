from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import User, MemberPermission

@admin.register(User)
class CustomUserAdmin(UserAdmin):
    list_display = ['username', 'display_name', 'role', 'is_active']
    list_filter = ['role', 'is_active']
    fieldsets = UserAdmin.fieldsets + (
        ('Role', {'fields': ('role', 'display_name')}),
    )

@admin.register(MemberPermission)
class MemberPermissionAdmin(admin.ModelAdmin):
    list_display = ['user', 'can_view_expenses', 'can_view_dashboard', 'can_view_budget']
