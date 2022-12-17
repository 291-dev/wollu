from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import viewsets

from .models import User
from .serializers import UserSerializer

# Create your views here.
@api_view(['GET'])
def ConnectionCheck(request):
    return Response('connection success')

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer