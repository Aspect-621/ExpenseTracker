from django.contrib.auth.models import AbstractUser
from django.db import models


class User(AbstractUser):
    ROLE_ADMIN = 'admin'
    ROLE_MEMBER = 'member'
    ROLE_CHOICES = [
        (ROLE_ADMIN, 'Admin'),
        (ROLE_MEMBER, 'Member'),
    ]
    role = models.CharField(max_length=10, choices=ROLE_CHOICES, default=ROLE_MEMBER)
    display_name = models.CharField(max_length=100, blank=True)

    @property
    def is_admin_user(self):
        return self.role == self.ROLE_ADMIN

    def __str__(self):
        return self.display_name or self.username


class MemberPermission(models.Model):
    """Controls what each member account can see."""
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='permissions')

    # What sections they can access
    can_view_expenses = models.BooleanField(default=True)
    can_view_dashboard = models.BooleanField(default=True)
    can_view_budget = models.BooleanField(default=True)
    can_filter_search = models.BooleanField(default=True)

    # Which payment methods are visible to this member
    # Stored as JSON list of PaymentMethod IDs that are HIDDEN from this member
    # By default bank accounts are hidden

    def __str__(self):
        return f"Permissions for {self.user.username}"

    class Meta:
        verbose_name = "Member Permission"


class HiddenPaymentMethod(models.Model):
    """Payment methods hidden from a specific member."""
    permission = models.ForeignKey(MemberPermission, on_delete=models.CASCADE, related_name='hidden_payment_methods')
    payment_method_id = models.IntegerField()

    class Meta:
        unique_together = ('permission', 'payment_method_id')
