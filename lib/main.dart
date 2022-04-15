import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/screen/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {LoginScreen.routeName: (context) => LoginScreen()},
      home: LoginScreen(),
    );
  }
}
