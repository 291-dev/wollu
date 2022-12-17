from django.db import models

# Create your models here.
class User(models.Model):
    nickname = models.CharField(max_length=20)
    salary = models.IntegerField()
    week_work = models.IntegerField()
    day_work = models.IntegerField()
    job = models.CharField(max_length=20)
    annual = models.IntegerField()
    sex = models.IntegerField()
    age = models.IntegerField()