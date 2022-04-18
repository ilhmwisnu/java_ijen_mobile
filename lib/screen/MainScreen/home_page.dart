import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/screen/Petani/petani_screen.dart';
import '../../const.dart';
import '../../utils/auth.dart';
import '../Auth/login_screen.dart';

class HomeOwner extends StatefulWidget {
  User? user;
  HomeOwner({Key? key, this.user}) : super(key: key);

  @override
  State<HomeOwner> createState() => _HomeOwnerState();
}

class _HomeOwnerState extends State<HomeOwner> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: SafeArea(
          child: Stack(
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
              SizedBox(height: 56),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.grey,
                    width: (screenSize.width - (defaultPadding * 3)) / 2,
                    height: (screenSize.width - (defaultPadding * 3)) / 2,
                    child: Center(child: Text("Comming Soon")),
                  ),
                  Container(
                    color: Colors.grey,
                    width: (screenSize.width - (defaultPadding * 3)) / 2,
                    height: (screenSize.width - (defaultPadding * 3)) / 2,
                    child: Center(child: Text("Comming Soon")),
                  )
                ],
              ),
              SizedBox(height: defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.grey,
                    width: (screenSize.width - (defaultPadding * 3)) / 2,
                    height: (screenSize.width - (defaultPadding * 3)) / 2,
                    child: Center(child: Text("Comming Soon")),
                  ),
                  Container(
                    color: Colors.grey,
                    width: (screenSize.width - (defaultPadding * 3)) / 2,
                    height: (screenSize.width - (defaultPadding * 3)) / 2,
                    child: Center(child: Text("Comming Soon")),
                  )
                ],
              ),
              SizedBox(height: defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.grey,
                    width: (screenSize.width - (defaultPadding * 3)) / 2,
                    height: (screenSize.width - (defaultPadding * 3)) / 2,
                    child: Center(child: Text("Comming Soon")),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PetaniScreen.routeName);
                    },
                    child: Container(
                      color: Colors.amber,
                      width: (screenSize.width - (defaultPadding * 3)) / 2,
                      height: (screenSize.width - (defaultPadding * 3)) / 2,
                      child: Center(child: Text("Data Petani")),
                    ),
                  )
                ],
              ),
              SizedBox(height: defaultPadding),
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
