import os
from django.db import models
from django.utils.text import slugify
from django.urls import reverse
from ckeditor.fields import RichTextField

def upload_site_logo(instance, filename):
    return os.path.join('images/site/logo/', filename)

def upload_site_favicon(instance, filename):
    return os.path.join('images/site/favicon/', filename)

def upload_banner_image(instance, filename):
    return os.path.join('images/site/banners/', filename)


class WebsiteSetting(models.Model):
    id = models.BigAutoField(primary_key=True)
    site_title = models.CharField(max_length=100, verbose_name="Site Title")
    logo = models.ImageField(upload_to=upload_site_logo, null=True, blank=True, verbose_name="Logo")
    favicon = models.ImageField(upload_to=upload_site_favicon, null=True, blank=True, verbose_name="Favicon")
    email = models.EmailField(max_length=254, verbose_name="Email Address")
    contact_number = models.CharField(max_length=20, verbose_name="Contact Number",blank=True)
    address = models.TextField(verbose_name="Address")
    city = models.CharField(max_length=100, verbose_name="City")

    class Meta:
        db_table = 'websitesetting'
        verbose_name = "Website Setting"
        verbose_name_plural = "Website Settings"

    def __str__(self):
        return self.site_title


class Banner(models.Model):
    website_setting = models.ForeignKey(
        WebsiteSetting, 
        on_delete=models.CASCADE, 
        related_name='banners',
        verbose_name="Website Setting"
    )
    title = models.CharField(max_length=150, blank=True, null=True, verbose_name="Banner Title")
    sub_title = models.CharField(max_length=255, blank=True, null=True, verbose_name="Subtitle")
    image = models.ImageField(upload_to=upload_banner_image, verbose_name="Banner Image")
    link = models.URLField(max_length=500, blank=True, null=True, verbose_name="Redirect Link/URL")
    order = models.PositiveIntegerField(default=0, verbose_name="Display Order")
    is_active = models.BooleanField(default=True, verbose_name="Is Active")
    created_at = models.DateTimeField(auto_now_add=True)
    banner_type = models.CharField(max_length=55, blank=True, null=True, verbose_name="Banner Type")

    class Meta:
        db_table = 'site_banners'
        ordering = ['order', '-created_at']
        verbose_name = "Banner"
        verbose_name_plural = "Banners"

    def __str__(self):
        return self.title if self.title else f"Banner #{self.id}"


class InformationPage(models.Model):
    title = models.CharField(max_length=64, null=True, blank=True, verbose_name="Page Title")
    slug = models.SlugField(max_length=100, unique=True, blank=True, verbose_name="URL Slug")
    description = RichTextField()                    #models.TextField(null=True, blank=True, verbose_name="Page Content")
    
    # SEO Fields
    meta_title = models.CharField(max_length=255, null=True, blank=True, verbose_name="Meta Title")
    meta_description = models.CharField(max_length=255, null=True, blank=True, verbose_name="Meta Description")
    meta_keyword = models.CharField(max_length=255, null=True, blank=True, verbose_name="Meta Keywords")

    sort_order = models.IntegerField(default=0, verbose_name="Sort Order")
    is_active = models.BooleanField(default=True, verbose_name="Is Active")
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'information_page'
        ordering = ['sort_order', 'title']
        verbose_name = "Information Page"
        verbose_name_plural = "Information Pages"

    def save(self, *args, **kwargs):
        if not self.slug and self.title:
            self.slug = slugify(self.title)
        if not self.meta_title and self.title:
            self.meta_title = self.title
        super().save(*args, **kwargs)

    def __str__(self):
        return self.title or f"Page #{self.id}"