from django.urls import path
from . import views

urlpatterns = [
    path('newsletters/', views.newsletter_list, name='newsletter_list'),
    path('newsletters/create/', views.newsletter_create, name='newsletter_create'),
    path('newsletters/<int:pk>/', views.newsletter_detail, name='newsletter_detail'),
    path('newsletters/<int:pk>/update/', views.newsletter_update, name='newsletter_update'),
    path('newsletters/<int:pk>/delete/', views.newsletter_delete, name='newsletter_delete'),
]