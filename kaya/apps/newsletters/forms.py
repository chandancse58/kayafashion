from django import forms
import os
from .models import Newsletter


class NewsletterForm(forms.ModelForm):
    class Meta:
        model = Newsletter
        fields = ['title','slug', 'short_description', 'textbox', 'image', 'video', 'status']
        widgets = {
            'title': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Enter title'}),
            'slug': forms.TextInput(attrs={'class': 'form-control'}), 
            'short_description': forms.Textarea(attrs={'class': 'form-control', 'rows': 3, 'placeholder': 'Brief summary...'}),
            'textbox': forms.Textarea(attrs={'class': 'form-control', 'rows': 4, 'placeholder': 'Full content here...'}),
            'image': forms.FileInput(attrs={'class': 'form-control'}),
            'video': forms.FileInput(attrs={'class': 'form-control'}),
            'status': forms.Select(attrs={'class': 'form-control'}),
        }