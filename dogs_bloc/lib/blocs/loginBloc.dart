import 'dart:async';
import 'package:dio/dio.dart';
import 'package:rxdart/subjects.dart';

class LoginBloc {
  final StreamController<dynamic> _loginController =
      StreamController<dynamic>();
  final StreamController<int> _statusCodeController = BehaviorSubject<int>();

  LoginBloc() {
    _loginController.stream.listen(loginFunction);
  }

  Stream<int> get statusCode => _statusCodeController.stream;

  Sink<dynamic> get login => _loginController.sink;

  void loginFunction(arg) async {
    var statusCode = 0;
    var dio = Dio();
    Response response;
    try {
      response = await dio.post("https://reqres.in/api/register", data: arg);
      statusCode = response.statusCode;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
      statusCode = 400;
    }

    _statusCodeController.sink.add(statusCode);
  }

  void dispose() {
    _loginController.close();
    _statusCodeController.close();
  }
}
