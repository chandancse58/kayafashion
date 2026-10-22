from django.db import models
from django.contrib.auth.models import AbstractUser, BaseUserManager
from django.core.validators import RegexValidator


class CustomerManager(BaseUserManager):
    def create_user(self, username, email, mobile, password=None, **extra_fields):
        if not username:
            raise ValueError("Username is required")
        if not email:
            raise ValueError('The Email field must be set')
        if not mobile:
            raise ValueError("Mobile number is required")

        
        email = self.normalize_email(email)
        user = self.model(username=username, email=email, mobile=mobile, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, username, email, mobile, password=None, **extra_fields):
        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_superuser", True)
        extra_fields.setdefault("is_active", True)

        if extra_fields.get("is_staff") is not True:
            raise ValueError("Superuser must have is_staff=True")

        if extra_fields.get("is_superuser") is not True:
            raise ValueError("Superuser must have is_superuser=True")

        return self.create_user(
            username=username,
            email=email,
            mobile=mobile,
            password=password,
            **extra_fields
        )


class Customer(AbstractUser):
    mobile_regex = RegexValidator(
        regex=r'^[6-9]\d{9}$', 
        message="Mobile number must be a valid 10-digit Indian phone number."
    )
    mobile = models.CharField(validators=[mobile_regex], max_length=10, unique=True)

    REQUIRED_FIELDS = ["email", "mobile"]

    objects = CustomerManager()

    class Meta:
        db_table = 'customers'
        verbose_name = "Customer"
        verbose_name_plural = "Customers"

    def __str__(self):
        return f"{self.get_full_name() or self.username} ({self.mobile})"



class Address(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE, related_name='addresses')
    address_line = models.TextField(verbose_name="Address")
    city = models.CharField(max_length=100)
    state = models.CharField(max_length=100)
    pincode = models.CharField(max_length=6)
    is_default = models.BooleanField(default=True, verbose_name="Default Address")

    class Meta:
        db_table = 'customer_addresses'
        verbose_name = "Customer Address"
        verbose_name_plural = "Customer Addresses"

    def save(self, *args, **kwargs):
        # Ensure only one address is set as default per customer
        if self.is_default:
            Address.objects.filter(customer=self.customer, is_default=True).update(is_default=False)
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.address_line}, {self.city}, {self.state} - {self.pincode}"