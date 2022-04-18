import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/screen/MainScreen/dashboard.dart';
import 'package:java_ijen_mobile/referensi/login_page.dart';
import 'package:java_ijen_mobile/screen/Petani/petani_screen.dart';
import 'screen/Auth/login_screen.dart';
import 'screen/Auth/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        // LoginPage.routeName: (context) => LoginPage(),
        LoginScreen.routeName: (context) => LoginScreen(),
        // DashBoard.routeName: (context) => DashBoard(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        PetaniScreen.routeName: (context) => PetaniScreen()
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
