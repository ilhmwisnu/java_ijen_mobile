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

class EditProduk extends StatefulWidget {
  static const routeName = "/editProduk";

  const EditProduk({Key? key}) : super(key: key);

  @override
  State<EditProduk> createState() => _EditProdukState();
}

class _EditProdukState extends State<EditProduk> {
  TextEditingController namaController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController petaniController = TextEditingController();
  TextEditingController lahanController = TextEditingController();
  TextEditingController prosesController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  LahanDB dbLahan = LahanDB();
  PetaniDB dbPetani = PetaniDB();
  ProdukDB dbProduk = ProdukDB();
  List<Petani> _listPetani = [];
  List<Lahan> _listLahan = [];
  bool _isInit = false;
  String filePath = "";
  String fileName = "";
  String remoteImg = "";
  late var id;

  @override
  void didChangeDependencies() async {
    if (!_isInit) {
      id = ModalRoute.of(context)!.settings.arguments;
      final data = await dbProduk.getDataById(id.toString());
      _listPetani = await dbPetani.getPetani();
      _listLahan = await dbLahan.getLahan();
      remoteImg = await dbProduk.getProductImg(id);
      var petani, lahan;
      for (var i = 0; i < _listPetani.length; i++) {
        if (_listPetani[i].id == data.idpetani) {
          petani = _listPetani[i].nama;
          break;
        }
      }
      for (var i = 0; i < _listLahan.length; i++) {
        if (_listLahan[i].id == data.idlahan) {
          lahan = "${_listLahan[i].alamat} - ${_listLahan[i].namapemilik}";
          break;
        }
      }
      setState(() {
        _isInit = true;
        namaController.text = data.nama;
        jumlahController.text = data.jumlah;
        petaniController.text = petani;
        lahanController.text = lahan;
        prosesController.text = data.proses;
        hargaController.text = data.harga;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Produk"),
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
            controller: jumlahController,
            decoration: InputDecoration(
                label: Text("Jumlah"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
          SizedBox(height: defaultPadding),
          SearchField(
            suggestions:
                _listPetani.map((e) => SearchFieldListItem(e.nama)).toList(),
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
                  final XFile? pickedFile =
                      await _picker.pickImage(source: ImageSource.gallery);
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
                          ? (remoteImg == null || remoteImg == "")
                              ? null
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(remoteImg))
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
                          "Change photo",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )),
                  )
                ],
              )),
          ElevatedButton(
              onPressed: () async {
                try {
                  await dbProduk.updateProduk(
                      id,
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
                  if (filePath != "") {
                    await dbProduk.addProductImg(id, filePath);
                  }
                  Navigator.pop(context);
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Terjadi Kesalahan"),
                          content: Text(e.toString()),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Oke"))
                          ],
                        );
                      });
                }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(green)),
              child: Text("Simpan")),
        ]),
      ),
    );
  }
}
