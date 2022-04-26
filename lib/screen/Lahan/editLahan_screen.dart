import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:java_ijen_mobile/screen/Petani/petani.dart';
import 'package:java_ijen_mobile/screen/Petani/petaniDB.dart';
import 'package:searchfield/searchfield.dart';

import '../../const.dart';
import 'lahanDB.dart';

class EditLahan extends StatefulWidget {
  static const routeName = "/editLahan";

  const EditLahan({Key? key}) : super(key: key);

  @override
  State<EditLahan> createState() => _EditLahanState();
}

class _EditLahanState extends State<EditLahan> {
  bool _isInit = false;
  TextEditingController pemilikController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController longController = TextEditingController();
  List<Petani> _listPetani = [];
  LahanDB dbLahan = LahanDB();
  PetaniDB dbPetani = PetaniDB();

  @override
  void didChangeDependencies() async {
    if (!_isInit) {
      final id = ModalRoute.of(context)!.settings.arguments;
      final data = await dbLahan.getDataById(id.toString());
      _listPetani = await dbPetani.getPetani();
      // print(data["nama"]);
      setState(() {
        _isInit = true;
        pemilikController.text = data.namapemilik;
        alamatController.text = data.alamat;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Lahan"),
        backgroundColor: darkGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: ListView(children: [
          SizedBox(height: defaultPadding),
          TextField(
            controller: alamatController,
            decoration: InputDecoration(
                label: Text("Alamat"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
            onSubmitted: (str) async {
              await dbLahan
                  .updateLahan(
                      alamatController.text,
                      pemilikController.text,
                      ModalRoute.of(context)!.settings.arguments.toString(),
                      latController.text,
                      longController.text)
                  .then((value) => Navigator.pop(context));
            },
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
          SizedBox(height: defaultPadding),
          ElevatedButton(
              onPressed: () {
                dbLahan
                    .updateLahan(
                        alamatController.text,
                        _listPetani
                            .firstWhere((element) =>
                                element.nama == pemilikController.text)
                            .id,
                        ModalRoute.of(context)!.settings.arguments.toString(),
                        latController.text,
                        longController.text)
                    .then((value) => Navigator.pop(context));
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(darkChoco)),
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