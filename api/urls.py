from django.conf.urls import include
from django.urls import path
from rest_framework import routers
from .views import ConnectionCheck, UserViewSet, WolluViewSet, WolluMonthView

router = routers.DefaultRouter()
router.register('users', UserViewSet)
router.register('wollu', WolluViewSet)

urlpatterns = [
    path("test/", ConnectionCheck),
    path('wollu/month/<int:user_id>/', WolluMonthView.as_view()),
    path('', include(router.urls))
]