from django.db import models

# Create your models here.

# class ProductCategory(models.Model):
#     name = models.CharField(max_length=255, unique=True)
#     slug = models.CharField(max_length=255, unique=True)
#     title = models.CharField(max_length=255)
#     description = models.TextField()
#     thumbnail_image = models.CharField(max_length=100)
#     cover_image = models.CharField(max_length=100, null=True, blank=True)
#     meta_title = models.CharField(max_length=255)
#     meta_description = models.TextField()
#     meta_keywords = models.CharField(max_length=500)
#     created_at = models.DateTimeField()
#     updated_at = models.DateTimeField()

#     class Meta:
#         db_table = "product_categories"

#     def __str__(self):
#         return self.name