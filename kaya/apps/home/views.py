import uuid
from django.shortcuts import render, get_object_or_404, redirect, render
from django.db.models import Prefetch
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.template.loader import render_to_string
from django.db.models import Q
from django.contrib import messages
from products.models import ProductCategory,Product, ProductVariant,  Review, Customer
from site_settings.models import Banner, InformationPage
from newsletters.models import Newsletter
from orders.models import OrderItem, Order
from django.http import JsonResponse

from django.views.decorators.http import require_POST
from django.contrib.auth.decorators import login_required

from django.db import transaction
from decimal import Decimal
from django.utils import timezone
from django.db.models import Sum


from django.urls import reverse

# Create your views here.




def home(request):
    # Ensure guest sessions have a session key.
    if not request.session.session_key:
        request.session.create()

    session_key = request.session.session_key

    categories = ProductCategory.objects.all().order_by("name")

    banners = (
        Banner.objects.filter(
            is_active=True,
            banner_type="home",
        )
        .select_related("website_setting")
        .order_by("order", "-created_at")
    )

    exclusive_banners = (
        Banner.objects.filter(
            is_active=True,
            banner_type="exclusive",
        )
        .select_related("website_setting")
    )

    festival_banners = (
        Banner.objects.filter(
            is_active=True,
            banner_type="festival",
        )
        .select_related("website_setting")
    )

    new_products = (
        Product.objects.filter(
            is_new_product=True,
            status="published",
        )
        .select_related("category", "subcategory")
        .order_by("sort_order", "-created_at")
    )

    popular_products = (
        Product.objects.filter(
            is_popular=True,
            status="published",
        )
        .select_related("category", "subcategory")
        .order_by("sort_order", "-created_at")[:4]
    )

    newsletters = (
        Newsletter.objects.filter(status="published")
        .order_by("datetime")[:4]
    )

    # Initialize cart variables to prevent UnboundLocalError.
    cart_items = []
    cart_item_count = 0
    subtotal = Decimal("0.00")

    # Identify a regular authenticated customer.
    customer = None

    if (
        request.user.is_authenticated
        and not request.user.is_superuser
    ):
        customer = request.user

    # Find the customer's cart or the guest's session cart.
    orders = Order.objects.filter(
        order_status="PENDING",
        payment_status="UNPAID",
    )

    if customer:
        orders = orders.filter(customer=customer)
    elif not request.user.is_authenticated:
        orders = orders.filter(
            session_key=session_key,
            customer__isnull=True,
        )
    else:
        # Superusers do not use the customer cart.
        orders = orders.none()

    # Find the current customer's or guest's pending cart.
    orders = Order.objects.filter(
        order_status="PENDING",
        payment_status="UNPAID",
    )

    if request.user.is_authenticated:
        orders = orders.filter(
            customer_id=request.user.pk
        )
    else:
        orders = orders.filter(
            session_key=session_key,
            customer__isnull=True,
        )

    order = (
        orders.prefetch_related(
            Prefetch(
                "items",
                queryset=OrderItem.objects.select_related(
                    "product",
                    "product__category",
                ),
                to_attr="prefetched_items",
            )
        )
        .order_by("-created_at")
        .first()
    )

    if order:
        cart_items = order.prefetched_items
        cart_item_count = len(cart_items)  

        # Count distinct cart lines, not total product quantity.
        cart_item_count = len(cart_items)

        subtotal = sum(
            (
                item.total_price or Decimal("0.00")
                for item in cart_items
            ),
            Decimal("0.00"),
        )

    context = {
        "products": [],
        "new_products": new_products,
        "categories": categories,
        "banners": banners,
        "exclusive_banners": exclusive_banners,
        "festival_banners": festival_banners,
        "popular_products": popular_products,
        "newsletters": newsletters,
        "cart_item_count": cart_item_count,
        "cart_items": cart_items,
        "subtotal": subtotal,
        "offers": [],
    }

    return render(request, "home/home.html", context)


