import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login";

  final globalKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/auth_bg.png"), fit: BoxFit.cover)),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 64),
                  Text(
                    "JAVA IJEN",
                    style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "COFFEE",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 64),
                  TextFormField(
                      controller: emailController,
                      decoration: formStyle.copyWith(hintText: "Email")),
                  SizedBox(height: 24),
                  TextFormField(
                      controller: passwordController,
                      decoration: formStyle.copyWith(
                          hintText: "Password",
                          suffixIcon: Icon(Icons.remove_red_eye),
                          prefixIcon: Icon(Icons.lock))),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          print("ini lupa password");
                        },
                        child: Text(
                          "Lupa password ?",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                      onPressed: () {
                        print("ini Masuk");
                        print(emailController.text +
                            " and " +
                            passwordController.text);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Masuk",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Belum punya akun?",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          print("ini daftar");
                        },
                        child: Text(
                          "DAFTAR",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
