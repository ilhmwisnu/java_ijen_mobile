import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../const.dart';
import '../../utils/auth.dart';
import '../login_screen.dart';

class HomeOwner extends StatefulWidget {
  User? user;
  HomeOwner({Key? key, this.user}) : super(key: key);

  @override
  State<HomeOwner> createState() => _HomeOwnerState();
}

class _HomeOwnerState extends State<HomeOwner> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              Container(
                  height: 110,
                  width: double.infinity,
                  color: darkGrey,
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "JAVA IJEN",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        IconButton(
                            onPressed: () {
                              FireAuth.logOut().then((value) =>
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      LoginScreen.routeName, (route) => false));
                            },
                            icon: Icon(
                              Icons.logout,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  )),
              SizedBox(height: 500),
              Text(widget.user!.uid)
              // Text("data")
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 80, right: defaultPadding, left: defaultPadding),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white, boxShadow: shadow),
              child: TextField(),
            ),
          )
        ],
      )),
    );
  }
}
