import 'package:flutter/material.dart';

import '../../const.dart';
import 'petaniDB.dart';

class EditPetani extends StatefulWidget {
  static const routeName = "/edit";
  const EditPetani({Key? key}) : super(key: key);

  @override
  State<EditPetani> createState() => _EditPetaniState();
}

class _EditPetaniState extends State<EditPetani> {
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    namaController.text = "Namaaa";
    alamatController.text = "Alamtttt";

    PetaniDB db = PetaniDB();
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
              await db
                  .addPetani(namaController.text, alamatController.text)
                  .then((value) => Navigator.pop(context));
            },
          ),
          SizedBox(height: defaultPadding),
          ElevatedButton(
              onPressed: () async {
                // await db
                //     .addPetani(namaController.text, alamatController.text)
                //     .then((value) => Navigator.pop(context));
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(darkChoco)),
              child: Text("Tambah"))
        ]),
      ),
    );
  }
}
