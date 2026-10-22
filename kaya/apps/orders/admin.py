from django.contrib import admin
from .models import Order, OrderItem, Payment, Coupon

class OrderItemInline(admin.TabularInline):
    model = OrderItem
    extra = 0
    readonly_fields = ('product_name', 'product_sku', 'unit_price', 'total_price')

class PaymentInline(admin.StackedInline):
    model = Payment
    extra = 0
    readonly_fields = (
        "razorpay_order_id",
        "razorpay_payment_id",
        "amount",
        "status",
        "created_at",
    )

    
@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = ('order_number', 'customer', 'total_amount', 'order_status', 'payment_status', 'created_at')
    list_filter = ('order_status', 'payment_status', 'created_at')
    search_fields = ('order_number', 'customer__user__email', 'tracking_number')
    readonly_fields = ('order_number', 'subtotal', 'total_amount')
    inlines = [OrderItemInline, PaymentInline]


@admin.register(Coupon)
class CouponAdmin(admin.ModelAdmin):
    list_display = (
        'code', 
        'discount_type', 
        'discount_value', 
        'min_order_amount', 
        'used_count', 
        'usage_limit', 
        'start_date', 
        'end_date', 
        'is_active'
    )
    list_filter = ('is_active', 'discount_type', 'start_date', 'end_date')
    search_fields = ('code',)
    readonly_fields = ('used_count',) # Prevents manual editing of usage counts
    ordering = ('-created_at',)
    
    fieldsets = (
        ('General Information', {
            'fields': ('code', 'is_active')
        }),
        ('Discount Configuration', {
            'fields': ('discount_type', 'discount_value', 'min_order_amount', 'max_discount_amount')
        }),
        ('Usage & Limits', {
            'fields': ('usage_limit', 'used_count')
        }),
        ('Validity Period', {
            'fields': ('start_date', 'end_date')
        }),
    )

    # Force uppercase code on admin saves
    def save_model(self, request, obj, form, change):
        if obj.code:
            obj.code = obj.code.upper()
        super().save_model(request, obj, form, change)