import 'package:flutter/material.dart';
import 'package:routine/shared/shared.dart';
import 'package:routine/ui/pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Routine",
      theme: MyTheme.lightTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        Splash.routeName: (context) => Splash(),
        Menu.routeName: (context) => Menu(),
        Login.routeName: (context) => Login(),
        Register.routeName: (context) => Register(),
        AddHabit.routeName: (context) => AddHabit(),
        NewHabit.routeName: (context) => NewHabit(),
      },
    );
  }
}
