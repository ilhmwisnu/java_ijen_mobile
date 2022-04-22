import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/screen/Lahan/lahanDB.dart';

class AddLahanScreen extends StatefulWidget {
  static const routeName = "/addLahan";

  const AddLahanScreen({Key? key}) : super(key: key);

  @override
  State<AddLahanScreen> createState() => _AddLahanScreenState();
}

class _AddLahanScreenState extends State<AddLahanScreen> {
  TextEditingController alamatController = TextEditingController();
  TextEditingController pemilikController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController longController = TextEditingController();
  lahanDB db = lahanDB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Lahan")),
      body: ListView(children: [
        TextField(
          controller: alamatController,
          decoration: InputDecoration(hintText: "Alamat"),
        ),
        TextField(
          controller: pemilikController,
          decoration: InputDecoration(hintText: "Pemilik"),
        ),
        TextField(
          controller: latController,
          decoration: InputDecoration(hintText: "Latitude"),
        ),
        TextField(
          controller: longController,
          decoration: InputDecoration(hintText: "Longitude"),
        ),
        ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Save Data"),
                      content: Text("Yakin ingin menyimpan data?"),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              db.addLahan(
                                  alamatController.text,
                                  pemilikController.text,
                                  latController.text,
                                  longController.text);
                              Navigator.pop(context); // pop dialog
                              Navigator.pop(context); // pop add screen
                              print("iya bg");
                            },
                            child: Text("Iya")),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              print("ga bg");
                            },
                            child: Text("Tidak")),
                      ],
                    );
                  });
            },
            child: Text("Tambah"))
      ]),
    );
  }
}