def category_detail(request, slug=None):
    queryset = Product.objects.filter(status="published")
    category = None

    # Filter by category if slug is present
    if slug:
        category = get_object_or_404(ProductCategory, slug=slug)
        queryset = queryset.filter(category=category)

    # Search filter
    search_query = request.GET.get('search')
    if search_query:
        queryset = queryset.filter(
            Q(name__icontains=search_query) | Q(description__icontains=search_query)
        )

    
    # Price Filter Parameters
    price_range = request.GET.get('price_range', '')
    min_price = request.GET.get('min_price')
    max_price = request.GET.get('max_price')

    # print("price==",price_range)

    if price_range:
        if '-' in price_range:
            parts = price_range.split('-')
            if parts[1] == 'above':
                # Handles cases like '1000-above'
                queryset = queryset.filter(dist_price__gte=parts[0])
            else:
                # Handles standard ranges like '800-1000'
                queryset = queryset.filter(dist_price__gte=parts[0], dist_price__lte=parts[1])
    elif min_price and max_price:
        queryset = queryset.filter(dist_price__gte=min_price, dist_price__lte=max_price)

        print("quer===",queryset)

    # Sorting
    sort_by = request.GET.get('sort')
    if sort_by == 'price_low':
        queryset = queryset.order_by('dist_price')
    elif sort_by == 'price_high':
        queryset = queryset.order_by('-dist_price')
    elif sort_by == 'newest':
        queryset = queryset.order_by('-created_at')

    # Pagination logic (9 items per page)
    paginator = Paginator(queryset, 9)
    page_number = request.GET.get('page')

    try:
        products = paginator.page(page_number)
       
    except PageNotAnInteger:
        products = paginator.page(1)
       
    except EmptyPage:
        products = paginator.page(paginator.num_pages)
        # print("products222===",products)

    session_key = request.session.session_key

    # Identify customer only for authenticated, non-superuser accounts
    customer = None
    if request.user.is_authenticated and not request.user.is_superuser:
        customer = Customer.objects.filter(
            username=request.user.username,
            is_superuser=False
        ).first()

    # Find the current customer's or guest's pending cart.
    orders = Order.objects.filter(
        order_status="PENDING",
        payment_status="UNPAID",
    )

    if request.user.is_authenticated:
        orders = orders.filter(
            customer_id=request.user.pk
        )
    else:
        orders = orders.filter(
            session_key=session_key,
            customer__isnull=True,
        )

    order = (
        orders.prefetch_related(
            Prefetch(
                "items",
                queryset=OrderItem.objects.select_related(
                    "product",
                    "product__category",
                ),
                to_attr="prefetched_items",
            )
        )
        .order_by("-created_at")
        .first()
    )

    if order:
        cart_items = order.prefetched_items
        cart_item_count = len(cart_items)    

        subtotal = sum(
            (item.total_price or Decimal("0.00") for item in cart_items),
            Decimal("0.00"),
        )
        

    # Fetch all categories for sidebar navigation
    categories = ProductCategory.objects.all()

    context = {
        'category': category,
        'products': products,          # Paginated product list
        'categories': categories,      # Categories for sidebar
        'paginator': paginator,
        'is_paginated': products.has_other_pages(),
        'selected_price': price_range,
        'search_query': search_query,
        'sort_by': sort_by,
        "cart_item_count": cart_item_count,
        "cart_items": cart_items,
        "subtotal": subtotal,
        
    }

    return render(request, "home/product_list.html", context)


