from django.db import models

# Create your models here.

class Universe(models.Model):
    UniverseId = models.AutoField(primary_key=True)
    UniverseName = models.CharField(max_length=100)

class Power(models.Model):
    PowerId = models.AutoField(primary_key=True)
    PowerName = models.CharField(max_length=100)

class Hero(models.Model):
    HeroId = models.AutoField(primary_key=True)
    HeroName = models.CharField(max_length=100)
    Power = models.ManyToManyField(Power, related_name='HeroName', blank=True)
    Universe = models.ForeignKey(Universe, on_delete=models.CASCADE)
    CreationDate = models.DateField()
    PhotoFileName = models.CharField(max_length=100)
    Deleted = models.BooleanField(default=False)