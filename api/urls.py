from django.urls import path
from .views import ConnectionCheck

urlpatterns = [
    path("connect/", ConnectionCheck)
]