import 'package:dogs_bloc/resources/loginBlocProvider.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  var email;
  var password;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: StreamBuilder<int>(
            stream: LoginBlocProvider.of(context).statusCode,
            builder: (context, AsyncSnapshot<int> snapshot) {
              return snapshot.data == 200
                  ? Text(
                      "Welcome!",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )
                  : loginWidget();
            }));
  }

  Widget loginWidget() {
    return StreamBuilder<int>(
        stream: LoginBlocProvider.of(context).statusCode,
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 150,
                    height: 120,
                    child: Image(image: AssetImage('images/dog.jpg'))),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // ex: eve.holt@reqres.in
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            hintText: 'Enter your email',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onChanged: (text) {
                            email = text;
                          },
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 10),
                            // ex: pistol
                            child: TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                                hintText: 'Enter your password',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onChanged: (text) {
                                password = text;
                              },
                            )),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                              snapshot.data == 400
                                  ? "Email or password not correct."
                                  : "",
                              style: TextStyle(color: Colors.red)),
                        ),
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  var logindata = {
                                    "email": email,
                                    "password": password
                                  };
                                  LoginBlocProvider.of(context)
                                      .login
                                      .add(logindata);
                                }
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(fontSize: 20),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
