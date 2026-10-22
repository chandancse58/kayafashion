from django.urls import path
from . import views

urlpatterns = [
    
    path('delete/<int:pk>/', views.setting_delete, name='setting_delete'),

    path('', views.setting_list, name='setting_list'),
    path('create/', views.setting_create, name='setting_create'),
    path('edit/<int:pk>/', views.setting_update, name='setting_update'),
    path('banner/delete/<int:pk>/', views.banner_delete, name='banner_delete'),

    # Information Page CRUD
    path('pages/', views.info_page_list, name='info_page_list'),
    path('pages/create/', views.info_page_create, name='info_page_create'),
    path('pages/edit/<int:pk>/', views.info_page_update, name='info_page_update'),
    path('pages/delete/<int:pk>/', views.info_page_delete, name='info_page_delete'),
    
    # Public route (e.g., /settings/page/about-us/)
    path('page/<slug:slug>/', views.info_page_detail, name='info_page_detail'),
]