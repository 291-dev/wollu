import 'dart:convert';

import 'User.dart';
import 'package:http/http.dart' as http;

class UserProvider{
  Uri uri = Uri.parse("http://3.35.111.171:80/test");

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  Future<dynamic> get() async {
    http.Response response =
        await http.get(uri, headers: headers);
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400) {

    }
    return json.decode(utf8.decode(response.bodyBytes));
  }

  Future<bool> post(User user) async {
      http.Response response = await http.post(uri,
          body: {
            'nickname': user.nickname,
            'salary': user.salary,
            'week_work': user.week_work,
            'day_work': user.day_work,
            'job': user.job,
            'annual': user.annual,
            'sex': user.sex,
            'age': user.age
          },
          headers: <String, String> {
            'Content-Type': 'application/x-www-form-urlencoded',
          }
      );
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400) {
        return false;
      }
      return true;
    }

}