def product_detail(request, slug):
    product = get_object_or_404(Product,slug=slug,status='published')
    related_products = Product.objects.filter(category=product.category, status='published').exclude(id=product.id)[:4]

    variants = product.variants.filter(is_active=True)

    first_variant = variants.first()

    images = product.images.all()

    # print("first_variant==",first_variant.id)

    reviews = product.reviews.all().order_by('-created_at')

    # Fetch all categories for sidebar navigation
    categories = ProductCategory.objects.all()

    session_key = request.session.session_key
            
    # Identify customer only for authenticated, non-superuser accounts
    customer = None
    if request.user.is_authenticated and not request.user.is_superuser:
        customer = Customer.objects.filter(
            username=request.user.username,
            is_superuser=False
        ).first()

    order = (
        Order.objects
        .filter(
            session_key=session_key,
            customer=customer,
            order_status="PENDING",
            payment_status="UNPAID",
        )
        .prefetch_related(
            Prefetch(
                "items",
                queryset=OrderItem.objects.select_related(
                    "product",
                    "product__category",
                    
                ),
                to_attr="prefetched_items",
            )
        )
        .first()
    )

    # Count distinct OrderItem records
    cart_item_count = len(order.prefetched_items) if order else 0



    if order:
        cart_items = order.prefetched_items
        

        subtotal = sum(
            (item.total_price or Decimal("0.00") for item in cart_items),
            Decimal("0.00"),
        )

    if request.method == 'POST':
        name = request.POST.get('name')
        email = request.POST.get('email')
        rating = request.POST.get('stars')
        comment = request.POST.get('comment')

       
        if not rating or not rating.isdigit() or not (1 <= int(rating) <= 5):
            messages.error(request, "Please select a valid star rating between 1 and 5.")
            return redirect('product_detail', slug=product.slug)

        # Basic Validation
        if not name or not email or not comment:
            messages.error(request, "All fields are required.")
            return redirect('product_detail', slug=product.slug)

        
        else:           

            Review.objects.create(
                product=product,
                name=name,
                email=email,
                rating=rating,
                comment=comment
            )
            messages.success(request, "Your review has been submitted successfully!")
            return redirect('product_detail', slug=product.slug)

        

    return render(
        request,'home/product_detail.html',
        {
            'product': product,
            'variants': variants,
            'first_variant':first_variant,
            'images': images,
            'related_products': related_products,
            'categories': categories,      # Categories for sidebar
            'reviews': reviews,
            "cart_item_count": cart_item_count,
            "cart_items": cart_items,
            "subtotal": subtotal,
        }
    )


def add_to_cart(request, slug):
    if request.method != "POST":
        return redirect("product_detail", slug=slug)

    product = get_object_or_404(
        Product,
        slug=slug,
        status="published",
    )

    try:
        quantity = int(request.POST.get("quantity", 1))
        ptype = request.POST.get("ptype")

        if quantity < 1:
            raise ValueError
    except (ValueError, TypeError):
        messages.error(request, "Please select a valid quantity.")
        return redirect("product_detail", slug=slug)

    # Validate variant if supplied.
    variant_id = request.POST.get("variant_id")
    variant = None

    if variant_id:
        variant = get_object_or_404(
            ProductVariant,
            id=variant_id,
            product=product,
        )

    # Ensure a session exists for guest carts.
    if not request.session.session_key:
        request.session.create()

    session_key = request.session.session_key

    customer = (
        request.user
        if request.user.is_authenticated 
        else None
    )

    # and not request.user.is_superuser

    with transaction.atomic():
        # Find the existing active cart.
        order_filters = {
            "order_status": "PENDING",
            "payment_status": "UNPAID",
        }

        if customer:
            order = (
                Order.objects.select_for_update()
                .filter(customer=customer, **order_filters)
                .order_by("-created_at")
                .first()
            )
        else:
            order = (
                Order.objects.select_for_update()
                .filter(
                    session_key=session_key,
                    customer__isnull=True,
                    **order_filters,
                )
                .order_by("-created_at")
                .first()
            )

        if order is None:
            order = Order.objects.create(
                customer=customer,
                session_key=session_key,
                order_number=(
                    f"KAYA-{timezone.now().year}-"
                    f"{uuid.uuid4().hex[:8].upper()}"
                ),
                shipping_address="",
                billing_address="",
                subtotal=Decimal("0.00"),
                tax_amount=Decimal("0.00"),
                shipping_fee=Decimal("0.00"),
                discount_amount=Decimal("0.00"),
                total_amount=Decimal("0.00"),
                order_status="PENDING",
                payment_status="UNPAID",
            )

        # IMPORTANT:
        # OrderItem has no variant field, so this treats each product
        # as one cart line, regardless of the selected variant.
        item = OrderItem.objects.filter(
            order=order,
            product=product,
        ).first()

        unit_price = product.dist_price

        if item:
            item.quantity += quantity
            item.save()
        else:
            OrderItem.objects.create(
                order=order,
                product=product,
                product_name=product.name,
                product_sku=(
                    variant.sku if variant else
                    getattr(product, "sku", "")
                ),
                unit_price=unit_price,
                quantity=quantity,
                total_price=unit_price * quantity,
            )

        # Recalculate order totals.
        order.subtotal = sum(
            (
                row.total_price
                for row in order.items.all()
            ),
            Decimal("0.00"),
        )

        order.total_amount = (
            order.subtotal
            + order.tax_amount
            + order.shipping_fee
            - order.discount_amount
        )

        order.save()

    if ptype == "pdlist":
        return JsonResponse({
            "success": True,
            "message": "Product added to cart successfully.",
        })

    messages.success(request, "Product added to cart successfully!")
    return redirect("cart_view")



