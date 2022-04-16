import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';

class HomePembeli extends StatelessWidget {
  static const routeName = "/homePembeli";
  const HomePembeli({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                              onPressed: () {},
                              icon: Icon(
                                Icons.logout,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    )),
                SizedBox(height: 500),
                Text("sjdnsjdnskjdnskj")
                // Text("data")
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 80, right: defaultPadding, left: defaultPadding),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration:
                    BoxDecoration(color: Colors.white, boxShadow: shadow),
                child: TextField(),
              ),
            )
          ],
        )),
      ),
    );
  }
}
