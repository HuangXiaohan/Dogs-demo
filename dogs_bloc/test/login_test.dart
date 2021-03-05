import 'package:dogs_bloc/blocs/loginBloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  LoginBloc loginBloc = new LoginBloc();

  group('Login', () {
    test('Login successfully', () {
      var info = {"email": "eve.holt@reqres.in", "password": "pistol"};
      loginBloc.loginFunction(info);
      loginBloc.statusCode.listen((data) {
        expect(data, 200);
      });
    });

    test('Login unsuccessfully', () {
      var info = {"email": "sydney@fife", "password": ""};
      loginBloc.loginFunction(info);
      loginBloc.statusCode.listen((data) {
        expect(data, 400);
      });
    });
  });
}