# def add_to_cart(request, slug):
#     if request.method != "POST":
#         return redirect("product_detail", slug=slug)

#     product = get_object_or_404(
#         Product,
#         slug=slug,
#         status="published"
#     )

#     print("product===",product)

#     # Validate quantity
#     try:
#         quantity = int(request.POST.get("quantity", 1))
#         ptype = request.POST.get("ptype")

#         print("ptype===",ptype)

#         if quantity < 1:
#             raise ValueError
#     except (ValueError, TypeError):
#         messages.error(request, "Please select a valid quantity.")
#         return redirect("product_detail", slug=slug)

#     # Validate selected variant
#     variant_id = request.POST.get("variant_id")

#     print("varient====",variant_id)

#     if variant_id:
#         variant = get_object_or_404(
#             ProductVariant,
#             id=variant_id,
#             product=product
#         )

#     # Ensure the session exists
#     if not request.session.session_key:
#         request.session.create()

#     session_key = request.session.session_key

#     customer = None

#     if request.user.is_authenticated:
#         customer = Customer.objects.filter(
#             username=request.user.username,
#             is_superuser=False
#         ).first()

    

#     with transaction.atomic():
#         # Find this customer's pending cart/order for this session
#         order = Order.objects.filter(
#             session_key=session_key,
#             customer=customer,
#             order_status="PENDING",
#             payment_status="UNPAID"
#         ).first()

#         if order is None:
#             year = timezone.now().year
#             random_code = uuid.uuid4().hex[:6].upper()

#             order = Order.objects.create(
#                 customer=customer,
#                 session_key=session_key,
#                 order_number=f"KAYA-{year}-{random_code}",
#                 shipping_address="",
#                 billing_address="",
#                 subtotal=Decimal("0.00"),
#                 tax_amount=Decimal("0.00"),
#                 shipping_fee=Decimal("0.00"),
#                 discount_amount=Decimal("0.00"),
#                 total_amount=Decimal("0.00"),
#                 order_status="PENDING",
#                 payment_status="UNPAID",
#             )

#         # Find an existing item for this product in this order.
#         # NOTE: OrderItem currently has no variant field, so variants
#         # cannot be distinguished in the database yet.
#         item = OrderItem.objects.filter(
#             order=order,
#             product=product
#         ).first()

#         if item:
#             item.quantity += quantity
#             item.save()  # Recalculates total_price in your model's save()
#         else:
#             # Confirm these field names match your Product model.
#             unit_price = product.dist_price

#             OrderItem.objects.create(
#                 order=order,
#                 product=product,
#                 product_name=product.name,
#                 product_sku=variant.sku,
#                 unit_price=unit_price,
#                 quantity=quantity,
#                 total_price=unit_price * quantity,
#             )

#         # Recalculate order totals
#         order.subtotal = sum(
#             (row.total_price for row in order.items.all()),
#             Decimal("0.00")
#         )

#         order.total_amount = (
#             order.subtotal
#             + order.tax_amount
#             + order.shipping_fee
#             - order.discount_amount
#         )

#         order.save()

    
#     if ptype == "pdlist":
#         return JsonResponse({
#             "success": True,
#             "message": "Product added to cart successfully."
#         })

#     else:

#         messages.success(request, "Product added to cart successfully!")
#         return redirect("cart_view")




