import 'package:dogs_bloc/resources/dogListBlocProvider.dart';
import 'package:dogs_bloc/resources/loginBlocProvider.dart';
import 'package:dogs_bloc/ui/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LoginBlocProvider(
        child: DogListBlocProvider(
            child: MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    )));
  }
}
