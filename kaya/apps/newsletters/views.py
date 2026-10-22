from django.shortcuts import render, get_object_or_404, redirect
from django.contrib import messages
from .models import Newsletter
from .forms import NewsletterForm

# 1. READ (List View)
def newsletter_list(request):
    newsletters = Newsletter.objects.all()
    return render(request, 'newsletter/list.html', {'newsletters': newsletters})

# 2. READ (Detail View)
def newsletter_detail(request, pk):
    newsletter = get_object_or_404(Newsletter, pk=pk)
    return render(request, 'newsletter/detail.html', {'newsletter': newsletter})

# 3. CREATE
def newsletter_create(request):
    if request.method == 'POST':
        form = NewsletterForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            messages.success(request, 'Newsletter created successfully!')
            return redirect('newsletter_list')
    else:
        form = NewsletterForm()
    return render(request, 'newsletter/form.html', {'form': form, 'action': 'Create'})

# 4. UPDATE
def newsletter_update(request, pk):
    newsletter = get_object_or_404(Newsletter, pk=pk)
    if request.method == 'POST':
        form = NewsletterForm(request.POST, request.FILES, instance=newsletter)
        if form.is_valid():
            form.save()
            messages.success(request, 'Newsletter updated successfully!')
            return redirect('newsletter_list')
    else:
        form = NewsletterForm(instance=newsletter)
    return render(request, 'newsletter/form.html', {'form': form, 'action': 'Update'})

# 5. DELETE
def newsletter_delete(request, pk):
    newsletter = get_object_or_404(Newsletter, pk=pk)
    if request.method == 'POST':
        newsletter.delete()
        messages.success(request, 'Newsletter deleted successfully!')
        return redirect('newsletter_list')
    return render(request, 'newsletter/confirm_delete.html', {'newsletter': newsletter})