from django.shortcuts import render, redirect
from django.contrib import messages
from django.contrib.auth import login
from .forms import CustomerRegistrationForm

def register_customer(request):
    if request.method == 'POST':
        form = CustomerRegistrationForm(request.POST)
        if form.is_valid():
            customer = form.save()
            login(request, customer)  # Log in user automatically after signup
            messages.success(request, f"Account created successfully for {customer.username}!")
            return redirect('home')  # Replace with your homepage/dashboard URL name
    else:
        form = CustomerRegistrationForm()

    return render(request, 'accounts/register.html', {'form': form})