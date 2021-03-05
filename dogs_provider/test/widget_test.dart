import 'dart:math';

import 'package:dogs_provider/providers/dogListProvider.dart';
import 'package:dogs_provider/providers/loginProvider.dart';
import 'package:dogs_provider/ui/dogList.dart';
import 'package:dogs_provider/ui/homePage.dart';
import 'package:dogs_provider/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

//class LoginMock extends Mock implements LoginProvider {}

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => DogListProvider())
      ],
      child: MaterialApp(
        home: Scaffold(
          body: child,
        ),
      ),
    );
  }

  testWidgets('Test navigation bar', (WidgetTester tester) async {
    // Build hompage widget
    await tester.pumpWidget(makeTestableWidget(child: HomePage()));
    await tester.pump(Duration(seconds: 1));

    // Display bottom navigation bar
    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.byIcon(Icons.list_alt), findsOneWidget);

    // Enter login page
    await tester.tap(find.byIcon(Icons.person));
    await tester.pump(Duration(seconds: 1));

    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Enter doglist page
    await tester.tap(find.byIcon(Icons.list_alt));
    await tester.pump(Duration(seconds: 1));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Test login', (WidgetTester tester) async {
    // Build login widget
    await tester.pumpWidget(makeTestableWidget(child: Login()));
    await tester.pump(Duration(seconds: 1));

    // Display form for login
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Welcome!'), findsNothing);

    // Enter wrong email/password
    await tester.enterText(find.byType(TextFormField).at(0), "sydney@fife");
    await tester.enterText(find.byType(TextFormField).at(1), " ");

    // Tap login button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(Duration(seconds: 1));

    // Display error message
    expect(find.text("Email or password not correct."), findsOneWidget);

    /*LoginMock loginMock = new LoginMock();
    loginMock.statusCode;
    verify(loginMock.statusCode);

    when(loginMock.statusCode).thenReturn(200);
    expect(loginMock.statusCode, 200);*/
  });

  testWidgets('Test doglist', (WidgetTester tester) async {
    // Build doglist widget
    await tester.pumpWidget(makeTestableWidget(child: DogList()));
    await tester.pump(Duration(seconds: 1));

    expect(find.byType(ListView), findsOneWidget);
  });
}
