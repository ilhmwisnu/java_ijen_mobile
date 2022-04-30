import 'package:flutter/material.dart';

import '../../utils/auth.dart';

class ProductPage extends StatefulWidget {
  UserData userData;
  ProductPage({Key? key, required this.userData}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {

    // Kalo mau akses role bisa pake widget.userData.role disini

    return Center(
      child: Text("Product Page"),
    );
  }
}
