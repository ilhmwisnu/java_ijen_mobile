import 'dart:io';
import 'dart:ui';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Pembeli"),
        backgroundColor: darkGrey,
      ),
      body: SingleChildScrollView(
        child: SafeArea(child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Container(
                width: double.infinity,
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
                                  image: NetworkImage(pembeliData.img))),
                    ),
                    SizedBox(height: 12),
                    Text(
                      pembeliData.name,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(pembeliData.email, style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Text(pembeliData.phoneNumber,
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            );
          },
        )),
      ),
    );
  }
}
