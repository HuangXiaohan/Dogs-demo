import 'package:dogs_bloc/blocs/loginBloc.dart';
import 'package:flutter/material.dart';

class LoginBlocProvider extends InheritedWidget {
  final LoginBloc loginBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<LoginBlocProvider>().loginBloc;

  LoginBlocProvider({Key key, LoginBloc loginBloc, Widget child})
      : this.loginBloc = loginBloc ?? LoginBloc(),
        super(key: key, child: child);
}
