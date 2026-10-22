from django.contrib import admin
from .models import Newsletter

@admin.register(Newsletter)
class NewsletterAdmin(admin.ModelAdmin):
    # Columns to show in the list view
    list_display = ('title','slug', 'status', 'datetime')
    
    # Add filters on the right sidebar
    list_filter = ('status', 'datetime')
    
    # Add a search bar for specific fields
    search_fields = ('title', 'short_description', 'textbox')
    
    # Make timestamp fields read-only so they can't be manually edited
    readonly_fields = ('datetime', 'updated_at')
    
    # Optional: Organize the edit form layout
    fieldsets = (
        ('Basic Information', {
            'fields': ('title','slug', 'short_description', 'status')
        }),
        ('Content', {
            'fields': ('textbox', 'image', 'video')
        }),
        ('Timestamps', {
            'fields': ('datetime', 'updated_at'),
            'classes': ('collapse',)
        }),
    )