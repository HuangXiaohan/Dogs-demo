import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  int _statusCode = 0;

  int get statusCode => _statusCode;

  void login(var email, var pwd) async {
    var dio = Dio();
    Response response;
    try {
      response = await dio.post("https://reqres.in/api/register",
          data: {"email": email, "password": pwd});
      _statusCode = response.statusCode;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
      _statusCode = 400;
    }

    notifyListeners();
  }
}
