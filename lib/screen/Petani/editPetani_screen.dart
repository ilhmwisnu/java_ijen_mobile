import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../const.dart';
import 'petaniDB.dart';

class EditPetani extends StatefulWidget {
  static const routeName = "/editPetani";

  const EditPetani({Key? key}) : super(key: key);

  @override
  State<EditPetani> createState() => _EditPetaniState();
}

class _EditPetaniState extends State<EditPetani> {
  bool _isInit = false;
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  PetaniDB db = PetaniDB();

  @override
  void didChangeDependencies() async {
    if (!_isInit) {
      final id = ModalRoute.of(context)!.settings.arguments;
      final data = await db.getPetaniDataById(id.toString());
      // print(data["nama"]);
      setState(() {
        _isInit = true;
        namaController.text = data.nama;
        alamatController.text = data.alamat;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Petani"),
        backgroundColor: darkGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: ListView(children: [
          TextField(
            controller: namaController,
            decoration: InputDecoration(
                label: Text("Nama"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
          SizedBox(height: defaultPadding),
          TextField(
            controller: alamatController,
            decoration: InputDecoration(
                label: Text("Alamat"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
            onSubmitted: (str) async {
              db
                  .updatePetani(
                    namaController.text,
                    alamatController.text,
                    ModalRoute.of(context)!.settings.arguments.toString(),
                  )
                  .then((value) => Navigator.pop(context));
            },
          ),
          SizedBox(height: defaultPadding),
          ElevatedButton(
              onPressed: () {
                db
                    .updatePetani(
                      namaController.text,
                      alamatController.text,
                      ModalRoute.of(context)!.settings.arguments.toString(),
                    )
                    .then((value) => Navigator.pop(context));
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(green)),
              child: Text("Simpan"))
        ]),
      ),
    );
  }
}
