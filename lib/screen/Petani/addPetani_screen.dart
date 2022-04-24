import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';
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
      appBar: AppBar(
        title: Text("Tambah Petani"),
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
              await db
                  .addPetani(namaController.text, alamatController.text)
                  .then((value) => Navigator.pop(context));
            },
          ),
          SizedBox(height: defaultPadding),
          ElevatedButton(
              onPressed: () async {
                await db
                    .addPetani(namaController.text, alamatController.text)
                    .then((value) => Navigator.pop(context));
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(green)),
              child: Text("Tambah"))
        ]),
      ),
    );
  }
}
