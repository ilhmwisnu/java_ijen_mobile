import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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
    FirebaseDatabase db = FirebaseDatabase.instance;
    DatabaseReference ref = FirebaseDatabase.instance.ref();

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
              print("kirim");
              try {
                await ref.child("petani").push().set({
                  "nama": namaController.text,
                  "alamat": alamatController.text
                });
              } catch (e) {
                print(e);
              }
            },
            child: Text("Tambah"))
      ]),
    );
  }
}
