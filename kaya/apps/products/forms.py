from django import forms
import os
from django.forms import inlineformset_factory
from .models import ProductCategory , ProductVariant, ProductSubCategory, Product, ProductImage

# allow_multiple_selected = True


def upload_product_image(instance, filename):
    return os.path.join('images/products/images/', filename)

class ProductCategoryForm(forms.ModelForm):
    class Meta:
        model = ProductCategory
        fields = [
            'name', 'slug', 'title', 'description', 
            'thumbnail_image', 'cover_image', 
            'meta_title', 'meta_description', 'meta_keywords'
        ]
        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'e.g., Enter Category'}),
            'slug': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Auto-generated or custom slug'}),
            'title': forms.TextInput(attrs={'class': 'form-control'}),
            'description': forms.Textarea(attrs={'class': 'form-control', 'rows': 4}),
            'meta_title': forms.TextInput(attrs={'class': 'form-control'}),
            'meta_description': forms.Textarea(attrs={'class': 'form-control', 'rows': 3}),
            'meta_keywords': forms.TextInput(attrs={'class': 'form-control'}),
        }


class ProductSubCategoryForm(forms.ModelForm):
    class Meta:
        model = ProductSubCategory
        fields = [
            'category', 'name', 'slug', 'title', 'description', 
            'thumbnail_image', 'cover_image', 
            'meta_title', 'meta_description', 'meta_keywords'
        ]
        widgets = {
            'category': forms.Select(attrs={'class': 'form-control'}),
            'name': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'e.g., Dome IP Cameras'}),
            'slug': forms.TextInput(attrs={'class': 'form-control'}),
            'title': forms.TextInput(attrs={'class': 'form-control'}),
            'description': forms.Textarea(attrs={'class': 'form-control', 'rows': 4}),
            'meta_title': forms.TextInput(attrs={'class': 'form-control'}),
            'meta_description': forms.Textarea(attrs={'class': 'form-control', 'rows': 3}),
            'meta_keywords': forms.TextInput(attrs={'class': 'form-control'}),
        }

class ProductForm(forms.ModelForm):
    class Meta:
        model = Product
        fields = [
            'name', 'slug','product_image', 'category', 'subcategory', 
            'description', 'key_features', 'quantity','mrp_price', 'dist_price',
            'weight', 'length', 'width', 'height', 
            'minimum', 'rating', 'sort_order',
            'status','productcode', 'is_featured', 'is_popular', 'is_new_product', 'is_stock',
            'seo_title', 'meta_description', 'meta_keywords'
        ]
        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control'}),
            'slug': forms.TextInput(attrs={'class': 'form-control'}),            
            'product_image': forms.FileInput(attrs={'class': 'form-control'}),
            'category': forms.Select(attrs={'class': 'form-control'}),
            'subcategory': forms.Select(attrs={'class': 'form-control'}),
            'description': forms.Textarea(attrs={'class': 'form-control', 'rows': 4}),
            'key_features': forms.Textarea(attrs={'class': 'form-control', 'rows': 4}),
            'quantity': forms.TextInput(attrs={'class': 'form-control'}),
            'mrp_price': forms.TextInput(attrs={'class': 'form-control'}),
            'dist_price': forms.TextInput(attrs={'class': 'form-control'}),
            
            # Dimension & Specification Widgets
            'weight': forms.NumberInput(attrs={'class': 'form-control', 'step': '0.00000001'}),
            'length': forms.NumberInput(attrs={'class': 'form-control', 'step': '0.00000001'}),
            'width': forms.NumberInput(attrs={'class': 'form-control', 'step': '0.00000001'}),
            'height': forms.NumberInput(attrs={'class': 'form-control', 'step': '0.00000001'}),
            'minimum': forms.NumberInput(attrs={'class': 'form-control'}),
            'rating': forms.NumberInput(attrs={'class': 'form-control', 'min': 0, 'max': 5}),
            'sort_order': forms.NumberInput(attrs={'class': 'form-control'}),
            
            'status': forms.Select(attrs={'class': 'form-control'}),
            'is_featured': forms.CheckboxInput(attrs={'class': 'form-check-input'}),
            'is_popular': forms.CheckboxInput(attrs={'class': 'form-check-input'}),
            'is_new_product': forms.CheckboxInput(attrs={'class': 'form-check-input'}),
            'is_stock': forms.CheckboxInput(attrs={'class': 'form-check-input'}),
            'seo_title': forms.TextInput(attrs={'class': 'form-control'}),
            'meta_description': forms.Textarea(attrs={'class': 'form-control', 'rows': 2}),
            'meta_keywords': forms.TextInput(attrs={'class': 'form-control'}),
        }


class ProductVariantForm(forms.ModelForm):
    class Meta:
        model = ProductVariant
        fields = ['sku', 'size', 'color', 'quantity', 'is_active']
        widgets = {
            'sku': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'SKU'}),
            'size': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Size (e.g., XL)'}),
            'color': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Color'}),          
            'quantity': forms.NumberInput(attrs={'class': 'form-control', 'placeholder': 'Qty'}),
            'is_active': forms.CheckboxInput(attrs={'class': 'form-check-input'}),
        }


# 2. Corrected Inline Formset (Removed ProductCategory from arguments)
VariantFormSet = inlineformset_factory(
    Product,            # Parent Model
    ProductVariant,     # Child Model (Corrected)
    form=ProductVariantForm,
    extra=1,
    can_delete=True
)


class ProductImageForm(forms.ModelForm):
    class Meta:
        model = ProductImage
        fields = ['image', 'alt_text', 'sort_order', 'is_primary']
        widgets = {
            'image': forms.FileInput(attrs={'class': 'form-control'}),
            'alt_text': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Optional SEO alt text'}),
            'sort_order': forms.NumberInput(attrs={'class': 'form-control'}),
            'is_primary': forms.CheckboxInput(attrs={'class': 'form-check-input'}),
        }

class MultipleFileInput(forms.ClearableFileInput):
    allow_multiple_selected = True


# 2. Define custom field to clean a list of files
class MultipleFileField(forms.FileField):
    def __init__(self, *args, **kwargs):
        kwargs.setdefault("widget", MultipleFileInput())
        super().__init__(*args, **kwargs)

    def clean(self, data, initial=None):
        single_file_clean = super().clean
        if isinstance(data, (list, tuple)):
            return [single_file_clean(d, initial) for d in data]
        return single_file_clean(data, initial)


# 3. Use in your form
class MultipleImageUploadForm(forms.Form):
    images = MultipleFileField(
        widget=MultipleFileInput(attrs={'class': 'form-control', 'multiple': True}),
        required=True
    )






# Multiple Files Upload Widget Form
# class MultipleFileInput(forms.FileInput):
#     def __init__(self, attrs=None):
#         default_attrs = {'multiple': True}
#         if attrs:
#             default_attrs.update(attrs)
#         super().__init__(default_attrs)

#     def value_from_datadict(self, data, files, name):
#         # Crucial fix: return the full list of files instead of just one
#         if hasattr(files, 'getlist'):
#             return files.getlist(name)
#         return files.get(name)

# class MultipleImageUploadForm(forms.Form):
#     images = forms.FileField(
#         widget=MultipleFileInput(attrs={'class': 'form-control'}),
#         required=True,
#         help_text="Select one or more images to upload"
#     )