from .models import User, Wollu, Stats
from rest_framework.serializers import ModelSerializer

class UserSerializer(ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'nickname', 'salary', 'week_work', 'day_work',
        'job', 'annual', 'sex', 'age')

class WolluSerializer(ModelSerializer):
    class Meta:
        model = Wollu
        fields = ('id', 'user', 'create_date', 'all_time', 'no_work', 'coffe',
        'toilet', 'wind', 'shopping', 'smoking', 'something', 'turnover')

class WolluMonthSerializer(ModelSerializer):
    class Meta:
        model = Wollu
        fields = ('create_date', 'all_time')

class StatsSerializer(ModelSerializer):
    class Meta:
        model = Stats
        fields = ('id', 'category', 'min_wollu', 'max_wollu', 'total_wollu', 'user_num')