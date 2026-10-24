import razorpay
import logging
import uuid
from django.db.models import Q
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.conf import settings
from django.db import transaction , IntegrityError
from django.utils import timezone
# from demal ciimport Decimal, ROUND_HALF_UP
from django.contrib.admin.views.decorators import staff_member_required
from django.http import JsonResponse
from .models import Order,Coupon
from .forms import CouponForm, ApplyCouponForm
from django.views.decorators.http import require_http_methods
import json

from decimal import Decimal, ROUND_HALF_UP
from django.contrib.auth.decorators import login_required
from django.db.models import Prefetch

from orders.models import  OrderItem, Order
from products.models import Customer
from .models import Product, Payment

from products.models import ProductCategory

from django.views.decorators.http import require_POST
from django.urls import reverse
from django.views.decorators.csrf import csrf_protect
# from .utils import get_razorpay_client  # Adjust if defined elsewhere



logger = logging.getLogger(__name__)

# Initialize Razorpay Client
razorpay_client = razorpay.Client(auth=(settings.RAZORPAY_KEY_ID, settings.RAZORPAY_KEY_SECRET))


def get_razorpay_client():
    return razorpay.Client(
        auth=(
            settings.RAZORPAY_KEY_ID,
            settings.RAZORPAY_KEY_SECRET,
        )
    )


def rupees_to_paise(amount):
    return int(
        (Decimal(str(amount)) * 100).quantize(
            Decimal("1"), rounding=ROUND_HALF_UP
        )
    )





def get_user_cart_items(request):
    """
    Return unpaid, pending cart items for the logged-in customer
    or the current guest session.
    """

    if request.user.is_authenticated:
        orders = Order.objects.filter(
            customer=request.user,
            order_status="PENDING",
            payment_status="UNPAID",
        )
    else:
        if not request.session.session_key:
            request.session.create()

        orders = Order.objects.filter(
            session_key=request.session.session_key,
            customer__isnull=True,
            order_status="PENDING",
            payment_status="UNPAID",
        )

    return OrderItem.objects.filter(
        order__in=orders
    ).select_related("product", "order")



# def get_user_cart_items(request):
#     """Return pending, unpaid order items for the current customer or guest."""

#     orders = Order.objects.filter(
#         payment_status="UNPAID",
#         order_status="PENDING",
#     )

#     if request.user.is_authenticated:
#         # If Customer is your Django user model, use its primary key.
#         orders = orders.filter(customer_id=request.user.pk)
#     else:
#         if not request.session.session_key:
#             request.session.create()

#         orders = orders.filter(
#             session_key=request.session.session_key,
#             customer__isnull=True,
#         )

#     return OrderItem.objects.filter(
#         order__in=orders
#     ).select_related("product", "order")



# @require_POST
# def create_razorpay_order_view(request):
#     # Adapt this query to your existing logged-in/session cart.
#     if request.user.is_authenticated:
#         cart_items = Order.objects.filter(Customer=request.user)
#     else:
#         # Example only: use the session field your cart actually uses.
#         cart_id = request.session.get("cart_id")
#         if not cart_id:
#             return JsonResponse(
#                 {"error": "Your cart is empty."}, status=400
#             )

#         cart_items = Order.objects.filter(cart_id=cart_id)

#     cart_items = list(cart_items)

#     if not cart_items:
#         return JsonResponse(
#             {"error": "Your cart is empty."}, status=400
#         )

#     line_items = []
#     subtotal_paise = 0

#     for item in cart_items:
#         product = item.product
#         quantity = int(item.quantity)

#         if quantity < 1:
#             return JsonResponse(
#                 {"error": "Invalid cart quantity."}, status=400
#             )

#         # Replace with your authoritative current selling price.
#         unit_price = Decimal(str(product.price))
#         unit_price_paise = rupees_to_paise(unit_price)
#         line_total_paise = unit_price_paise * quantity

#         subtotal_paise += line_total_paise

#         line_items.append({
#             "sku": str(product.pk),
#             "variant_id": str(product.pk),
#             "price": unit_price_paise,
#             "offer_price": unit_price_paise,
#             "quantity": quantity,
#             "name": str(product.name)[:255],
#         })

#     # Example assumes no separate shipping charge or tax.
#     # If your store charges shipping or tax, calculate it here
#     # and use your actual checkout total.
#     amount_paise = subtotal_paise

