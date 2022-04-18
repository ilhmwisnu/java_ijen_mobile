import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/referensi/home_screen.dart';
import 'package:java_ijen_mobile/screen/MainScreen/dashboard.dart';
import 'package:java_ijen_mobile/referensi/login_page.dart';

import '../const.dart';
import '../utils/auth.dart';
import '../utils/validator.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/register";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _phoneTextController = TextEditingController();
  // final _reTypePassTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusPhone = FocusNode();
  final _focusPass2 = FocusNode();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/auth_bg.png"),
                    fit: BoxFit.cover)),
          ),
          GestureDetector(
            onTap: () {
              _focusEmail.unfocus();
              _focusPassword.unfocus();
              _focusName.unfocus();
              _focusPhone.unfocus();
              _focusPass2.unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Form(
                  key: _registerFormKey,
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
                      SizedBox(height: 48),
                      TextFormField(
                        focusNode: _focusName,
                        controller: _nameTextController,
                        decoration:
                            formStyle.copyWith(hintText: "Nama Lengkap"),
                        validator: (value) => Validator.validateName(
                          name: value.toString(),
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        focusNode: _focusEmail,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailTextController,
                        decoration: formStyle.copyWith(
                            hintText: "Email", prefixIcon: Icon(Icons.email)),
                        validator: (value) => Validator.validateEmail(
                          email: value.toString(),
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        focusNode: _focusPhone,
                        keyboardType: TextInputType.phone,
                        controller: _phoneTextController,
                        decoration: formStyle.copyWith(
                          hintText: "Nomor Telepon",
                          prefixIcon: Icon(Icons.phone),
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        focusNode: _focusPassword,
                        obscureText: true,
                        controller: _passwordTextController,
                        decoration: formStyle.copyWith(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock),
                        ),
                        validator: (value) => Validator.validatePassword(
                          password: value.toString(),
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                          focusNode: _focusPass2,
                          obscureText: true,
                          // controller: _reTypePassTextController,
                          decoration: formStyle.copyWith(
                            hintText: "Konfirmasi Password",
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (value) {
                            if (value != _passwordTextController.text) {
                              return "Password tidak sesuai";
                            }
                            return null;
                          }),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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
                          onPressed: () async {
                            if (_registerFormKey.currentState!.validate()) {
                              setState(() {
                                _isProcessing = true;
                              });

                              User? user =
                                  await FireAuth.registerUsingEmailPassword(
                                name: _nameTextController.text,
                                email: _emailTextController.text,
                                password: _passwordTextController.text,
                                phoneNumber: _phoneTextController.text,
                              );

                              setState(() {
                                _isProcessing = false;
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
                              "Daftar",
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
                            "Sudah punya akun?",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            },
                            child: Text(
                              "LOGIN",
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
            ),
          )
        ],
      ),
    );
  }
}
