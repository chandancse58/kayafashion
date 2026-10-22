import os
from django.conf import settings
from django.db import models
from django.utils.text import slugify
from django.urls import reverse
from django.core.validators import MinValueValidator, MaxValueValidator
from pathlib import Path
from ckeditor.fields import RichTextField
# from orders.models import OrderItem
# from products.models import Product


def upload_thumbnail(instance, filename):
    return os.path.join('images/categories/thumbnails/', filename)

def upload_cover(instance, filename):
    return os.path.join('images/categories/covers/', filename)

# Helper functions for image uploads

def upload_subcategory_thumbnail(instance, filename):
    return os.path.join('images/subcategories/thumbnails/', filename)

def upload_subcategory_cover(instance, filename):
    return os.path.join('images/subcategories/covers/', filename)

# Helper functions for image uploads
def upload_category_thumbnail(instance, filename):
    return os.path.join('images/categories/thumbnails/', filename)

def upload_category_cover(instance, filename):
    return os.path.join('images/categories/covers/', filename)

def upload_product_image(instance, filename):
    return os.path.join('images/products/images/', filename)

def upload_gallery_image(instance, filename):
    # Files saved to: media/products/gallery/product_<id>/filename

    extension = Path(filename.replace("\\", "/")).suffix.lower()
    extension = extension if extension else ".jpg"

    return os.path.join(f'images/products/gallery/product_{instance.product.slug or "temp"}', filename)



class ProductCategory(models.Model):
    name = models.CharField(max_length=255, unique=True, verbose_name="Category Name")
    slug = models.SlugField(max_length=255, unique=True, blank=True, help_text="Auto-generated if left empty")
    title = models.CharField(max_length=255, verbose_name="Display Title")
    description = models.TextField(blank=True, verbose_name="Description")
    
    thumbnail_image = models.ImageField(upload_to=upload_category_thumbnail, verbose_name="Thumbnail Image")
    cover_image = models.ImageField(upload_to=upload_category_cover, blank=True, null=True, verbose_name="Cover Image")
    
    meta_title = models.CharField(max_length=255, blank=True, verbose_name="Meta Title")
    meta_description = models.TextField(blank=True, verbose_name="Meta Description")
    meta_keywords = models.CharField(max_length=500, blank=True, verbose_name="Meta Keywords")

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'product_categories'
        verbose_name = "Product Category"
        verbose_name_plural = "Product Categories"
        ordering = ['name']

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        if not self.meta_title:
            self.meta_title = self.title
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name


class ProductSubCategory(models.Model):
    category = models.ForeignKey(
        ProductCategory, 
        on_delete=models.CASCADE, 
        related_name='subcategories',
        verbose_name="Parent Category"
    )
    name = models.CharField(max_length=255, verbose_name="Subcategory Name")
    slug = models.SlugField(max_length=255, blank=True, help_text="Auto-generated if left empty")
    title = models.CharField(max_length=255, verbose_name="Display Title")
    description = models.TextField(blank=True, verbose_name="Description")
    
    thumbnail_image = models.ImageField(upload_to=upload_subcategory_thumbnail, verbose_name="Thumbnail Image")
    cover_image = models.ImageField(upload_to=upload_subcategory_cover, blank=True, null=True, verbose_name="Cover Image")
    
    meta_title = models.CharField(max_length=255, blank=True, verbose_name="Meta Title")
    meta_description = models.TextField(blank=True, verbose_name="Meta Description")
    meta_keywords = models.CharField(max_length=500, blank=True, verbose_name="Meta Keywords")

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'product_subcategories'
        verbose_name = "Product Subcategory"
        verbose_name_plural = "Product Subcategories"
        unique_together = ('category', 'slug')  # Unique slug per category scope
        ordering = ['name']

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        if not self.meta_title:
            self.meta_title = self.title
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.category.name} -> {self.name}"


# --- Filter Master Models ---
class FilterAttribute(models.Model):
    """
    Master table for dynamic filters (e.g., Color, Fabric, Occasion).
    """
    name = models.CharField(max_length=100, unique=True, help_text="e.g., Color, Fabric, Occasion")
    slug = models.SlugField(max_length=100, unique=True, blank=True)

    class Meta:
        db_table = 'filter_attributes'
        ordering = ['name']

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name


