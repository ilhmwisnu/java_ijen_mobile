import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:java_ijen_mobile/const.dart';
import 'package:java_ijen_mobile/screen/Transaksi/notifikasiPesanan.dart';
import 'package:java_ijen_mobile/screen/Transaksi/transaksi.dart';
import 'package:java_ijen_mobile/screen/Transaksi/transaksiDB.dart';

class TransferScreen extends StatefulWidget {
  static const routeName = "transfer";
  const TransferScreen({Key? key}) : super(key: key);

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  String filePath = "";
  // String uid = "";
  ImagePicker _picker = ImagePicker();
  TextEditingController _namaRekController = TextEditingController();
  TextEditingController _nomorRekController = TextEditingController();

  @override
  void initState() {
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user != null) {
    //     uid = user.uid;
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          elevation: 0,
          title: Text("Transfer"),
          backgroundColor: darkGrey,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Alamat tujuan",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Text("${data['alamat']}, ${data['provinsi']}, ${data['kota']}"),
                SizedBox(height: defaultPadding),
                Text(
                  "Detail Transaksi",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data["namaProduk"] +
                        " " +
                        data["jumlah"].toString() +
                        "x"),
                    Text((data["totalHarga"] * data["jumlah"]).toString()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Ongkos kirim"),
                    Text(data["ekspedisi"].harga.toString()),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total bayar ",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                        (data["totalHarga"] * data["jumlah"] +
                                data["ekspedisi"].harga)
                            .toString(),
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ],
                ),
                SizedBox(height: defaultPadding),
                Text(
                  "Data Pengirim",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _namaRekController,
                  decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      label: Text("Nama Rekening Pengirim"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _nomorRekController,
                  decoration: InputDecoration(
                      label: Text("Nomor Rekening Pengirim"),
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                SizedBox(height: defaultPadding),
                Text(
                  "Metode Pembayaran",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.all(defaultPadding),
                  child: Row(
                    children: [
                      Image.network(
                        "https://www.dreamcareerbuilder.com/uploads/employers/24574_ECLB.png",
                        width: 40,
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "a.n. Ilham Wisnu",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text("05xxxxxxx"),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: defaultPadding),
                Text(
                  "Bukti Transfer",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 12),
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
                          height: MediaQuery.of(context).size.width * 2 / 5,
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
                                (filePath == "") ? "Add photo" : "Change photo",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          )),
                        )
                      ],
                    )),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor:
                                    MaterialStateProperty.all(green)),
                            onPressed: () {
                              if (_namaRekController.text != "" &&
                                  _nomorRekController.text != "" &&
                                  filePath != "") {
                                    if (data["jumlah"] == 0) {
                                  TransaksiDB().AddSampleRequest(
                                      nomorRekening: _nomorRekController.text,
                                      namaRekening: _namaRekController.text,
                                      pathBuktiTf: filePath,
                                      idProduk: data["id"],
                                      provinsi: data['provinsi'],
                                      kota: data['kota'],
                                      alamat: data['alamat'],
                                      ekspedisi: data['ekspedisi']);
                                } else {
                                  TransaksiDB().AddProdukOrder(
                                      namaRekening: _namaRekController.text,
                                      nomorRekening: _nomorRekController.text,
                                      pathBuktiTf: filePath,
                                      idProduk: data["id"],
                                      provinsi: data['provinsi'],
                                      kota: data['kota'],
                                      alamat: data['alamat'],
                                      ekspedisi: data['ekspedisi'],
                                      jumlah: data['jumlah']);
                                }
                               
                                Navigator.pushReplacementNamed(
                                    context, KonfirmasiPesanan.routeName);
                              } else {
                                final snackBar = SnackBar(
                                  content:
                                      const Text('Data tidak boleh kosong!'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Text("Simpan"))),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
