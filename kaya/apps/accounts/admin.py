# accounts/admin.py
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import Customer, Address

class AddressInline(admin.StackedInline):
    model = Address
    extra = 1

@admin.register(Customer)
class CustomerAdmin(UserAdmin):
    # Add mobile to the main list view
    list_display = ('username', 'email', 'mobile', 'first_name', 'last_name', 'is_staff')
    search_fields = ('username', 'email', 'mobile', 'first_name', 'last_name')
    
    # Add mobile to the editing forms in Django Admin
    fieldsets = UserAdmin.fieldsets + (
        ('Additional Info', {'fields': ('mobile',)}),
    )
    add_fieldsets = UserAdmin.add_fieldsets + (
        ('Additional Info', {'fields': ('mobile',)}),
    )
    
    inlines = [AddressInline]

@admin.register(Address)
class AddressAdmin(admin.ModelAdmin):
    list_display = ('customer', 'city', 'state', 'pincode', 'is_default')
    list_filter = ('state', 'is_default')
    search_fields = ('customer__username', 'address_line', 'city', 'pincode')