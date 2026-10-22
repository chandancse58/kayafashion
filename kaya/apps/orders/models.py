import uuid
from django.db import models
from django.conf import settings
from django.core.validators import MinValueValidator, MaxValueValidator

# Import your existing models (adjust the app name if needed)
from accounts.models import Customer, Address  
from products.models import Product 
# from .models import Coupon
from django.utils import timezone


class Order(models.Model):
    ORDER_STATUS_CHOICES = (
        ('PENDING', 'Pending Payment'),
        ('PROCESSING', 'Processing'),
        ('SHIPPED', 'Shipped'),
        ('DELIVERED', 'Delivered'),
        ('CANCELLED', 'Cancelled'),
        ('REFUNDED', 'Refunded'),
    )

    PAYMENT_STATUS_CHOICES = (
        ('UNPAID', 'Unpaid'),
        ('PAID', 'Paid'),
        ('FAILED', 'Failed'),
        ('REFUNDED', 'Refunded'),
    )

    # Unique public reference number (e.g., ORD-2026-A1B2C3)
    order_number = models.CharField(max_length=32, unique=True, editable=False)
    
    # Relationships to existing models
    customer = models.ForeignKey(
        Customer, 
        on_delete=models.PROTECT, 
        related_name='orders',
        blank=True, null=True
    )
        
    # coupon = models.ForeignKey(
    #     Coupon, 
    #     on_delete=models.SET_NULL, 
    #     null=True, 
    #     blank=True, 
    #     related_name='orders',
    #     help_text="Coupon applied to this order"
    # )
    
    # Snapshots of Shipping/Billing at the time of purchase
    shipping_address = models.TextField(help_text="Snapshot of shipping address")
    billing_address = models.TextField(help_text="Snapshot of billing address")
    
    # Financial Totals
    subtotal = models.DecimalField(max_digits=10, decimal_places=2)
    tax_amount = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
    shipping_fee = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
    discount_amount = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
    total_amount = models.DecimalField(max_digits=10, decimal_places=2)

    # Order Lifecycle & Payment Statuses
    order_status = models.CharField(max_length=20, choices=ORDER_STATUS_CHOICES, default='PENDING')
    payment_status = models.CharField(max_length=20, choices=PAYMENT_STATUS_CHOICES, default='UNPAID')
    
    # Delivery & Fulfillment Tracking
    tracking_number = models.CharField(max_length=100, blank=True, null=True)
    courier_name = models.CharField(max_length=100, blank=True, null=True)
    notes = models.TextField(blank=True, null=True, help_text="Customer or Admin internal order notes")
    session_key = models.CharField(max_length=100,null=True,blank=True, default=None)
    razorpay_payment_link_id = models.CharField( max_length=100,blank=True,null=True,)
    razorpay_order_id = models.CharField(max_length=100,blank=True,null=True)
    razorpay_payment_id = models.CharField(max_length=100,blank=True,null=True)

    # Timestamps
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'orders'
        ordering = ['-created_at']

    def save(self, *args, **kwargs):
        if not self.order_number:
            self.order_number = f"ORD-{uuid.uuid4().hex[:8].upper()}"
        super().save(*args, **kwargs)

    def __str__(self):
        return f"Order {self.order_number} - {self.customer}"


class OrderItem(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name='items')
    product = models.ForeignKey(
        Product, 
        on_delete=models.PROTECT, 
        related_name='order_items'
    )
    
    # Historical snapshots (protects order record if Product name/SKU/price changes later)
    product_name = models.CharField(max_length=255)
    product_sku = models.CharField(max_length=50)
    unit_price = models.DecimalField(max_digits=10, decimal_places=2)
    quantity = models.PositiveIntegerField(validators=[MinValueValidator(1)])
    total_price = models.DecimalField(max_digits=10, decimal_places=2)
    
    class Meta:
        db_table = 'order_items'

    def save(self, *args, **kwargs):
        self.total_price = self.unit_price * self.quantity
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.quantity}x {self.product_name} ({self.order.order_number})"


class Payment(models.Model):
    PAYMENT_METHOD_CHOICES = (
        ('COD', 'Cash on Delivery'),
        ('STRIPE', 'Stripe'),
        ('RAZORPAY', 'Razorpay'),
        ('PAYPAL', 'PayPal'),
    )

    order = models.ForeignKey("orders.Order",on_delete=models.CASCADE,related_name="payments", db_column="order_id",)
    razorpay_order_id = models.CharField(max_length=100,unique=True)
    razorpay_payment_id = models.CharField(max_length=100,blank=True)
    payment_method = models.CharField(max_length=20, choices=PAYMENT_METHOD_CHOICES)
    transaction_id = models.CharField(max_length=100, blank=True, null=True, unique=True)
    amount = models.PositiveIntegerField()  # Amount in paise
    status = models.CharField(max_length=20, default='created')
    raw_response = models.JSONField(blank=True, null=True, help_text="Gateway response payload for audit")
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'payments'

    def __str__(self):
        return self.order_id




class Coupon(models.Model):
    DISCOUNT_TYPE_CHOICES = (
        ('FLAT', 'Flat Amount Discount (₹/$)'),
        ('PERCENTAGE', 'Percentage Discount (%)'),
    )

    code = models.CharField(max_length=50, unique=True, verbose_name="Coupon Code")
    discount_type = models.CharField(max_length=10, choices=DISCOUNT_TYPE_CHOICES, default='PERCENTAGE')
    discount_value = models.DecimalField(
        max_digits=10, 
        decimal_places=2, 
        validators=[MinValueValidator(0.01)],
        help_text="Enter flat amount off or percentage value (e.g., 10 for 10%)"
    )
    
    # Validation Restrictions
    min_order_amount = models.DecimalField(
        max_digits=10, 
        decimal_places=2, 
        default=0.00,
        help_text="Minimum cart total required to apply this coupon"
    )
    max_discount_amount = models.DecimalField(
        max_digits=10, 
        decimal_places=2, 
        null=True, 
        blank=True,
        help_text="Maximum discount cap for percentage coupons (leave blank for no cap)"
    )
    
    # Usage Tracking
    usage_limit = models.PositiveIntegerField(null=True, blank=True, help_text="Total times coupon can be used overall")
    used_count = models.PositiveIntegerField(default=0, editable=False)
    
    # Validity Period
    start_date = models.DateTimeField(default=timezone.now)
    end_date = models.DateTimeField()
    is_active = models.BooleanField(default=True)

    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'coupons'
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.code} - ({self.get_discount_type_display()})"

    def is_valid(self, cart_total=None):
        """Helper method to check if the coupon is valid and active."""
        now = timezone.now()
        
        if not self.is_active:
            return False, "This coupon is currently inactive."
        if now < self.start_date:
            return False, "This coupon offer has not started yet."
        if now > self.end_date:
            return False, "This coupon has expired."
        if self.usage_limit is not None and self.used_count >= self.usage_limit:
            return False, "This coupon usage limit has been reached."
        if cart_total is not None and cart_total < self.min_order_amount:
            return False, f"Minimum order total of {self.min_order_amount} is required for this coupon."
            
        return True, "Valid"

    def calculate_discount(self, cart_total):
        """Calculates the exact discount amount based on cart total."""
        if self.discount_type == 'FLAT':
            discount = self.discount_value
        else: # PERCENTAGE
            discount = (cart_total * self.discount_value) / 100
            if self.max_discount_amount and discount > self.max_discount_amount:
                discount = self.max_discount_amount

        # Ensure discount does not exceed total cart amount
        return min(discount, cart_total)