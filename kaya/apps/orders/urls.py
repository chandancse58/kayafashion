from django.urls import path
from . import views


urlpatterns = [
    # Admin CRUD Routes
    path('coupons/', views.coupon_list, name='coupon_list'),
    path('coupons/create/', views.coupon_create, name='coupon_create'),
    path('coupons/edit/<int:pk>/', views.coupon_update, name='coupon_update'),
    path('coupons/delete/<int:pk>/', views.coupon_delete, name='coupon_delete'),
    
    # Public Apply Coupon Endpoint
    path('coupon/apply/', views.apply_coupon, name='apply_coupon'),
    # path("checkout/", views.checkout_view, name="checkout_view"),

    # path("place-order/", views.place_order, name="place_order"),
    path("create-razorpay-order/", views.create_razorpay_order, name="create_razorpay_order"),
    # path("confirmation/<str:order_number>/",views.order_confirmation, name="order_confirmation"),

    path("razorpay-payment-return/",views.razorpay_payment_return,name="razorpay_payment_return"),

    # path("checkout/",views.checkout_view,name="checkout_view",),
    # path("create-razorpay-order/",views.create_razorpay_order_view,name="create_razorpay_order_view",),
    # path("razorpay-payment-return/",views.razorpay_payment_return,name="razorpay_payment_return",),
    path("payment-success/", views.payment_success,name="payment_success",),
]