#     if amount_paise <= 0:
#         return JsonResponse(
#             {"error": "Invalid order amount."}, status=400
#         )

#     receipt = uuid.uuid4().hex

#     local_order = Order.objects.create(
#         user=request.user if request.user.is_authenticated else None,
#         receipt=receipt,
#         total_amount=Decimal(amount_paise) / Decimal("100"),
#         status="created",
#     )

#     payload = {
#         "amount": amount_paise,
#         "currency": "INR",
#         "receipt": receipt,
#         "line_items_total": subtotal_paise,
#         "line_items": line_items,
#     }

#     try:
#         razorpay_order = get_razorpay_client().order.create(
#             data=payload
#         )

#         local_order.razorpay_order_id = razorpay_order["id"]
#         local_order.save(update_fields=["razorpay_order_id"])

#     except Exception:
#         # Log the real exception server-side in production.
#         local_order.delete()
#         return JsonResponse(
#             {"error": "Unable to create payment order. Please retry."},
#             status=502,
#         )

#     request.session["current_order_id"] = local_order.pk

#     return JsonResponse({
#         "key": settings.RAZORPAY_KEY_ID,
#         "order_id": razorpay_order["id"],
#         "amount": amount_paise,
#         "currency": "INR",
#         "name": "Kaya Fashion",
#         "receipt": receipt,
#     })


@require_POST
def create_razorpay_order(request):
    """Create a Razorpay order using the server-calculated cart total."""
    # try:

    cart_items = list(get_user_cart_items(request))

    print("cart===",cart_items)

    if not cart_items:
        return JsonResponse(
            {"error": "Your shopping cart is empty."},
            status=400,
        )

    total = Decimal("0.00")

    for item in cart_items:
        # Change product.price if your model uses another price field.
        price = Decimal(str(item.product.dist_price))
        quantity = int(item.quantity)
        # print("item ===>>", item)
        if price < 0 or quantity <= 0:
            return JsonResponse(
                {"error": "Invalid cart item."},
                status=400,
            )

        total += price * quantity

    total = total.quantize(
        Decimal("0.01"),
        rounding=ROUND_HALF_UP,
    )

    # Razorpay expects the amount in paise.
    # amount_paise = int(total * 100)

    amount_paise = int(100) 

    if amount_paise < 100:
        return JsonResponse(
            {"error": "The minimum payment amount is ₹1."},
            status=400,
        )

    client = get_razorpay_client()

    razorpay_order = client.order.create(
        data={
            "amount": amount_paise,
            "currency": "INR",
            "receipt": uuid.uuid4().hex,
        }
    )
    # print("razorpay_order====>", razorpay_order)
    if razorpay_order["status"] == "created":
        Order.objects.filter(id=request.session["current_order_id"]).update(razorpay_order_id=razorpay_order["id"])
    else:
        return JsonResponse(
                    {"error": "Order creation failed. Please try again."},
                    status=500,
                )
    # Keep the order ID and expected amount on the server.
    request.session["razorpay_order_id"] = razorpay_order["id"]
    request.session["razorpay_amount"] = amount_paise

    return JsonResponse({
        "key": settings.RAZORPAY_KEY_ID,
        "order_id": razorpay_order["id"],
        "amount": amount_paise,            
        "currency": "INR",
        "name": "Kaya Fashion",
    })

    # except Exception:
    #     logger.exception("Failed to create Razorpay order")
    #     return JsonResponse(
    #         {"error": "Unable to initiate payment. Please try again."},
    #         status=500,
    #     )




