import json
from rest_framework.test import APITestCase
from rest_framework.views import status

class UserApiTest(APITestCase):
    def setUp(self):
        user_data = {
            "nickname" : "test_user",
            "salary" : 50000000,
            "week_work" : 4,
            "day_work" : 8,
            "job" : "개발/소프트웨어/하드웨어",
            "annual" : "2~3년차",
            "sex" : 1,
            "age" : "30~32세"
        }
        response = self.client.post('/users/', user_data)
        response_json = json.loads(response.content)
        self.user_id = str(response_json["id"])

    def testCreate(self):
        user_data = {
            "nickname" : "test_user",
            "salary" : 50000000,
            "week_work" : 4,
            "day_work" : 8,
            "job" : "개발/소프트웨어/하드웨어",
            "annual" : "2~3년차",
            "sex" : 1,
            "age" : "30~32세"
        }
        response = self.client.post('/users/', user_data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def testUpdate(self):
        user_data = {
            "nickname" : "test_user_update",
            "salary" : 60000000,
            "week_work" : 7,
            "day_work" : 6,
            "job" : "개발/QA",
            "annual" : "4~6년차",
            "sex" : 0,
            "age" : "33~36세"
        }
        response = self.client.put('/users/' + self.user_id + '/', user_data)
        self.assertEqual(response.status_code, status.HTTP_200_OK)