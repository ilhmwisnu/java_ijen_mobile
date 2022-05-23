import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';
import 'package:java_ijen_mobile/screen/Auth/register_screen.dart';
import 'package:java_ijen_mobile/screen/MainScreen/dashboard.dart';
import '../../utils/auth.dart';
import '../../utils/validator.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";

  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final globalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isProcessing = false;
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MainScreen(
            user: user,
          ),
        ),
      );
    }
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/auth_bg.png"),
                        fit: BoxFit.cover)),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Form(
                    key: globalKey,
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
                          focusNode: _focusEmail,
                          controller: emailController,
                          decoration: formStyle.copyWith(hintText: "Email"),
                          validator: (value) => Validator.validateEmail(
                            email: value.toString(),
                          ),
                        ),
                        SizedBox(height: 24),
                        TextFormField(
                          focusNode: _focusPassword,
                          controller: passwordController,
                          obscureText: true,
                          decoration: formStyle.copyWith(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (value) => Validator.validatePassword(
                            password: value.toString(),
                          ),
                        ),
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: (_isProcessing)
                              ? CircularProgressIndicator()
                              : ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.red)),
                                  onPressed: () async {
                                    if (globalKey.currentState!.validate()) {
                                      setState(() {
                                        _isProcessing = true;
                                      });

                                      User? user = await FireAuth
                                          .signInUsingEmailPassword(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ).catchError((e){
                                        setState(() {
                                          _isProcessing = false
                                        });

                                        showDialog(context: context, builder: (context){
                                          return AlertDialog(title: Text("Login Failed"),content: Text(e),actions: [
                                            ElevatedButton(onPressed: () {
                                              Navigator.pop(context);
                                            }, child: Text("Okey"))
                                          ],);
                                        })
                                      });

                                      

                                      if (user != null) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MainScreen(user: user),
                                          ),
                                        );
                                      }
                                    }
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, RegisterScreen.routeName);
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
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    ));
  }
}