@require_POST
def razorpay_payment_return(request):
    """Verify Razorpay payment and save the Payment and Order records."""

    if request.method != "POST":
        return redirect("checkout")

    # These IDs must have been saved by your create-order view.
    local_order_id = request.session.get("current_order_id")
    razorpay_order_id = request.session.get("razorpay_order_id")
    expected_amount = request.session.get("razorpay_amount")

    payment_id = request.POST.get("razorpay_payment_id")
    returned_order_id = request.POST.get("razorpay_order_id")
    signature = request.POST.get("razorpay_signature")

    # print("local_order_id====",local_order_id)
    # print("razorpay_order_id====",razorpay_order_id)
    # print("expected_amount====",expected_amount)
    # print("payment_id====",payment_id)
    # print("returned_order_id====",returned_order_id)
    # print("signature====",signature)

    if not all([
        local_order_id,
        razorpay_order_id,
        expected_amount is not None,
        payment_id,
        returned_order_id,
        signature,
    ]):
        return render(
            request,
            "orders/payment_failed.html",
            {"message": "Missing payment information."},
            status=400,
        )

    # The order ID returned by the browser must match our saved Razorpay ID.
    if returned_order_id != razorpay_order_id:
        messages.error(request, "Payment order mismatch.")
        return redirect("checkout")

    # try:
    # Look up the LOCAL Django order, not the Razorpay order ID.
    order = Order.objects.get(pk=local_order_id)

    client = get_razorpay_client()

    # Verify the checkout signature against the saved Razorpay order ID.
    client.utility.verify_payment_signature({
        "razorpay_order_id": order.razorpay_order_id,
        "razorpay_payment_id": payment_id,
        "razorpay_signature": signature,
    })

    # Fetch authoritative payment details directly from Razorpay.
    payment = client.payment.fetch(payment_id)

    if payment.get("order_id") != order.razorpay_order_id:
        messages.error(request, "Payment order could not be verified.")
        return redirect("checkout")

    # Razorpay amounts are in paise. Compare against both the session
    # amount and the amount calculated from our database order.
    order_amount_paise = int(
        (Decimal(str(order.total_amount)) * Decimal("100")).quantize(
            Decimal("1"),
            rounding=ROUND_HALF_UP,
        )
    )
    order_amount_paise = 100
    # print(">>>", payment.get("amount", 0))
    # print("expected_amount>>>>", expected_amount)
    # print("order_amount_paise >>>", order_amount_paise)
    if (
        int(payment.get("amount", 0)) != int(expected_amount)
        or int(payment.get("amount", 0)) != int(order_amount_paise)
    ):
        messages.error(request, "Payment amount mismatch.")
        return redirect("checkout")
    # print("payment.get('currency')>>>", payment.get("currency"))
    if payment.get("currency") != "INR":
        messages.error(request, "Payment currency mismatch.")
        return redirect("checkout")
    # print("payment.get('status') >>>>", payment.get("status"))
    if payment.get("status") != "captured":
        messages.warning(
            request,
            "Payment is not yet confirmed. Please try again later.",
        )
        return redirect("checkout")
    # print("type of payment >>", type(payment))
    # Convert the Razorpay response into JSON text for a TextField.
    payment_response_json = json.dumps(
        payment,
        default=str,
    )
    # print("type of payment >>", payment)
    # Lock the order so simultaneous callbacks cannot process it twice.
    with transaction.atomic():
        locked_order = Order.objects.select_for_update().get(
            pk=local_order_id
        )
        # print("type >>>", type(locked_order))
        # Prevent a different payment from being attached to this order.
        if (
            locked_order.razorpay_order_id
            != razorpay_order_id
        ):
            messages.error(request, "Payment order mismatch.")
            return redirect("checkout")

        existing_payment = Payment.objects.filter(
            razorpay_order_id=order.razorpay_order_id
        ).first()

        if existing_payment:
            # An existing record must refer to this same payment.
            if existing_payment.razorpay_payment_id != payment_id:
                messages.error(
                    request,
                    "A different payment is already recorded for this order.",
                )
                return redirect("checkout")

            # If already processed successfully, treat this as a retry.
            if locked_order.payment_status == "PAID":
                pass
            else:
                existing_payment.status = "SUCCESS"
                existing_payment.transaction_id = payment_id
                existing_payment.amount = order_amount_paise
                existing_payment.raw_response = payment_response_json
                existing_payment.save(update_fields=[
                    "status",
                    "transaction_id",
                    "amount",
                    "raw_response",
                ])

        else:
            # Save the successful payment in your payments table.
            Payment.objects.create(
                order_id=locked_order.id,
                payment_method=(payment.get("method") or "RAZORPAY"),
                transaction_id=payment_id,
                amount=order_amount_paise,
                status="SUCCESS",
                raw_response=payment_response_json,
                razorpay_order_id=order.razorpay_order_id,
                razorpay_payment_id=payment_id,
            )

        # Update the order only after the payment has been verified.
        if locked_order.payment_status != "PAID":
            locked_order.payment_status = "PAID"
            locked_order.order_status = "PROCESSING"
            locked_order.razorpay_payment_id = payment_id
            locked_order.save(update_fields=[
                "payment_status",
                "order_status",
                "razorpay_payment_id",
            ])

    # Clear payment session values only after the database transaction.
    request.session["last_successful_payment_id"] = payment_id
    request.session["last_successful_order_id"] = local_order_id

    request.session.pop("razorpay_order_id", None)
    request.session.pop("razorpay_amount", None)
    request.session.pop("current_order_id", None)

    messages.success(request, "Payment completed successfully!")
    return redirect("payment_success")

    # except Order.DoesNotExist:
    #     return render(
    #         request,
    #         "orders/payment_failed.html",
    #         {"message": "Order not found."},
    #         status=404,
    #     )

    # except Payment.DoesNotExist:
    #     logger.exception("Payment record lookup failed.")
    #     return render(
    #         request,
    #         "orders/payment_failed.html",
    #         {"message": "Payment could not be verified. Please contact support."},
    #         status=400,
    #     )

    # except IntegrityError:
    #     logger.exception(
    #         "Database integrity error while recording Razorpay payment."
    #     )
    #     return render(
    #         request,
    #         "orders/payment_failed.html",
    #         {"message": "We could not save your payment confirmation. Please contact support."},
    #         status=400,
    #     )

    # except Exception:
    #     logger.exception("Razorpay payment verification failed.")
    #     return render(
    #         request,
    #         "orders/payment_failed.html",
    #         {"message": "Payment could not be verified. Please contact support."},
    #         status=400,
    #     )

    