def cart_view(request):
    cart_items = []
    subtotal = Decimal("0.00")
    tax_amount = Decimal("0.00")
    shipping_fee = Decimal("0.00")
    discount_amount = Decimal("0.00")
    total_amount = Decimal("0.00")
    total_quantity = 0
    cart_item_count = 0

    if not request.session.session_key:
        request.session.create()

    session_key = request.session.session_key

    # Find the current customer's or guest's pending cart.
    orders = Order.objects.filter(
        order_status="PENDING",
        payment_status="UNPAID",
    )

    if request.user.is_authenticated:
        orders = orders.filter(
            customer_id=request.user.pk
        )
    else:
        orders = orders.filter(
            session_key=session_key,
            customer__isnull=True,
        )

    order = (
        orders.prefetch_related(
            Prefetch(
                "items",
                queryset=OrderItem.objects.select_related(
                    "product",
                    "product__category",
                ),
                to_attr="prefetched_items",
            )
        )
        .order_by("-created_at")
        .first()
    )

    if order:
        cart_items = order.prefetched_items
        cart_item_count = len(cart_items)

        subtotal = sum(
            (
                item.total_price or Decimal("0.00")
                for item in cart_items
            ),
            Decimal("0.00"),
        )

        total_quantity = sum(
            item.quantity or 0 for item in cart_items
        )

        tax_amount = order.tax_amount or Decimal("0.00")
        shipping_fee = order.shipping_fee or Decimal("0.00")
        discount_amount = order.discount_amount or Decimal("0.00")

        total_amount = (
            subtotal
            + tax_amount
            + shipping_fee
            - discount_amount
        )

        if (
            order.subtotal != subtotal
            or order.total_amount != total_amount
        ):
            order.subtotal = subtotal
            order.total_amount = total_amount
            order.save(
                update_fields=[
                    "subtotal",
                    "total_amount",
                    "updated_at",
                ]
            )

    categories = ProductCategory.objects.all()

    print("Authenticated:", request.user.is_authenticated)
    print("Current user ID:", request.user.pk)
    print("Is superuser:", request.user.is_superuser)
    print("Current session:", request.session.session_key)

    print("Orders for this customer:", list(
        Order.objects.filter(
            customer_id=request.user.pk
        ).values(
            "id",
            "order_number",
            "customer_id",
            "session_key",
            "order_status",
            "payment_status",
        )
    ) if request.user.is_authenticated else "Guest user")

    
    context = {
        "order": order,
        "categories": categories,
        "cart_items": cart_items,
        "subtotal": subtotal,
        "tax_amount": tax_amount,
        "shipping_fee": shipping_fee,
        "discount_amount": discount_amount,
        "total_amount": total_amount,
        "total_quantity": total_quantity,
        "cart_item_count": cart_item_count,
    }

    return render(request, "cart/cart.html", context)

def cart_view_bck(request):
    order = None
    cart_items = []
    subtotal = Decimal("0.00")
    tax_amount = Decimal("0.00")
    shipping_fee = Decimal("0.00")
    discount_amount = Decimal("0.00")
    total_amount = Decimal("0.00")
    total_quantity = 0
    cart_item_count = 0

    # Ensure a session exists for guest carts.
    if not request.session.session_key:
        request.session.create()

    session_key = request.session.session_key

    # Find the active cart for the logged-in customer or guest.
    orders = Order.objects.filter(
        order_status="PENDING",
        payment_status="UNPAID",
    )

    if request.user.is_authenticated:
        if request.user.is_superuser:
            orders = orders.none()
        else:
            # Customer is your custom AbstractUser model.
            orders = orders.filter(customer=request.user)
    else:
        orders = orders.filter(
            session_key=session_key,
            customer__isnull=True,
        )

    order = (
        orders.prefetch_related(
            Prefetch(
                "items",
                queryset=OrderItem.objects.select_related(
                    "product",
                    "product__category",
                ),
                to_attr="prefetched_items",
            )
        )
        .order_by("-created_at")
        .first()
    )

    # Prepare cart items and totals.
    if order:
        cart_items = order.prefetched_items
        cart_item_count = len(cart_items)

        subtotal = sum(
            (
                item.total_price or Decimal("0.00")
                for item in cart_items
            ),
            Decimal("0.00"),
        )

        total_quantity = sum(
            item.quantity or 0
            for item in cart_items
        )

        tax_amount = order.tax_amount or Decimal("0.00")
        shipping_fee = order.shipping_fee or Decimal("0.00")
        discount_amount = order.discount_amount or Decimal("0.00")

        total_amount = (
            subtotal
            + tax_amount
            + shipping_fee
            - discount_amount
        )

        # Keep stored totals synchronized.
        if (
            order.subtotal != subtotal
            or order.total_amount != total_amount
        ):
            order.subtotal = subtotal
            order.total_amount = total_amount

            order.save(
                update_fields=[
                    "subtotal",
                    "total_amount",
                    "updated_at",
                ]
            )

    categories = ProductCategory.objects.all()

    print("Authenticated:", request.user.is_authenticated)
    print("Current user ID:", request.user.pk)
    print("Is superuser:", request.user.is_superuser)
    print("Current session:", request.session.session_key)

    print("Orders for this customer:", list(
        Order.objects.filter(
            customer_id=request.user.pk
        ).values(
            "id",
            "order_number",
            "customer_id",
            "session_key",
            "order_status",
            "payment_status",
        )
    ) if request.user.is_authenticated else "Guest user")

    context = {
        "order": order,
        "categories": categories,
        "cart_items": cart_items,
        "subtotal": subtotal,
        "tax_amount": tax_amount,
        "shipping_fee": shipping_fee,
        "discount_amount": discount_amount,
        "total_amount": total_amount,
        "total_quantity": total_quantity,
        "cart_item_count": cart_item_count,
    }

    return render(request, "cart/cart.html", context)