class FilterValue(models.Model):
    """
    Stores options for each attribute (e.g., Color: Red, Blue | Fabric: Cotton, Silk).
    """
    attribute = models.ForeignKey(FilterAttribute, on_delete=models.CASCADE, related_name='values')
    name = models.CharField(max_length=100, help_text="e.g., Red, Cotton, Festive")
    slug = models.SlugField(max_length=100, blank=True)
    color_code = models.CharField(max_length=20, blank=True, null=True, help_text="Hex code if attribute is Color, e.g., #FF0000")

    class Meta:
        db_table = 'filter_values'
        unique_together = ('attribute', 'slug')
        ordering = ['name']

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.attribute.name}: {self.name}"


class Product(models.Model):
    STATUS_CHOICES = (
        ('draft', 'Draft'),
        ('published', 'Published'),
        ('out_of_stock', 'Out of Stock'),
    )

    # Basic Info
    name = models.CharField(max_length=255, verbose_name="Product Name")
    slug = models.SlugField(max_length=255, unique=True, blank=True)    
    product_image = models.ImageField(upload_to=upload_product_image, verbose_name="Product Image",blank=True)    
    

    # Relationships
    category = models.ForeignKey(
        ProductCategory, 
        on_delete=models.CASCADE, 
        related_name='products', 
        verbose_name="Category"
    )
    subcategory = models.ForeignKey(
        ProductSubCategory, 
        on_delete=models.SET_NULL, 
        null=True, 
        blank=True, 
        related_name='products', 
        verbose_name="Subcategory"
    )

    quantity = models.CharField(max_length=50, verbose_name="Product Quantity")
    
    # Details
    description = RichTextField()   #(verbose_name="Description")
    key_features = models.TextField(
        blank=True, 
        help_text="Bullet points or key technical specifications", 
        verbose_name="Key Features"
    )
    # Physical Dimensions & Specifications (DECIMAL(15,8))
    weight = models.DecimalField(
        max_digits=15, 
        decimal_places=8, 
        default=0.00000000, 
        null=True, 
        blank=True, 
        verbose_name="Weight (kg)"
    )
    length = models.DecimalField(
        max_digits=15, 
        decimal_places=8, 
        default=0.00000000, 
        null=True, 
        blank=True, 
        verbose_name="Length (cm)"
    )
    width = models.DecimalField(
        max_digits=15, 
        decimal_places=8, 
        default=0.00000000, 
        null=True, 
        blank=True, 
        verbose_name="Width (cm)"
    )
    height = models.DecimalField(
        max_digits=15, 
        decimal_places=8, 
        default=0.00000000, 
        null=True, 
        blank=True, 
        verbose_name="Height (cm)"
    )

    # Order & Display Controls
    minimum = models.IntegerField(
        default=1, 
        null=True, 
        blank=True, 
        verbose_name="Minimum Order Quantity",
        help_text="Minimum quantity required to purchase"
    )
    rating = models.IntegerField(
        default=0, 
        null=True, 
        blank=True, 
        validators=[MinValueValidator(0), MaxValueValidator(5)],
        verbose_name="Product Rating (0-5)"
    )
    sort_order = models.IntegerField(
        default=0, 
        null=True, 
        blank=True, 
        verbose_name="Sort Order"
    )
    
    # Flags & Status
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='published')
    productcode = models.CharField(max_length=255, verbose_name="Product Code")
    mrp_price = models.CharField(max_length=50, verbose_name="Product MRP Price", null=True, blank=True)
    dist_price = models.DecimalField(max_digits=10, decimal_places=2,default=0.00, blank=True, null=True)           #models.CharField(max_length=50, verbose_name="Product Discount", null=True, blank=True)
    is_featured = models.BooleanField(default=False, verbose_name="Is Featured")
    is_popular = models.BooleanField(default=False, verbose_name="Is Popular")
    is_new_product = models.BooleanField(default=False, verbose_name="Is New Product")
    is_stock = models.BooleanField(default=False, verbose_name="Is Stock")
    
    # SEO Fields
    seo_title = models.CharField(max_length=255, blank=True, verbose_name="SEO Title")
    meta_description = models.TextField(blank=True, verbose_name="Meta Description")
    meta_keywords = models.CharField(
        max_length=500, 
        blank=True, 
        help_text="Comma-separated keywords", 
        verbose_name="Meta Keywords"
    )
    
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'products_master'
        verbose_name = "Product"
        verbose_name_plural = "Products"
        ordering = ['sort_order', '-created_at']

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        if not self.seo_title:
            self.seo_title = self.name
        super().save(*args, **kwargs)

    def get_absolute_url(self):
        return reverse('product_detail', kwargs={'slug': self.slug})

    def __str__(self):
        return self.name



