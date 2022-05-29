import 'package:flutter/material.dart';

class BuktiTF extends StatefulWidget {
  static const routeName = "buktiTF";
  const BuktiTF({Key? key}) : super(key: key);

  @override
  State<BuktiTF> createState() => _BuktiTFState();
}

class _BuktiTFState extends State<BuktiTF> {
  bool isInit = false;
  String imgUrl = '';

  @override
  void didChangeDependencies() {
    if (!isInit) {
      setState(() {
        imgUrl = ModalRoute.of(context)!.settings.arguments as String;
      });
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bukti Transfer"),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(imgUrl),
      ),
    );
  }
}
