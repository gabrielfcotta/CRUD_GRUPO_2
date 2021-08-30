from rest_framework import serializers
from CRUD.models import Hero, Universe, Power

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
        extra_kwargs = {'HeroName': {'required': False}}

class HeroSerializer(serializers.ModelSerializer):
    Power = PowerSerializer(many=True, read_only=True)
    class Meta: 
        model = Hero
        fields = ('HeroId',
                 'HeroName',
                 'UserId'
                 'Power',
                 'Universe',
                 'CreationDate',
                 'PhotoFileName',
                 'Deleted')
        extra_kwargs = {'Power': {'required': False}}
