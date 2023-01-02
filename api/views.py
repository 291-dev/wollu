from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework.views import APIView
from rest_framework import viewsets

from .models import User, Wollu
from .serializers import UserSerializer, WolluSerializer, WolluMonthSerializer

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

class WolluMonthView(APIView):
    def get(self, request, user_id):
        year = request.GET['year']
        month = request.GET['month']
        if None not in [user_id, year, month]:
            return Response(WolluMonthSerializer(Wollu.objects.filter(user__exact=user_id,
                        create_date__year=year, create_date__month=month).
                        values('create_date', 'all_time'), many=True).data)
        return Response(status=404)