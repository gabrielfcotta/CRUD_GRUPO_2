from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from rest_framework.parsers import JSONParser
from django.http.response import JsonResponse

from CRUD.models import Universe, Power, Hero   
from CRUD.serializers import UniverseSerializer, PowerSerializer, HeroSerializer

from django.core.files.storage import default_storage

# Create your views here.
@csrf_exempt
def universeApi(request,id=0):
    if request.method=='GET':
        universe = Universe.objects.all()
        universe_serializer = UniverseSerializer(universe, many=True)
        return JsonResponse(universe_serializer.data, safe=False)

    elif request.method=='POST':
        universe_data=JSONParser().parse(request)
        universe_serializer = UniverseSerializer(data=universe_data)
        if universe_serializer.is_valid():
            universe_serializer.save()
            return JsonResponse("Added Successfully!!" , safe=False)
        return JsonResponse("Failed to Add.",safe=False)
    
    elif request.method=='PUT':
        universe_data = JSONParser().parse(request)
        universe=Universe.objects.get(UniverseId=universe_data['UniverseId'])
        universe_serializer=UniverseSerializer(universe,data=universe_data)
        if universe_serializer.is_valid():
            universe_serializer.save()
            return JsonResponse("Updated Successfully!!", safe=False)
        return JsonResponse("Failed to Update.", safe=False)

    elif request.method=='DELETE':
        universe=Universe.objects.get(UniverseId=id)
        universe.delete()
        return JsonResponse("Deleted Succeffully!!", safe=False)
        
@csrf_exempt
def powerApi(request,id=0):
    if request.method=='GET':
        power = Power.objects.all()
        power_serializer = PowerSerializer(power, many=True)
        return JsonResponse(power_serializer.data, safe=False)

    elif request.method=='POST':
        power_data=JSONParser().parse(request)
        power_serializer = PowerSerializer(data=power_data)
        if power_serializer.is_valid():
            power_serializer.save()
            return JsonResponse("Added Successfully!!" , safe=False)
        return JsonResponse("Failed to Add.",safe=False)
    
    elif request.method=='PUT':
        power_data = JSONParser().parse(request)
        power=Power.objects.get(PowerId=power_data['PowerId'])
        power_serializer=PowerSerializer(power,data=power_data)
        if power_serializer.is_valid():
            power_serializer.save()
            return JsonResponse("Updated Successfully!!", safe=False)
        return JsonResponse("Failed to Update.", safe=False)

    elif request.method=='DELETE':
        power=Power.objects.get(PowerId=id)
        power.delete()
        return JsonResponse("Deleted Succeffully!!", safe=False)

@csrf_exempt
def heroApi(request,id=0):
    if request.method=='GET':
        hero = Hero.objects.all()
        hero_serializer = HeroSerializer(hero, many=True)
        return JsonResponse(hero_serializer.data, safe=False)

    elif request.method=='POST':
        hero_data=JSONParser().parse(request)
        hero_serializer = HeroSerializer(data=hero_data)
        if hero_serializer.is_valid():
            hero_serializer.save()
            return JsonResponse("Added Successfully!!" , safe=False)
        return JsonResponse("Failed to Add.",safe=False)
    
    elif request.method=='PUT':
        hero_data = JSONParser().parse(request)
        hero=Hero.objects.get(HeroId=hero_data['HeroId'])
        hero_serializer=HeroSerializer(hero,data=hero_data)
        if hero_serializer.is_valid():
            hero_serializer.save()
            return JsonResponse("Updated Successfully!!", safe=False)
        return JsonResponse("Failed to Update.", safe=False)

    elif request.method=='DELETE':
        hero = Hero.objects.get(HeroId=id)
        setattr(hero,'Deleted','True')
        hero.save()
        return JsonResponse('Deleted', safe=False)

    #Na realidade é usado para recriar um herói que foi deletado
    elif request.method=='PATCH':
        hero = Hero.objects.get(HeroId=id)
        setattr(hero,'Deleted','False')
        hero.save()
        return JsonResponse('Recreated', safe=False)     
    


@csrf_exempt
def SaveFile(request):
    file=request.FILES['uploadedFile']
    file_name = default_storage.save(file.name,file)

    return JsonResponse(file_name,safe=False)

