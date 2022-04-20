import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';
import 'package:java_ijen_mobile/screen/Petani/addPetani_screen.dart';

class PetaniScreen extends StatefulWidget {
  static const routeName = "/petani";

  const PetaniScreen({Key? key}) : super(key: key);

  @override
  State<PetaniScreen> createState() => _PetaniScreenState();
}

class _PetaniScreenState extends State<PetaniScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGrey,
        title: Text("Data Petani"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddPetaniScreen.routeName);
        },
        child: Icon(Icons.add),
        backgroundColor: green,
      ),
    );
  }
}
