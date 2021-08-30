from django.conf.urls import url
from CRUD import views

from django.conf.urls.static import static
from django.conf import settings

urlpatterns=[
    url(r'^universe/$',views.universeApi),
    url(r'^universe/([0-9]+)$',views.universeApi),

    url(r'^power/$',views.powerApi),
    url(r'^power/([0-9]+)$',views.powerApi),

    url(r'^hero/$',views.heroApi),
    url(r'^hero/([0-9]+)$',views.heroApi),

    url(r'^SaveFile$', views.SaveFile)
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)