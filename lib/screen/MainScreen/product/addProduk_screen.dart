import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:java_ijen_mobile/const.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/produkDB.dart';
import 'package:searchfield/searchfield.dart';

import '../../Lahan/lahan.dart';
import '../../Lahan/lahanDB.dart';
import '../../Petani/petani.dart';
import '../../Petani/petaniDB.dart';

class AddProdukScreen extends StatefulWidget {
  static const routeName = "/addProduk";

  const AddProdukScreen({Key? key}) : super(key: key);

  @override
  State<AddProdukScreen> createState() => _AddProdukScreenState();
}

class _AddProdukScreenState extends State<AddProdukScreen> {
  TextEditingController namaController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController petaniController = TextEditingController();
  TextEditingController lahanController = TextEditingController();
  TextEditingController prosesController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  LahanDB dbLahan = LahanDB();
  PetaniDB dbPetani = PetaniDB();
  List<Petani> _listPetani = [];
  List<Lahan> _listLahan = [];
  bool _isLoading = false;
  String filePath = "";
  String fileName = "";

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
    _listLahan = await dbLahan.getLahan();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    ProdukDB db = ProdukDB();
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Produk"),
        backgroundColor: darkGrey,
      ),
      body: (_isLoading)
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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
                  controller: jumlahController,
                  decoration: InputDecoration(
                      label: Text("Jumlah"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                SizedBox(height: defaultPadding),
                SearchField(
                  suggestions: _listPetani
                      .map((e) => SearchFieldListItem(e.nama))
                      .toList(),
                  controller: petaniController,
                  searchInputDecoration: InputDecoration(
                      label: Text("Petani"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                SizedBox(height: defaultPadding),
                SearchField(
                  suggestions: _listLahan
                      .map((e) =>
                          SearchFieldListItem("${e.alamat} - ${e.namapemilik}"))
                      .toList(),
                  controller: lahanController,
                  searchInputDecoration: InputDecoration(
                      label: Text("Lahan"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                SizedBox(height: defaultPadding),
                TextField(
                  controller: prosesController,
                  decoration: InputDecoration(
                      label: Text("Proses"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                SizedBox(height: defaultPadding),
                TextField(
                  controller: hargaController,
                  decoration: InputDecoration(
                      label: Text("Harga"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                SizedBox(height: defaultPadding),
                GestureDetector(
                    onTap: () async {
                      try {
                        final XFile? pickedFile = await _picker.pickImage(
                            source: ImageSource.gallery);
                        print("ini image_picker");
                        setState(() {
                          filePath = pickedFile!.path;
                        });
                      } catch (e) {
                        setState(() {
                          filePath = "";
                        });
                      }
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: MediaQuery.of(context).size.width * 3 / 4,
                          decoration: BoxDecoration(
                            color: (filePath == null || filePath == "")
                                ? Colors.grey
                                : null,
                            borderRadius: BorderRadius.circular(15),
                            image: (filePath == null || filePath == "")
                                ? null
                                : DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(File(filePath))),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Add a photo",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          )),
                        )
                      ],
                    )),
                ElevatedButton(
                    onPressed: () async {
                      final id = await db.addProduk(
                          namaController.text,
                          jumlahController.text,
                          _listPetani
                              .firstWhere((element) =>
                                  element.nama == petaniController.text)
                              .id,
                          _listLahan
                              .firstWhere((element) =>
                                  "${element.alamat} - ${element.namapemilik}" ==
                                  lahanController.text)
                              .id,
                          prosesController.text,
                          hargaController.text);
                      await db.addProductFile(id, filePath);
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(green)),
                    child: Text("Tambah")),
              ]),
            ),
    );
  }
}
