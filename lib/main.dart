import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/screen/Lahan/editLahan_screen.dart';
import 'package:java_ijen_mobile/screen/MainScreen/dashboard.dart';
import 'package:java_ijen_mobile/referensi/login_page.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/addProduk_screen.dart';
import 'package:java_ijen_mobile/screen/Petani/addPetani_screen.dart';
import 'package:java_ijen_mobile/screen/Petani/editPetani_screen.dart';
import 'package:java_ijen_mobile/screen/Petani/petani_screen.dart';
import 'package:java_ijen_mobile/screen/Lahan/lahan_screen.dart';
import 'package:java_ijen_mobile/screen/Lahan/addLahan_screen.dart';
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
        PetaniScreen.routeName: (context) => PetaniScreen(),
        LahanScreen.routeName: (context) => LahanScreen(),
        AddPetaniScreen.routeName: (context) => AddPetaniScreen(),
        AddLahanScreen.routeName: (context) => AddLahanScreen(),
        AddProdukScreen.routeName: (context) => AddProdukScreen(),
        EditPetani.routeName: (context) => EditPetani(),
        EditLahan.routeName: (context) => EditLahan()
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