# def cart_view(request):
#     order = None
#     cart_items = []
#     subtotal = Decimal("0.00")
#     tax_amount = Decimal("0.00")
#     shipping_fee = Decimal("0.00")
#     discount_amount = Decimal("0.00")
#     total_amount = Decimal("0.00")
#     total_quantity = 0

#     # Get the current session
#     if not request.session.session_key:
#         request.session.create()

#     session_key = request.session.session_key

#     # Identify customer only for authenticated, non-superuser accounts
#     customer = None
#     if request.user.is_authenticated and not request.user.is_superuser:
#         customer = Customer.objects.filter(
#             username=request.user.username,
#             is_superuser=False
#         ).first()

#     # Find the pending order for this session
   
#     order = (
#         Order.objects
#         .filter(
#             session_key=session_key,
#             customer=customer,
#             order_status="PENDING",
#             payment_status="UNPAID",
#         )
#         .prefetch_related(
#             Prefetch(
#                 "items",
#                 queryset=OrderItem.objects.select_related(
#                     "product",
#                     "product__category",
                    
#                 ),
#                 to_attr="prefetched_items",
#             )
#         )
#         .first()
#     )

#     # Prepare cart items and totals
   
#     # Count distinct OrderItem records
#     cart_item_count = len(order.prefetched_items) if order else 0

#     if order:
#         cart_items = order.prefetched_items

       
#         # print("cart===",cart_items)

#         subtotal = sum(
#             (item.total_price or Decimal("0.00") for item in cart_items),
#             Decimal("0.00"),
#         )

#         total_quantity = sum(
#             item.quantity or 0 for item in cart_items
#         )

#         tax_amount = order.tax_amount or Decimal("0.00")
#         shipping_fee = order.shipping_fee or Decimal("0.00")
#         discount_amount = order.discount_amount or Decimal("0.00")

#         total_amount = (
#             subtotal
#             + tax_amount
#             + shipping_fee
#             - discount_amount
#         )

#         # Keep the stored order totals synchronized
#         if (
#             order.subtotal != subtotal
#             or order.total_amount != total_amount
#         ):
#             order.subtotal = subtotal
#             order.total_amount = total_amount
#             order.save(
#                 update_fields=[
#                     "subtotal",
#                     "total_amount",
#                     "updated_at"
#                 ]
#             )

#     categories = ProductCategory.objects.all()

#     context = {
#         "order": order,
#         "categories": categories,
#         "cart_items": cart_items,
#         "subtotal": subtotal,
#         "tax_amount": tax_amount,
#         "shipping_fee": shipping_fee,
#         "discount_amount": discount_amount,
#         "total_amount": total_amount,
#         "total_quantity": total_quantity,
#         "cart_item_count": cart_item_count,
        
#     }

