from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework.views import APIView
from rest_framework import viewsets

from .models import User, Wollu, Stats
from .serializers import UserSerializer, WolluSerializer, WolluMonthSerializer, StatsSerializer
from django.db.models import Sum

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
                        values('create_date').annotate(all_time=Sum('all_time')), many=True).data)
        return Response(status=404)

class StatsViewSet(viewsets.ModelViewSet):
    queryset = Stats.objects.all()
    serializer_class = StatsSerializer

    def get_queryset(self):
        response = super().get_queryset()
        job = self.request.query_params.get('job')
        annual = self.request.query_params.get('annual')
        sex = self.request.query_params.get('sex')
        age = self.request.query_params.get('age')
        if None not in [job, annual, sex, age]:
            response = response.filter(category__in=[job, annual, sex, age])
        return response