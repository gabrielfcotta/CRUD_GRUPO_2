from rest_framework import serializers
from CRUD.models import Hero, Universe, Power

class UniverseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Universe
        fields = ('UniverseId',
                 'UniverseName')

class HeroSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Hero
        fields = ('HeroId',
                 'HeroName',
                 'UserId',
                 'Power',
                 'Universe',
                 'CreationDate',
                 'PhotoFileName',
                 'Deleted')
        extra_kwargs = {'Power': {'required': False}}

class PowerSerializer(serializers.ModelSerializer):
    heroes = HeroSerializer(many=True, read_only=True)
    class Meta:
        model = Power
        fields = ('PowerId',
                 'PowerName',
                 'heroes')
        extra_kwargs = {'heroes': {'required': False}}

