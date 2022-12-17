from .models import User
from rest_framework.serializers import ModelSerializer

class UserSerializer(ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'nickname', 'salary', 'week_work', 'day_work',
        'job', 'annual', 'sex', 'age')