# def razorpay_payment_return(request):
#     """Verify payment signature and confirm the payment with Razorpay."""
#     order_id = request.session.get("razorpay_order_id")
#     expected_amount = request.session.get("razorpay_amount")

#     payment_id = request.POST.get("razorpay_payment_id")
#     returned_order_id = request.POST.get("razorpay_order_id")
#     signature = request.POST.get("razorpay_signature")

#     if not all([
#         order_id,
#         expected_amount,
#         payment_id,
#         returned_order_id,
#         signature,
#     ]):
#         return render(
#             request,
#             "payment_failed.html",
#             {"message": "Missing payment information."},
#             status=400,
#         )
    
#         # messages.error(request, "Payment details are incomplete.")
#         # return redirect("checkout")

#     # Never trust the order ID supplied by the browser.
#     if returned_order_id != order_id:
#         messages.error(request, "Payment order mismatch.")
#         return redirect("checkout")

#     try:

#         order = Order.objects.get(pk=order_id)

#         client = get_razorpay_client()

#         # Verify Razorpay Checkout's signature.
#         client.utility.verify_payment_signature({
#             "razorpay_order_id": order_id,
#             "razorpay_payment_id": payment_id,
#             "razorpay_signature": signature,
#         })

#         # Fetch payment details from Razorpay itself.
#         payment = client.payment.fetch(payment_id)

#         if payment.get("order_id") != order_id:
#             messages.error(request, "Payment order could not be verified.")
#             return redirect("checkout")

#         if int(payment.get("amount", 0)) != int(expected_amount):
#             messages.error(request, "Payment amount mismatch.")
#             return redirect("checkout")

#         # Only confirm a payment that Razorpay reports as captured.
#         if payment.get("status") != "captured":
#             messages.warning(
#                 request,
#                 "Payment is not yet confirmed. Please try again later.",
#             )
#             return redirect("checkout")

#         # IMPORTANT:
#         # Update your database Order model here to mark this order as paid.
#         # Save payment_id and order_id and clear the cart only after
#         # the corresponding database order is safely updated.

#         request.session["last_successful_payment_id"] = payment_id
#         request.session.pop("razorpay_order_id", None)
#         request.session.pop("razorpay_amount", None)

#         messages.success(request, "Payment completed successfully!")
#         return redirect("payment_success")

#     except Order.DoesNotExist:
#         return render(
#             request,
#             "payment_failed.html",
#             {"message": "Order not found."},
#             status=404,
#         )

