from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import viewsets

from .models import User, Wollu
from .serializers import UserSerializer, WolluSerializer

# Create your views here.
@api_view(['GET'])
def ConnectionCheck(request):
    return Response('connection success')

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class WolluViewSet(viewsets.ModelViewSet):
    queryset = Wollu.objects.all()
    serializer_class = WolluSerializer