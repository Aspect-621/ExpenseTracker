from django.urls import path
from . import views

urlpatterns = [
    path('', views.dashboard, name='dashboard'),
    path('expenses/', views.expense_list, name='expense_list'),
    path('expenses/add/', views.expense_create, name='expense_create'),
    path('expenses/<int:pk>/edit/', views.expense_edit, name='expense_edit'),
    path('expenses/<int:pk>/delete/', views.expense_delete, name='expense_delete'),
    path('expenses/<int:pk>/toggle-hidden/', views.expense_toggle_hidden, name='expense_toggle_hidden'),
    path('expenses/export/', views.expense_export, name='expense_export'),
    path('api/balances/', views.balance_api, name='balance_api'),
    path('ph-withdrawal/', views.ph_withdrawal, name='ph_withdrawal'),
    path('tw-withdrawal/', views.tw_withdrawal, name='tw_withdrawal'),   # ← NEW
    path('delete-all-data/', views.delete_all_data, name='delete_all_data'),
    path('categories/', views.categories_list, name='categories_list'),
    path('categories/<int:pk>/edit/', views.category_edit, name='category_edit'),
    path('categories/<int:pk>/delete/', views.category_delete, name='category_delete'),
    path('payment-methods/', views.payment_methods_list, name='payment_methods_list'),
    path('payment-methods/<int:pk>/edit/', views.payment_method_edit, name='payment_method_edit'),
    path('payment-methods/<int:pk>/delete/', views.payment_method_delete, name='payment_method_delete'),
    path('payment-methods/<int:pk>/set-balance/', views.payment_method_set_balance, name='payment_method_set_balance'),
    path('budget/', views.budget_list, name='budget_list'),
    path('budget/<int:pk>/delete/', views.budget_delete, name='budget_delete'),
    path('recurring/', views.recurring_list, name='recurring_list'),
    path('recurring/<int:pk>/edit/', views.recurring_edit, name='recurring_edit'),
    path('recurring/<int:pk>/delete/', views.recurring_delete, name='recurring_delete'),
]
