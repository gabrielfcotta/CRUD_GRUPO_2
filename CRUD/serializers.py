from rest_framework import serializers
from CRUD.models import Hero, Universe, Power

class HeroSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Hero
        fields = ('HeroId',
                 'HeroName',
                 'Power',
                 'Universe',
                 'CreationDate',
                 'PhotoFileName',
                 'Deleted')

class UniverseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Universe
        fields = ('UniverseId',
                 'UniverseName')

class PowerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Power
        fields = ('PowerId',
                 'PowerName')
