import 'package:flutter/material.dart';
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
                ElevatedButton(
                    onPressed: () async {
                      await db
                          .addProduk(
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
                              hargaController.text)
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
