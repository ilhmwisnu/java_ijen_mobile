import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:java_ijen_mobile/const.dart';
import 'package:java_ijen_mobile/screen/Lahan/lahanDB.dart';
import 'package:java_ijen_mobile/screen/Petani/petaniDB.dart';
import 'package:searchfield/searchfield.dart';

import '../Petani/petani.dart';

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
  LahanDB dbLahan = LahanDB();
  PetaniDB dbPetani = PetaniDB();
  List<Petani> _listPetani = [];
  late Position currentPosition;
  bool _isLoading = false;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    setState(() {
      _isLoading = true;
    });
    _listPetani = await dbPetani.getPetani();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Lahan"),
        backgroundColor: darkGrey,
      ),
      body: (_isLoading)
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: ListView(children: [
                SizedBox(height: 16),
                TextField(
                  controller: alamatController,
                  decoration: InputDecoration(
                      hintText: "Alamat",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                SizedBox(height: 16),
          SearchField(
            searchInputDecoration: InputDecoration(
                hintText: "Pemilik",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
            suggestions:
                _listPetani.map((e) => SearchFieldListItem(e.nama)).toList(),
            controller: pemilikController,
          ),
          SizedBox(height: 16),
          TextField(
            controller: latController,
            decoration: InputDecoration(
                hintText: "Latitude",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
          SizedBox(height: 16),
          TextField(
            controller: longController,
            decoration: InputDecoration(
                hintText: "Longitude",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
          SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {
                getCurrentLocation();
              },
              child: Text("Get Current Location")),
          ElevatedButton(
              onPressed: () {
                // showDialog(
                //     context: context,
                //     builder: (context) {
                //       return AlertDialog(
                //         title: Text("Save Data"),
                //         content: Text("Yakin ingin menyimpan data?"),
                //         actions: [
                //           ElevatedButton(
                //               onPressed: () {
                dbLahan
                    .addLahan(
                        alamatController.text,
                        _listPetani
                            .firstWhere((element) =>
                                element.nama == pemilikController.text)
                            .id,
                        latController.text,
                        longController.text)
                    .then((value) => Navigator.pop(context));
                //              Navigator.pop(context); // pop add screen
                //           },
                //           child: Text("Iya")),
                //       ElevatedButton(
                //           onPressed: () {
                //             Navigator.pop(context);
                //
                //           },
                //           child: Text("Tidak")),
                //     ],
                //   );
                // });
              },
              child: Text("Tambah"))
        ]),
      ),
    );
  }

  getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      latController.text = position.latitude.toString();
      longController.text = position.longitude.toString();
    }).catchError((e) {
      print(e);
    });
  }
}
