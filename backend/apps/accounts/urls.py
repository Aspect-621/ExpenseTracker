from django.urls import path
from . import views

urlpatterns = [
    path('login/', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),
    path('members/', views.members_list, name='members_list'),
    path('members/create/', views.member_create, name='member_create'),
    path('members/<int:pk>/permissions/', views.member_permissions, name='member_permissions'),
    path('members/<int:pk>/delete/', views.member_delete, name='member_delete'),
    path('members/<int:pk>/toggle/', views.member_toggle_active, name='member_toggle_active'),
]
