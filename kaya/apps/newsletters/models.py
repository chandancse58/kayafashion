import os
from django.db import models
from django.urls import reverse
from django.utils.text import slugify

from ckeditor.fields import RichTextField

class Newsletter(models.Model):
    STATUS_CHOICES = (
        ('draft', 'Draft'),
        ('published', 'Published'),
        ('archived', 'Archived'),
    )

    title = models.CharField(max_length=255, verbose_name="Title")
    slug = models.SlugField(max_length=255, unique=True, blank=True)    
    short_description = models.TextField(max_length=500, verbose_name="Short Description")
    textbox = RichTextField()
    image = models.ImageField(upload_to='newsletters/images/', blank=True, null=True, verbose_name="Image")
    video = models.FileField(upload_to='newsletters/videos/', blank=True, null=True, verbose_name="Video File")
    # Alternatively, for embedded links (e.g. YouTube):
    # video_url = models.URLField(blank=True, null=True, verbose_name="Video URL")
    
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='draft', verbose_name="Status")
    datetime = models.DateTimeField(auto_now_add=True, verbose_name="Date & Time")
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'newsletters'
        ordering = ['-datetime']
        verbose_name = "Newsletter"
        verbose_name_plural = "Newsletters"

    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return reverse('newsletter_detail', kwargs={'pk': self.pk})