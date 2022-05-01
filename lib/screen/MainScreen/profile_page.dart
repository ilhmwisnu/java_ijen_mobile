import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/utils/auth.dart';

import '../../const.dart';

class ProfilePage extends StatefulWidget {
  UserData userData;
  ProfilePage({Key? key, required this.userData}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 110,
                      width: double.infinity,
                      color: darkGrey,
                      alignment: Alignment.topCenter,
                      child: Container(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Text(
                            "PROFILE",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ))),
                  Container(
                    height: MediaQuery.of(context).size.height - 200,
                  )
                ],
              ),
              Positioned(
                  right: defaultPadding,
                  left: defaultPadding,
                  top: 60,
                  child: Container(
                    padding: EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: shadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 24),
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 210, 210, 210),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                        ),
                        SizedBox(height: 24),
                        DisTextField(
                            label: "Nama Lengkap", text: widget.userData.name),
                        SizedBox(height: defaultPadding),
                        DisTextField(
                            label: "Email", text: widget.userData.email),
                        SizedBox(height: defaultPadding),
                        DisTextField(
                            label: "No. Handphone",
                            text: widget.userData.phoneNumber),
                        SizedBox(height: defaultPadding),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8),
                              Text("Log Out")
                            ],
                          ),
                          onPressed: () {
                            FireAuth.logOut();
                          },
                        )
                      ],
                    ),
                  ))
            ],
          );
        },
      )),
    );
  }
}

class DisTextField extends StatelessWidget {
  String label, text;
  DisTextField({Key? key, required this.label, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: false,
      controller: TextEditingController(text: text),
      decoration: InputDecoration(
          label: Text(label),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }
}