#     return render(request, "cart/cart.html", context)


@require_POST
def update_cart(request):
    if not request.session.session_key:
        messages.error(request, "Your cart session was not found.")
        return redirect("cart_view")

    session_key = request.session.session_key

    customer = None
    if request.user.is_authenticated and not request.user.is_superuser:
        customer = Customer.objects.filter(
            username=request.user.username,
            is_superuser=False,
        ).first()

    order = Order.objects.filter(
        session_key=session_key,
        customer=customer,
        order_status="PENDING",
        payment_status="UNPAID",
    ).first()

    if not order:
        messages.error(request, "Your cart was not found.")
        return redirect("cart_view")

    with transaction.atomic():
        items = list(order.items.select_for_update().all())

        for item in items:
            key = f"quantity_{item.id}"

            if key not in request.POST:
                continue

            try:
                quantity = int(request.POST[key])
            except (TypeError, ValueError):
                messages.error(request, "Please enter a valid quantity.")
                return redirect("cart_view")

            if quantity < 1:
                messages.error(
                    request,
                    "Quantity must be at least 1."
                )
                return redirect("cart_view")

            if item.quantity != quantity:
                item.quantity = quantity
                item.save()  # Recalculates total_price in your model

        subtotal = sum(
            (
                item.total_price or Decimal("0.00")
                for item in order.items.all()
            ),
            Decimal("0.00"),
        )

        tax_amount = order.tax_amount or Decimal("0.00")
        shipping_fee = order.shipping_fee or Decimal("0.00")
        discount_amount = order.discount_amount or Decimal("0.00")

        order.subtotal = subtotal
        order.total_amount = (
            subtotal + tax_amount + shipping_fee - discount_amount
        )

        order.save(update_fields=[
            "subtotal",
            "total_amount",
            "updated_at",
        ])

    messages.success(request, "Cart updated successfully.")
    return redirect("cart_view")


@require_POST
def remove_cart_item(request, item_id):
    session_key = request.session.session_key

    if not session_key:
        return JsonResponse({
            "success": False,
            "message": "Cart session not found."
        }, status=400)

    customer = None

    if request.user.is_authenticated and not request.user.is_superuser:
        customer = Customer.objects.filter(
            username=request.user.username,
            is_superuser=False
        ).first()

    order = get_object_or_404(
        Order,
        session_key=session_key,
        customer=customer,
        order_status="PENDING",
        payment_status="UNPAID"
    )

    with transaction.atomic():
        item = get_object_or_404(
            OrderItem,
            id=item_id,
            order=order
        )

        item.delete()

        remaining_items = list(order.items.all())

        subtotal = sum(
            (row.total_price or Decimal("0.00") for row in remaining_items),
            Decimal("0.00")
        )

        total_quantity = sum(row.quantity or 0 for row in remaining_items)

        tax_amount = order.tax_amount or Decimal("0.00")
        shipping_fee = order.shipping_fee or Decimal("0.00")
        discount_amount = order.discount_amount or Decimal("0.00")

        total_amount = (
            subtotal + tax_amount + shipping_fee - discount_amount
        )

        order.subtotal = subtotal
        order.total_amount = total_amount

        order.save(update_fields=[
            "subtotal",
            "total_amount",
            "updated_at"
        ])

    return JsonResponse({
        "success": True,
        "total_quantity": total_quantity,
        "subtotal": str(subtotal),
        "total_amount": str(total_amount)
    })





def get_absolute_url(self):
    return reverse(
        'product_detail',
        kwargs={'slug': self.slug}
    )

def aboutus(request):
    page = get_object_or_404(
        InformationPage,
        slug="about-us",
        is_active=True
    )

    return render(
        request,
        "about/about.html",
        {
            "page": page,
        }
    )


def contactus(request):
    page = get_object_or_404(
        InformationPage,
        slug="about-us",
        is_active=True
    )

    return render(
        request,
        "about/about.html",
        {
            "page": page,
        }
    )


def newsletter_detail(request, slug):
    product = get_object_or_404(
        Newsletter,
        slug=slug,
        status='published'
    )

    return render(
        request,'newslettrs/newsletter_detail.html',
        {
            'newsletter': Newsletter
        }
    )


