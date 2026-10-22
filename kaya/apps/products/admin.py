from django.contrib import admin
from django.utils.html import format_html
from django.db import models
from .models import ProductCategory , ProductSubCategory,ProductVariant, FilterAttribute, FilterValue, Product, ProductImage
from ckeditor.widgets import CKEditorWidget
# from .admin_inline import ProductImageInline

class ProductSubCategoryInline(admin.TabularInline):
    model = ProductSubCategory
    extra = 1
    fields = ('name', 'slug', 'title', 'thumbnail_image')
    prepopulated_fields = {'slug': ('name',)}

@admin.register(ProductCategory)
class ProductCategoryAdmin(admin.ModelAdmin):
    list_display = ('name', 'slug', 'title', 'created_at')
    search_fields = ('name', 'title')
    prepopulated_fields = {'slug': ('name',)}
    inlines = [ProductSubCategoryInline]
    
    fieldsets = (
        ('Basic Information', {
            'fields': ('name', 'slug', 'title', 'description')
        }),
        ('Images', {
            'fields': ('thumbnail_image', 'cover_image')
        }),
        ('SEO Meta Data', {
            'classes': ('collapse',),
            'fields': ('meta_title', 'meta_description', 'meta_keywords')
        }),
    )


@admin.register(ProductSubCategory)
class ProductSubCategoryAdmin(admin.ModelAdmin):
    list_display = ('name', 'category', 'slug', 'title', 'created_at')
    list_filter = ('category',)
    search_fields = ('name', 'title', 'meta_keywords')
    prepopulated_fields = {'slug': ('name',)}
    
    fieldsets = (
        ('Relationship & Basic Details', {
            'fields': ('category', 'name', 'slug', 'title', 'description')
        }),
        ('Images', {
            'fields': ('thumbnail_image', 'cover_image')
        }),
        ('SEO Metadata', {
            'classes': ('collapse',),
            'fields': ('meta_title', 'meta_description', 'meta_keywords')
        }),
    )

class FilterValueInline(admin.TabularInline):
    model = FilterValue
    extra = 2


@admin.register(FilterAttribute)
class FilterAttributeAdmin(admin.ModelAdmin):
    list_display = ('name', 'slug')
    prepopulated_fields = {'slug': ('name',)}
    inlines = [FilterValueInline]


@admin.register(FilterValue)
class FilterValueAdmin(admin.ModelAdmin):
    list_display = ('name', 'attribute', 'slug', 'color_code')
    list_filter = ('attribute',)
    search_fields = ('name',)
    prepopulated_fields = {'slug': ('name',)}


class ProductImageInline(admin.TabularInline):
    model = ProductImage
    extra = 2  # Shows 3 empty file input rows by default
    fields = ('image_preview', 'image', 'variant','alt_text', 'sort_order', 'is_primary')
    readonly_fields = ('image_preview',)
    ordering = ('sort_order',)

    def image_preview(self, obj):
        if obj.image:
            return format_html('<img src="{}" style="width: 60px; height: 60px; object-fit: cover; border-radius: 4px;" />', obj.image.url)
        return "No Image"
    image_preview.short_description = 'Preview'



# class ProductVariantInline(admin.ModelAdmin):

#     list_display = (
#         'sku',
#         'product',
#         'size',
#         'color',
#         'quantity',
#         'is_active',
#     )

#     list_filter = (
#         'is_active',
#         'size',
#         'color',
#     )

#     search_fields = (
#         'sku',
#         'product__name',
#         'color',
#         'size',
#     )

#     list_editable = (
#         'quantity',
#         'is_active',
#     )


#     class Meta:
#         db_table = 'product_variants'
#         verbose_name = "Product Variant"
#         verbose_name_plural = "Product Variants"
#         ordering = ['id']

#         constraints = [
#             models.UniqueConstraint(
#                 fields=['product', 'size', 'color'],
#                 name='unique_product_size_color'
#             )
#         ]


class ProductVariantInline(admin.StackedInline):  # Or admin.TabularInline for a compact row view
    model = ProductVariant
    extra = 1
    fields = (('sku','size', 'color','quantity', 'is_active'))

    class Meta:
        db_table = 'product_variants'
        verbose_name = "Product Variant"
        verbose_name_plural = "Product Variants"
        ordering = ['id']

        constraints = [
            models.UniqueConstraint(
                fields=['product', 'size', 'color'],
                name='unique_product_size_color'
            )
        ]



@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = (
        'name', 'category', 'subcategory', 'rating', 
        'sort_order', 'minimum', 'status', 'is_featured'
    )
    list_filter = ('status', 'is_featured', 'is_popular', 'is_new_product', 'category')
    search_fields = ('name', 'description', 'meta_keywords')
    prepopulated_fields = {'slug': ('name',)}
    list_editable = ('sort_order', 'status', 'minimum', 'rating')
    inlines = [ProductImageInline, ProductVariantInline]  # Attach multi-image inline editor
    

    def gallery_count(self, obj):
        return obj.images.count()
    gallery_count.short_description = 'Gallery Images'

    def variant_count(self, obj):
        return obj.variants.count()
    variant_count.short_description = 'Variants'

    formfield_overrides = {
        models.TextField: {'widget': CKEditorWidget},
    }
    
    fieldsets = (
        ('Basic Information', {
            'fields': ('name', 'slug', 'product_image', 'category', 'subcategory','productcode')
        }),
        ('Details & Specifications', {
            'fields': ('description', 'key_features')
        }),
        ('Product Price', {
            'classes': ('collapse',),
            'fields': (('mrp_price', 'dist_price'))
        }),
        ('Physical Dimensions', {
            'classes': ('collapse',),
            'fields': (('weight', 'length'), ('width', 'height'))
        }),
        ('Order & Display Rules', {
            'fields': (('quantity', 'rating', 'sort_order'),)
        }),
        ('Status & Flags', {
            'fields': ('status', 'is_featured', 'is_popular', 'is_new_product')
        }),
        ('SEO Metadata', {
            'classes': ('collapse',),
            'fields': ('seo_title', 'meta_description', 'meta_keywords')
        }),
    )