#     except Exception:
#         # Log the exception server-side; don't expose secrets or
#         # internal payment details to the customer.
#         return render(
#             request,
#             "payment_failed.html",
#             {"message": "Payment could not be verified. Please contact support."},
#             status=400,
#         )



    

def order_confirmation(request, order_number):
    order = get_object_or_404(
        Order.objects.prefetch_related("items"),
        order_number=order_number,
    )

    # Customers should only see their own orders.
    if request.user.is_authenticated and not request.user.is_superuser:
        customer = Customer.objects.filter(
            username=request.user.username,
            is_superuser=False,
        ).first()

        if customer and order.customer_id != customer.id:
            from django.http import HttpResponseForbidden
            return HttpResponseForbidden("You cannot view this order.")

    elif order.customer_id is not None:
        from django.http import HttpResponseForbidden
        return HttpResponseForbidden("You cannot view this order.")

    elif order.session_key != request.session.session_key:
        from django.http import HttpResponseForbidden
        return HttpResponseForbidden("You cannot view this order.")

    return render(
        request,
        "orders/order_confirmation.html",
        {"order": order, "order_items": order.items.all()},
    )







@require_POST
def redirect_to_razorpay(request):
    if not settings.RAZORPAY_KEY_ID or not settings.RAZORPAY_KEY_SECRET:
        messages.error(request, "Payment gateway is not configured.")
        return redirect("checkout_view")

    session_key = request.session.session_key
    if not session_key:
        messages.error(request, "Your cart session has expired.")
        return redirect("cart_view")

    customer = None
    if request.user.is_authenticated and not request.user.is_superuser:
        customer = Customer.objects.filter(
            username=request.user.username,
            is_superuser=False,
        ).first()

    name = request.POST.get("full_name", "").strip()
    email = request.POST.get("email", "").strip()
    phone = request.POST.get("phone", "").strip()
    address = request.POST.get("address", "").strip()
    city = request.POST.get("city", "").strip()
    state = request.POST.get("state", "").strip()
    pincode = request.POST.get("pincode", "").strip()

    if not all([name, phone, address, city, state, pincode]):
        messages.error(request, "Please complete your shipping details.")
        return redirect("checkout_view")

    full_address = (
        f"{name}\nPhone: {phone}\nEmail: {email}\n"
        f"{address}\n{city}, {state} - {pincode}"
    )

    client = razorpay.Client(
        auth=(
            settings.RAZORPAY_KEY_ID,
            settings.RAZORPAY_KEY_SECRET,
        )
    )

    try:
        with transaction.atomic():
            order = (
                Order.objects.select_for_update()
                .filter(
                    session_key=session_key,
                    customer=customer,
                    order_status="PENDING",
                    payment_status="UNPAID",
                )
                .first()
            )

            if not order:
                messages.error(request, "Your cart is empty.")
                return redirect("cart_view")

            items = list(order.items.all())
            if not items:
                messages.error(request, "Your cart is empty.")
                return redirect("cart_view")

            subtotal = sum(
                (item.unit_price * item.quantity for item in items),
                Decimal("0.00"),
            )
            tax = order.tax_amount or Decimal("0.00")
            shipping = order.shipping_fee or Decimal("0.00")
            discount = order.discount_amount or Decimal("0.00")
            total = subtotal + tax + shipping - discount

            if total <= 0:
                messages.error(request, "Invalid order amount.")
                return redirect("cart_view")

            order.shipping_address = full_address
            order.billing_address = full_address
            order.subtotal = subtotal
            order.total_amount = total
            order.save()

            # Reuse a previously created, still-open payment link.
            if order.razorpay_payment_link_id:
                link = client.payment_link.fetch(
                    order.razorpay_payment_link_id
                )
                if link.get("status") == "created":
                    payment_url = link["short_url"]
                else:
                    order.razorpay_payment_link_id = None
                    order.save(update_fields=[
                        "razorpay_payment_link_id", "updated_at"
                    ])
                    payment_url = None
            else:
                payment_url = None

            if not payment_url:
                callback_url = request.build_absolute_uri(
                    reverse("razorpay_payment_return")
                )

                link = client.payment_link.create({
                    "amount": int(total * 100),
                    "currency": "INR",
                    "accept_partial": False,
                    "description": f"Kaya Fashion order {order.order_number}",
                    "reference_id": order.order_number,
                    "customer": {
                        "name": name,
                        "email": email,
                        "contact": phone,
                    },
                    "notify": {
                        "sms": True,
                        "email": bool(email),
                    },
                    "reminder_enable": False,
                    "callback_url": callback_url,
                    "callback_method": "get",
                })

                order.razorpay_payment_link_id = link["id"]
                order.save(update_fields=[
                    "razorpay_payment_link_id", "updated_at"
                ])
                payment_url = link["short_url"]

    except Exception:
        # Log the exception for debugging in production.
        messages.error(
            request,
            "Unable to open the payment gateway. Please try again."
        )
        return redirect("checkout_view")

    return redirect(payment_url)


