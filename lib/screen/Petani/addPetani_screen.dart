import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/screen/Petani/petaniDB.dart';

class AddPetaniScreen extends StatefulWidget {
  static const routeName = "/addPetani";
  const AddPetaniScreen({Key? key}) : super(key: key);

  @override
  State<AddPetaniScreen> createState() => _AddPetaniScreenState();
}

class _AddPetaniScreenState extends State<AddPetaniScreen> {
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PetaniDB db = PetaniDB();
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Petani")),
      body: ListView(children: [
        TextField(
          controller: namaController,
          decoration: InputDecoration(hintText: "Nama"),
        ),
        TextField(
          controller: alamatController,
          decoration: InputDecoration(hintText: "Alamat"),
        ),
        ElevatedButton(
            onPressed: () async {
              await db
                  .addPetani(namaController.text, alamatController.text)
                  .then((value) => Navigator.pop(context));
            },
            child: Text("Tambah"))
      ]),
    );
  }
}
