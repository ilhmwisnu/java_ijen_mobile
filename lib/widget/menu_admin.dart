import 'package:flutter/material.dart';

import '../const.dart';

class MenuBtn extends StatelessWidget {
  String imgPath, title;
  void Function() onTap;
  MenuBtn(
      {Key? key,
      required this.imgPath,
      required this.title,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (screenSize.width - (defaultPadding * 3)) / 2,
        height: (screenSize.width - (defaultPadding * 3)) / 2,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(imgPath),
              // fit: BoxFit.fill,
            ),
            SizedBox(height: 24),
            Text(
              title,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            )
          ],
        )),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: shadow),
      ),
    );
  }
}

class MenuPemb extends StatelessWidget {
  String imgPath, title;
  void Function() onTap;
  MenuPemb(
      {Key? key,
      required this.imgPath,
      required this.title,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        width: (screenSize.width - (defaultPadding * 4)) / 3,
        height: (screenSize.width - (defaultPadding * 4)) / 3,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(imgPath),
              // fit: BoxFit.fill,
              height: 50,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            )
          ],
        )),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: shadow),
      ),
    );
  }
}
