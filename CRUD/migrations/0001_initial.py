# Generated by Django 3.2.6 on 2021-08-30 11:33

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Power',
            fields=[
                ('PowerId', models.AutoField(primary_key=True, serialize=False)),
                ('PowerName', models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='Universe',
            fields=[
                ('UniverseId', models.AutoField(primary_key=True, serialize=False)),
                ('UniverseName', models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='Hero',
            fields=[
                ('HeroId', models.AutoField(primary_key=True, serialize=False)),
                ('HeroName', models.CharField(max_length=100)),
                ('CreationDate', models.DateField()),
                ('PhotoFileName', models.CharField(max_length=100)),
                ('Deleted', models.BooleanField(default=False)),
                ('Power', models.ManyToManyField(blank=True, related_name='HeroName', to='CRUD.Power')),
                ('Universe', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CRUD.universe')),
            ],
        ),
    ]
