from django.db import models

# Create your models here.

class Hero(models.Model):
    HeroId = models.AutoField(primary_key=True)
    HeroName = models.CharField(max_length=100)
    Power = models.CharField(max_length=150)
    Universe = models.CharField(max_length=100)
    CreationDate = models.DateField()
    PhotoFileName = models.CharField(max_length=100)
    Deleted = models.BooleanField(default=False)

class Universe(models.Model):
    UniverseId = models.AutoField(primary_key=True)
    UniverseName = models.CharField(max_length=100)

class Power(models.Model):
    PowerId = models.AutoField(primary_key=True)
    PowerName = models.CharField(max_length=100)
     