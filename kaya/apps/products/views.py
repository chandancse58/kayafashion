from django.urls import reverse_lazy
from django.shortcuts import render, get_object_or_404, redirect
from django.views.generic import ListView
from django.db.models import Q
from django.db import transaction
from django.contrib import messages
from .models import ProductCategory , ProductSubCategory, FilterAttribute, Product, ProductImage

from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from django.contrib.messages.views import SuccessMessageMixin
from .forms import ProductForm, MultipleImageUploadForm, VariantFormSet


# Create your views here.

def category_list(request):
    categories = ProductCategory.objects.all()
    return render(request, 'products/category_list.html', {'categories': categories})

def category_detail(request, slug):
    category = get_object_or_404(ProductCategory, slug=slug)
    return render(request, 'products/category_detail.html', {'category': category})


def subcategory_detail(request, category_slug, subcategory_slug):
    subcategory = get_object_or_404(
        ProductSubCategory, 
        category__slug=category_slug, 
        slug=subcategory_slug
    )
    return render(request, 'products/subcategory_detail.html', {'subcategory': subcategory})

def product_catalog_view(request):
    products = Product.objects.filter(is_active=True).distinct()
    
    # 1. Price Filtering
    min_price = request.GET.get('min_price')
    max_price = request.GET.get('max_price')

    if min_price:
        products = products.filter(price__gte=min_price)
    if max_price:
        products = products.filter(price__lte=max_price)

    # 2. Dynamic Attribute Filtering (Color, Fabric, Occasion, etc.)
    # Fetches all registered filter attributes
    filter_attributes = FilterAttribute.objects.prefetch_related('values').all()

    for attr in filter_attributes:
        # Get query parameters matching attribute slug (e.g., ?color=red,blue&fabric=cotton)
        selected_values = request.GET.getlist(attr.slug)
        if selected_values:
            # Filters products matching ANY of the selected values for this specific attribute (OR condition)
            products = products.filter(filter_values__slug__in=selected_values)

    # Re-evaluate distinct after multiple joins
    products = products.distinct()

    context = {
        'products': products,
        'filter_attributes': filter_attributes,
        'selected_min_price': min_price or '',
        'selected_max_price': max_price or '',
    }
    return render(request, 'products/catalog.html', context)

def upload_product_gallery_images(request, product_id):
    product = get_object_or_404(Product, id=product_id)

    if request.method == 'POST':
        form = MultipleImageUploadForm(request.POST, request.FILES)
        files = request.FILES.getlist('images')  # Get list of uploaded files
        
        if form.is_valid():
            for index, file in enumerate(files):
                ProductImage.objects.create(
                    product=product,
                    image=file,
                    sort_order=index + 1
                )
            messages.success(request, f"Successfully uploaded {len(files)} images for {product.name}.")
            return redirect('product_detail', slug=product.slug)
    else:
        form = MultipleImageUploadForm()

    return render(request, 'products/upload_gallery.html', {'form': form, 'product': product})


def upload_product_gallery(request, product_id):
    product = get_object_or_404(Product, pk=product_id)

    if request.method == 'POST':
        form = MultipleImageUploadForm(request.POST, request.FILES)
        if form.is_valid():
            # Access the cleaned list of files
            files = form.cleaned_data['images']
            
            for index, file in enumerate(files):
                ProductImage.objects.create(
                    product=product,
                    image=file,
                    sort_order=index + 1
                )
            
            messages.success(request, f"Successfully uploaded {len(files)} images.")
            return redirect('product_detail', pk=product.pk)
    else:
        form = MultipleImageUploadForm()

    return render(request, 'products/product_form.html', {'form': form, 'product': product})




# 1. READ ALL (List View)
class ProductListView(ListView):
    model = Product
    template_name = 'products/product_list.html'
    context_object_name = 'products'
    paginate_by = 10

    def get_queryset(self):
        return Product.objects.prefetch_related('variants').all()

# 2. READ SINGLE (Detail View)
class ProductDetailView(DetailView):
    model = Product
    template_name = 'products/product_detail.html'
    context_object_name = 'product'

# 3. CREATE PRODUCT + VARIANTS
class ProductCreateView(SuccessMessageMixin, CreateView):
    model = Product
    form_class = ProductForm
    template_name = 'products/product_form.html'
    context_object_name = 'product'
    success_url = reverse_lazy('product_list')
    success_message = "Product '%(name)s' was created successfully."

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        if self.request.POST:
            context['variant_formset'] = VariantFormSet(self.request.POST, self.request.FILES)
        else:
            context['variant_formset'] = VariantFormSet()
        return context

    def form_valid(self, form):
        context = self.get_context_data()
        variant_formset = context['variant_formset']

        with transaction.atomic():
            self.object = form.save()

            if variant_formset.is_valid():
                variant_formset.instance = self.object
                variant_formset.save()
            else:
                return self.render_to_response(self.get_context_data(form=form))

        return super().form_valid(form)

# 4. UPDATE PRODUCT + VARIANTS
class ProductUpdateView(SuccessMessageMixin, UpdateView):
    model = Product
    form_class = ProductForm
    template_name = 'products/product_form.html'
    success_url = reverse_lazy('product_list')
    success_message = "Product '%(name)s' was updated successfully xx."

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)

        

        if self.request.POST:
            context['variant_formset'] = VariantFormSet(self.request.POST, self.request.FILES, instance=self.object)
        else:
            context['variant_formset'] = VariantFormSet(instance=self.object)
        return context

            

    def form_valid(self, form):
        context = self.get_context_data()
        variant_formset = context['variant_formset']

        

        with transaction.atomic():
            self.object = form.save()

            if variant_formset.is_valid():
                variants = variant_formset.save(commit=False)
                for variant in variants:
                    variant.product = self.object
                    if not variant.category and hasattr(self.object, 'category'):
                        variant.category = self.object.category
                    variant.save()
                variant_formset.save_m2m()
            else:
                return self.render_to_response(self.get_context_data(form=form))

        return super().form_valid(form)
    

# 5. DELETE
class ProductDeleteView(SuccessMessageMixin, DeleteView):
    model = Product
    template_name = 'products/product_confirm_delete.html'
    success_url = reverse_lazy('product_list')
    success_message = "Product deleted successfully."




