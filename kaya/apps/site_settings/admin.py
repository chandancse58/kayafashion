from django.contrib import admin
from .models import WebsiteSetting, Banner, InformationPage

class BannerInline(admin.TabularInline):
    model = Banner
    extra = 1
    fields = ('image', 'title', 'sub_title', 'link','order', 'is_active','banner_type')


@admin.register(WebsiteSetting)
class WebsiteSettingAdmin(admin.ModelAdmin):
    list_display = (
        'id',
        'site_title',
        'email',
        'contact_number',
        'city',
    )
    inlines = [BannerInline]



@admin.register(Banner)
class BannerAdmin(admin.ModelAdmin):
    list_display = ('id', 'website_setting', 'title', 'order', 'is_active', 'created_at')
    list_filter = ('is_active', 'website_setting')
    search_fields = ('title', 'sub_title')


@admin.register(InformationPage)
class InformationPageAdmin(admin.ModelAdmin):
    list_display = ('title', 'slug', 'sort_order', 'is_active', 'updated_at')
    list_filter = ('is_active',)
    search_fields = ('title', 'description', 'meta_title')
    prepopulated_fields = {'slug': ('title',)}
    
    fieldsets = (
        ('Content', {
            'fields': ('title', 'slug', 'description', 'sort_order', 'is_active')
        }),
        ('SEO Metadata', {
            'classes': ('collapse',),
            'fields': ('meta_title', 'meta_description', 'meta_keyword')
        }),
    )