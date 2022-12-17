from django.conf.urls import include
from django.urls import path
from rest_framework import routers
from .views import ConnectionCheck, UserViewSet

router = routers.DefaultRouter()
router.register('users', UserViewSet)

urlpatterns = [
    path("test/", ConnectionCheck),
    path('', include(router.urls))
]