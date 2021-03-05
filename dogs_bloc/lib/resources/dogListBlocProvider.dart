import 'package:dogs_bloc/blocs/dogListBloc.dart';
import 'package:flutter/material.dart';

class DogListBlocProvider extends InheritedWidget {
  final DogListBloc dogListBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static DogListBloc of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<DogListBlocProvider>()
      .dogListBloc;

  DogListBlocProvider({Key key, DogListBloc loginBloc, Widget child})
      : this.dogListBloc = loginBloc ?? DogListBloc(),
        super(key: key, child: child);
}
