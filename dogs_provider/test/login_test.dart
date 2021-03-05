import 'package:dogs_provider/providers/loginProvider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  LoginProvider loginProvider = new LoginProvider();
  group('Login', () {
    test('Login successfully', () {
      var email = "eve.holt@reqres.in";
      var pwd = "pistol";
      loginProvider.login(email, pwd);
      loginProvider.addListener(() {
        expect(loginProvider.statusCode, 200);
      });
    });

    test('Login unsuccessfully', () {
      var email = "sydney@fife";
      var pwd = "";
      loginProvider.login(email, pwd);
      loginProvider.addListener(() {
        expect(loginProvider.statusCode, 400);
      });
    });
  });
}
