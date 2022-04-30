import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:java_ijen_mobile/screen/Lahan/lahan_screen.dart';
import 'package:java_ijen_mobile/screen/Petani/petani_screen.dart';
import '../../const.dart';
import '../../utils/auth.dart';
import '../Auth/login_screen.dart';

class HomeOwner extends StatefulWidget {
  UserData userData;

  HomeOwner({Key? key, required this.userData}) : super(key: key);

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
              (widget.userData.role == "admin")
                  ? AdminView(screenSize, context)
                  : PembeliView(screenSize),
              SizedBox(height: defaultPadding),
              Text("Role : " + widget.userData.role)
              // Text("data")
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 80, right: defaultPadding, left: defaultPadding),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white, boxShadow: shadow),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                      hintText: "Cari",
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none),
                )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.qr_code_scanner,
                      size: 32,
                    ))
              ]),
            ),
          )
        ],
      )),
    );
  }

  // Tampilan buat Admin
  Widget AdminView(Size screenSize, BuildContext context) {
    return Container(
      child: Column(children: [
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
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, LahanScreen.routeName);
              },
              child: Container(
                color: Colors.amber,
                width: (screenSize.width - (defaultPadding * 3)) / 2,
                height: (screenSize.width - (defaultPadding * 3)) / 2,
                child: Center(child: Text("Data Lahan")),
              ),
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
      ]),
    );
  }

  //Tampilan buat Pembeli
  Widget PembeliView(Size screenSize) {
    return Container(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              color: Colors.grey,
              width: (screenSize.width - (defaultPadding * 4)) / 3,
              height: (screenSize.width - (defaultPadding * 4)) / 3,
              child: Center(child: Text("Comming Soon")),
            ),
            Container(
              color: Colors.grey,
              width: (screenSize.width - (defaultPadding * 4)) / 3,
              height: (screenSize.width - (defaultPadding * 4)) / 3,
              child: Center(child: Text("Comming Soon")),
            ),
            Container(
              color: Colors.grey,
              width: (screenSize.width - (defaultPadding * 4)) / 3,
              height: (screenSize.width - (defaultPadding * 4)) / 3,
              child: Center(child: Text("Comming Soon")),
            ),
          ],
        )
      ]),
    );
  }
}
