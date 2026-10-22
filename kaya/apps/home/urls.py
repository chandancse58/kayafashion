from django.urls import path
from . import views


urlpatterns = [
    # Admin CRUD Routes
    path('', views.home, name='home'),
    
    path('products/category/<slug:slug>/', views.category_detail, name='product_category_view'),
    path('product/<slug:slug>/',views.product_detail,name='product_detail'),

    path("aboutus/", views.aboutus, name="aboutus"),
    path("contactus/", views.contactus, name="contactus"),

    path('cart/add/<slug:slug>/', views.add_to_cart, name='add_to_cart'),
    path('cart/', views.cart_view, name='cart_view'),
    path("cart/update/",views.update_cart,name="update_cart"),
    path("cart/remove/<int:item_id>/", views.remove_cart_item,name="remove_cart_item"),

    

]