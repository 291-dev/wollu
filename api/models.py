from django.db import models

# Create your models here.
class User(models.Model):
    nickname = models.CharField(max_length=20)
    salary = models.IntegerField()
    week_work = models.IntegerField()
    day_work = models.IntegerField()
    job = models.CharField(max_length=20, null=True)
    annual = models.CharField(max_length=20, null=True)
    sex = models.IntegerField(null=True)
    age = models.CharField(max_length=20, null=True)

class Wollu(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    create_date = models.DateField(auto_now_add=True)
    all_time = models.IntegerField()
    no_work = models.IntegerField(null=True)
    coffe = models.IntegerField(null=True)
    toilet = models.IntegerField(null=True)
    wind = models.IntegerField(null=True)
    shopping = models.IntegerField(null=True)
    smoking = models.IntegerField(null=True)
    something = models.IntegerField(null=True)
    turnover = models.IntegerField(null=True)

class Stats(models.Model):
    category = models.CharField(max_length=30)
    min_wollu = models.IntegerField()
    max_wollu = models.IntegerField()
    total_wollu = models.IntegerField()
    user_num = models.IntegerField()