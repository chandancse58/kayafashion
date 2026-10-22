
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.contrib.admin.views.decorators import staff_member_required
from .models import WebsiteSetting, Banner, InformationPage
from .forms import WebsiteSettingForm, MultiBannerUploadForm, BannerForm, InformationPageForm



# Read (List)
@staff_member_required
def setting_list(request):
    settings = WebsiteSetting.objects.all()
    return render(request, 'site_settings/setting_list.html', {'settings': settings})

@staff_member_required
def setting_create(request):
    if request.method == 'POST':
        form = WebsiteSettingForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            messages.success(request, 'Website setting created successfully.')
            return redirect('setting_list')
    else:
        form = WebsiteSettingForm()
    return render(request, 'site_settings/setting_form.html', {'form': form, 'title': 'Add Website Setting'})

@staff_member_required
def setting_update(request, pk):
    setting = get_object_or_404(WebsiteSetting, pk=pk)
    banners = setting.banners.all()
    
    if request.method == 'POST':
        form = WebsiteSettingForm(request.POST, request.FILES, instance=setting)
        banner_upload_form = MultiBannerUploadForm(request.POST, request.FILES)
        
        if form.is_valid():
            form.save()
            
            # Handle multi-banner batch uploads if files are provided
            if 'banners' in request.FILES:
                files = request.FILES.getlist('banners')
                for file in files:
                    Banner.objects.create(
                        website_setting=setting,
                        image=file
                    )
                messages.success(request, f'Updated settings and added {len(files)} new banners.')
            else:
                messages.success(request, 'Website setting updated successfully.')
                
            return redirect('setting_update', pk=setting.pk)
    else:
        form = WebsiteSettingForm(instance=setting)
        banner_upload_form = MultiBannerUploadForm()

    return render(request, 'site_settings/setting_form.html', {
        'form': form,
        'banner_upload_form': banner_upload_form,
        'setting': setting,
        'banners': banners,
        'title': 'Edit Website Setting & Banners'
    })

# Banner Delete View
@staff_member_required
def banner_delete(request, pk):
    banner = get_object_or_404(Banner, pk=pk)
    setting_pk = banner.website_setting.pk
    banner.delete()
    messages.success(request, 'Banner removed successfully.')
    return redirect('setting_update', pk=setting_pk)

# Delete
@staff_member_required
def setting_delete(request, pk):
    setting = get_object_or_404(WebsiteSetting, pk=pk)
    if request.method == 'POST':
        setting.delete()
        messages.success(request, 'Website setting deleted successfully.')
        return redirect('setting_list')
    return render(request, 'site_settings/setting_confirm_delete.html', {'setting': setting})


# READ: Page List
@staff_member_required
def info_page_list(request):
    pages = InformationPage.objects.all()
    return render(request, 'site_settings/info_page_list.html', {'pages': pages})

# CREATE: New Page
@staff_member_required
def info_page_create(request):
    if request.method == 'POST':
        form = InformationPageForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'Information page created successfully.')
            return redirect('info_page_list')
    else:
        form = InformationPageForm()
    return render(request, 'site_settings/info_page_form.html', {'form': form, 'title': 'Add Information Page'})

# UPDATE: Edit Page
@staff_member_required
def info_page_update(request, pk):
    page = get_object_or_404(InformationPage, pk=pk)
    if request.method == 'POST':
        form = InformationPageForm(request.POST, instance=page)
        if form.is_valid():
            form.save()
            messages.success(request, 'Information page updated successfully.')
            return redirect('info_page_list')
    else:
        form = InformationPageForm(instance=page)
    return render(request, 'site_settings/info_page_form.html', {'form': form, 'title': 'Edit Information Page'})

# DELETE: Remove Page
@staff_member_required
def info_page_delete(request, pk):
    page = get_object_or_404(InformationPage, pk=pk)
    if request.method == 'POST':
        page.delete()
        messages.success(request, 'Information page deleted successfully.')
        return redirect('info_page_list')
    return render(request, 'site_settings/info_page_confirm_delete.html', {'page': page})

# PUBLIC VIEW: Frontend display route
def info_page_detail(request, slug):
    page = get_object_or_404(InformationPage, slug=slug, is_active=True)
    return render(request, 'site_settings/info_page_detail.html', {'page': page})