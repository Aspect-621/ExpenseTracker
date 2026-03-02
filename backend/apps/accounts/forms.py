from django import forms
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm
from .models import User


class LoginForm(AuthenticationForm):
    username = forms.CharField(widget=forms.TextInput(attrs={
        'class': 'form-control', 'placeholder': 'Username', 'autofocus': True
    }))
    password = forms.CharField(widget=forms.PasswordInput(attrs={
        'class': 'form-control', 'placeholder': 'Password'
    }))


class MemberCreateForm(UserCreationForm):
    display_name = forms.CharField(required=False, widget=forms.TextInput(attrs={'class': 'form-control'}))
    email = forms.EmailField(required=False, widget=forms.EmailInput(attrs={'class': 'form-control'}))

    class Meta:
        model = User
        fields = ['username', 'display_name', 'email', 'password1', 'password2']
        widgets = {
            'username': forms.TextInput(attrs={'class': 'form-control'}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['password1'].widget.attrs['class'] = 'form-control'
        self.fields['password2'].widget.attrs['class'] = 'form-control'


class MemberPermissionForm(forms.ModelForm):
    class Meta:
        from .models import MemberPermission
        model = MemberPermission
        fields = ["can_view_expenses", "can_view_dashboard", "can_view_budget", "can_filter_search"]
        widgets = {
            "can_view_expenses": forms.CheckboxInput(attrs={"class": "form-check-input"}),
            "can_view_dashboard": forms.CheckboxInput(attrs={"class": "form-check-input"}),
            "can_view_budget": forms.CheckboxInput(attrs={"class": "form-check-input"}),
            "can_filter_search": forms.CheckboxInput(attrs={"class": "form-check-input"}),
        }


class MemberPermissionForm(forms.ModelForm):
    class Meta:
        from apps.accounts.models import MemberPermission
        model = MemberPermission
        fields = ['can_view_expenses', 'can_view_dashboard', 'can_view_budget', 'can_filter_search']
        widgets = {
            'can_view_expenses':  forms.CheckboxInput(attrs={'class': 'form-check-input'}),
            'can_view_dashboard': forms.CheckboxInput(attrs={'class': 'form-check-input'}),
            'can_view_budget':    forms.CheckboxInput(attrs={'class': 'form-check-input'}),
            'can_filter_search':  forms.CheckboxInput(attrs={'class': 'form-check-input'}),
        }