@login_required
def checkout_view(request):
    return render(
        request,
        "orders/checkout.html",
    )


# @login_required
def payment_success(request):
    return render(
        request,
        "orders/payment_success.html",
    )



# READ: Coupon List
@staff_member_required
def coupon_list(request):
    coupons = Coupon.objects.all()
    return render(request, 'orders/coupon_list.html', {'coupons': coupons})

# CREATE: Add Coupon
@staff_member_required
def coupon_create(request):
    if request.method == 'POST':
        form = CouponForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'Coupon created successfully.')
            return redirect('coupon_list')
    else:
        form = CouponForm()
    return render(request, 'orders/coupon_form.html', {'form': form, 'title': 'Create Coupon'})

# UPDATE: Edit Coupon
@staff_member_required
def coupon_update(request, pk):
    coupon = get_object_or_404(Coupon, pk=pk)
    if request.method == 'POST':
        form = CouponForm(request.POST, instance=coupon)
        if form.is_valid():
            form.save()
            messages.success(request, 'Coupon updated successfully.')
            return redirect('coupon_list')
    else:
        form = CouponForm(instance=coupon)
    return render(request, 'orders/coupon_form.html', {'form': form, 'title': 'Edit Coupon'})

# DELETE: Remove Coupon
@staff_member_required
def coupon_delete(request, pk):
    coupon = get_object_or_404(Coupon, pk=pk)
    if request.method == 'POST':
        coupon.delete()
        messages.success(request, 'Coupon deleted successfully.')
        return redirect('coupon_list')
    return render(request, 'orders/coupon_confirm_delete.html', {'coupon': coupon})


# ==========================================
# PUBLIC CHECKOUT VALIDATION API / PROCESS
# ==========================================

def apply_coupon(request):
    if request.method == 'POST':
        form = ApplyCouponForm(request.POST)
        cart_total = request.session.get('cart_total', 0) # Fetch current cart total from session/DB

        if form.is_valid():
            code = form.cleaned_data['code'].upper()
            try:
                coupon = Coupon.objects.get(code=code)
                is_valid, msg = coupon.is_valid(cart_total=cart_total)

                if is_valid:
                    discount = coupon.calculate_discount(cart_total)
                    request.session['coupon_id'] = coupon.id
                    request.session['discount_amount'] = float(discount)
                    
                    messages.success(request, f"Coupon applied! You saved {discount}.")
                    return redirect('checkout')
                else:
                    messages.error(request, msg)

            except Coupon.DoesNotExist:
                messages.error(request, "Invalid coupon code.")

    return redirect('checkout')


## use for frontend


def create_order_from_checkout(request, customer, cart_data):
    coupon_id = request.session.get('coupon_id')
    coupon = None
    discount_amount = 0.00

    if coupon_id:
        try:
            coupon = Coupon.objects.get(id=coupon_id)
            # Increment the usage counter
            coupon.used_count += 1
            coupon.save()
            discount_amount = request.session.get('discount_amount', 0.00)
        except Coupon.DoesNotExist:
            coupon = None

    order = Order.objects.create(
        customer=customer,
        coupon=coupon,  # Link coupon here
        shipping_address=cart_data['shipping_address'],
        billing_address=cart_data['billing_address'],
        subtotal=cart_data['subtotal'],
        tax_amount=cart_data['tax'],
        shipping_fee=cart_data['shipping_fee'],
        discount_amount=discount_amount,
        total_amount=cart_data['total_amount'],
        order_status='PENDING',
        payment_status='UNPAID'
    )

    # Clear coupon from session after order is placed
    request.session.pop('coupon_id', None)
    request.session.pop('discount_amount', None)

    return order