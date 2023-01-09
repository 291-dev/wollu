from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework.views import APIView
from rest_framework import viewsets

from .models import User, Wollu, Stats
from .serializers import *
from django.db.models import Sum, Max
from django.core.exceptions import ObjectDoesNotExist

# Create your views here.
@api_view(['GET'])
def ConnectionCheck(request):
    return Response('connection success')

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

    def get_user(user_id):
        return UserSerializer(User.objects.get(id__exact=user_id))

class WolluViewSet(viewsets.ModelViewSet):
    queryset = Wollu.objects.all()
    serializer_class = WolluSerializer

    def create(self, request):
        response = super().create(request)
        user_id = request.POST['user']
        all_time = request.POST['all_time']
        user_info = UserViewSet.get_user(user_id)
        for category in ['job', 'annual', 'sex', 'age']:
            StatsViewSet.update_stats(user_info[category].value, all_time)
        return response

class WolluMonthView(APIView):
    def get(self, request, user_id):
        year = request.GET['year']
        month = request.GET['month']
        if None not in [user_id, year, month]:
            return Response(WolluMonthSerializer(Wollu.objects.filter(user__exact=user_id,
                        create_date__year=year, create_date__month=month).
                        values('create_date').annotate(all_time=Sum('all_time')), many=True).data)
        return Response(status=404)

class WolluRankingView(APIView):
    def get(self, request):
        wollu_ranking = Wollu.objects.values('user').annotate(all_time=Max('all_time')).order_by('-all_time').values('user_id', 'all_time')
        response = []
        for wollu in wollu_ranking:
            user_info = UserViewSet.get_user(wollu['user_id'])
            data = {
                'nickname': user_info['nickname'].value,
                'all_time': wollu['all_time']
            }
            response.append(data)
        return Response(response)

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
    
    def update_stats(category, time):
        try:
            stats = Stats.objects.get(category__exact=category)
            stats.max_wollu = max(stats.max_wollu, int(time))
            stats.min_wollu = min(stats.min_wollu, int(time))
            stats.user_num += 1
            stats.total_wollu += int(time)
            stats.save()
        except ObjectDoesNotExist:
            stats = Stats(category=category, min_wollu=time, max_wollu=time,
                total_wollu=time, user_num=1)
            stats.save()