class ProductVariant(models.Model):

    product = models.ForeignKey(
        'Product',
        on_delete=models.PROTECT,
        related_name='variants',
        db_column='product_id',
        verbose_name='Product'
    )

    category = models.ForeignKey(
        'ProductCategory', 
        on_delete=models.PROTECT, 
        db_column='category',        
        related_name='variants', 
        verbose_name="Category"
    )

    # category = models.ForeignKey('ProductCategory', models.CASCADE, db_column='category', blank=True, null=True)

    sku = models.CharField(
        max_length=100,
        unique=True,
        verbose_name='SKU Code'
    )

    size = models.CharField(
        max_length=50,
        null=True,
        blank=True,
        verbose_name='Size'
    )

    color = models.CharField(
        max_length=50,
        null=True,
        blank=True,
        verbose_name='Color'
    )

    is_active = models.BooleanField(
        default=True,
        verbose_name='Is Active'
    )

    quantity = models.PositiveIntegerField(
        default=0,
        verbose_name='Stock Quantity'
    )

    class Meta:
        db_table = 'product_variants'
        managed = False
        verbose_name = 'Product Variant'
        verbose_name_plural = 'Product Variants'
        ordering = ['id']

    def __str__(self):
        details = []

        if self.size:
            details.append(self.size)

        if self.color:
            details.append(self.color)

        if details:
            return f"{self.product.name} ({' / '.join(details)})"

        return f"{self.product.name} ({self.sku})"
    

class ProductImage(models.Model):
    product = models.ForeignKey(
        'Product', 
        on_delete=models.CASCADE, 
        related_name='images', 
        verbose_name="Product"
    )
    variant = models.ForeignKey('ProductVariant', on_delete=models.CASCADE, related_name='variant_images', blank=True, null=True)
    image = models.ImageField(upload_to=upload_gallery_image,max_length=255, verbose_name="Gallery Image")
    alt_text = models.CharField(
        max_length=255, 
        blank=True, 
        help_text="Alternative text for SEO and accessibility",
        verbose_name="Alt Text"
    )
    sort_order = models.IntegerField(
        default=0, 
        help_text="Order in which image appears in gallery",
        verbose_name="Sort Order"
    )
    is_primary = models.BooleanField(
        default=False, 
        verbose_name="Is Primary/Featured Gallery Image"
    )
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'product_images'
        verbose_name = "Product Gallery Image"
        verbose_name_plural = "Product Gallery Images"
        ordering = ['sort_order', 'id']

    def save(self, *args, **kwargs):
        # Ensure only one image is set as primary per product
        if self.is_primary and self.product_id:
            ProductImage.objects.filter(product=self.product, is_primary=True).update(is_primary=False)
        super().save(*args, **kwargs)

    def __str__(self):
        return f"Image for {self.product.name} (ID: {self.id})"


class Review(models.Model):
    product = models.ForeignKey('Product', on_delete=models.CASCADE, related_name='reviews')
    name = models.CharField(max_length=100)
    email = models.EmailField()
    rating = models.IntegerField()
    comment = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.name} - {self.product.name} ({self.rating} Stars)"





class Customer(models.Model):
    password = models.CharField(max_length=128, verbose_name='password')
    last_login = models.DateTimeField(blank=True, null=True, verbose_name='last login')
    is_superuser = models.BooleanField(default=False, verbose_name='superuser status')
    username = models.CharField(max_length=150, unique=True, verbose_name='username')
    first_name = models.CharField(max_length=150, blank=True, verbose_name='first name')
    last_name = models.CharField(max_length=150, blank=True, verbose_name='last name')
    email = models.EmailField(max_length=254, verbose_name='email address')
    is_staff = models.BooleanField(default=False, verbose_name='staff status')
    is_active = models.BooleanField(default=True, verbose_name='active')
    date_joined = models.DateTimeField(auto_now_add=True, verbose_name='date joined')
    mobile = models.CharField(max_length=10, unique=True, verbose_name='mobile')

    class Meta:
        db_table = 'customers'
        managed = False  # Django won't try to create or modify this table via migrations
        verbose_name = 'Customer'
        verbose_name_plural = 'Customers'

    def __str__(self):
        return f"{self.username} ({self.mobile})"

