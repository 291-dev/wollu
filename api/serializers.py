from .models import User, Wollu
from rest_framework.serializers import ModelSerializer

class UserSerializer(ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'nickname', 'salary', 'week_work', 'day_work',
        'job', 'annual', 'sex', 'age')

class WolluSerializer(ModelSerializer):
    class Meta:
        model = Wollu
        fields = ('id', 'user', 'all_time', 'no_work', 'coffe',
        'toilet', 'wind', 'shopping', 'smoking', 'something', 'turnover')