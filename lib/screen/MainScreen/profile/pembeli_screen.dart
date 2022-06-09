import 'dart:io';
import 'package:flutter/material.dart';

import '../../../const.dart';
import '../../../utils/auth.dart';

class PembeliScreen extends StatefulWidget {
  static const routeName = "/pembeli_screen";

  const PembeliScreen({Key? key}) : super(key: key);

  @override
  State<PembeliScreen> createState() => _PembeliScreen();
}

class _PembeliScreen extends State<PembeliScreen> {
  bool isInit = false;
  late UserData pembeliData;

  @override
  void didChangeDependencies() {
    if (!isInit) {
      pembeliData = ModalRoute.of(context)!.settings.arguments as UserData;
    }
    super.didChangeDependencies();
  }

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
                      //color: darkGrey,
                      alignment: Alignment.topCenter,
                      child: Container(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Text(
                            "Data Pembeli",
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
                        Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9999),
                                      image: (pembeliData.img == null ||
                                              pembeliData.img == "")
                                          ? DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "https://www.interskill.id/empty-photo.png"))
                                          : DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  pembeliData.img))),
                                ),
                              ],
                            ),
                            Text(pembeliData.name),
                            Text(pembeliData.email),
                            Text(pembeliData.phoneNumber),
                          ],
                        ),
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
