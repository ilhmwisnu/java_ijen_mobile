import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:java_ijen_mobile/screen/Lahan/lahanDB.dart';
import 'package:java_ijen_mobile/screen/Petani/petaniDB.dart';

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
  late List petani;
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
    // petani = await dbPetani.getName();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Lahan")),
      body: ListView(children: [
        TextField(
          controller: alamatController,
          decoration: InputDecoration(hintText: "Alamat"),
        ),

        // TODO ADD DROPDOWN ITEM SELECTOR

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
              getCurrentLocation();
            },
            child: Text("Get Lat Long")),
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
                              dbLahan.addLahan(
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

  getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      print("Lat ${position.latitude} Long ${position.longitude}");
      latController.text = position.latitude.toString();
      longController.text = position.longitude.toString();
    }).catchError((e) {
      print(e);
    });
  }
}
