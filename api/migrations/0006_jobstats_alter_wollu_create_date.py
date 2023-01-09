# Generated by Django 4.1.4 on 2023-01-03 12:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0005_alter_wollu_coffe_alter_wollu_no_work_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='JobStats',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('job', models.CharField(max_length=30)),
                ('min_wollu', models.IntegerField()),
                ('max_wollu', models.IntegerField()),
                ('total_wollu', models.IntegerField()),
                ('user_num', models.IntegerField()),
            ],
        ),
        migrations.AlterField(
            model_name='wollu',
            name='create_date',
            field=models.DateField(auto_now_add=True),
        ),
    ]