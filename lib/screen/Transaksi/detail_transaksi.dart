import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:java_ijen_mobile/const.dart';
import 'package:java_ijen_mobile/screen/MainScreen/profile/pembeli_screen.dart';
import 'package:java_ijen_mobile/screen/Transaksi/detailBuktiTF_screen.dart';
import 'package:java_ijen_mobile/screen/Transaksi/transaksi.dart';
import 'package:java_ijen_mobile/screen/Transaksi/transaksiDB.dart';
import 'package:java_ijen_mobile/utils/auth.dart';
import 'package:intl/intl.dart';

class DetailTransaksi extends StatefulWidget {
  static const routeName = "detail_transaksi";

  const DetailTransaksi({Key? key}) : super(key: key);

  @override
  State<DetailTransaksi> createState() => _DetailTransaksiState();
}

class _DetailTransaksiState extends State<DetailTransaksi> {
  bool isInit = false;
  late Transaksi transaksi;
  bool _isLoading = true;
  ImagePicker _picker = ImagePicker();
  TextEditingController _resiController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  String filePath = '';
  late UserData userData;
  late String status;
  late String page;
  late String imgUrl;
  late UserData pembeliData;

  @override
  void didChangeDependencies() {
    if (!isInit) {
      init();
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void init() async {
    final arg = ModalRoute.of(context)!.settings.arguments as List;
    transaksi = arg[0];
    userData = arg[1];
    page = arg[2];
    pembeliData = arg[3];
    imgUrl = await TransaksiDB()
        .getBuktiImg(transaksi.transId, page, transaksi.jumlah);
    print(imgUrl);
    status = transaksi.status;
    setState(() {
      _resiController.text = transaksi.resi;
      _alamatController.text = transaksi.alamat;
      isInit = true;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat nominal = NumberFormat("#,##0", "en_US");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGrey,
        title: Text("Detail Transaksi"),
      ),
      body: (_isLoading)
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                      boxShadow: shadow,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(transaksi.imgUrl))),
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(transaksi.transId,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade500)),
                                Text(
                                  transaksi.produk.nama,
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                    (transaksi.jumlah == 0)
                                        ? "Gratis"
                                        : "Rp " +
                                            nominal.format(int.parse(
                                                transaksi.produk.harga)) +
                                            "/kg",
                                    style: TextStyle(fontSize: 16)),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 8),
                        Divider(),
                        SizedBox(height: 8),
                        (userData.role == "admin")
                            ? Text("Info Pembeli",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500))
                            : SizedBox(width: 0),
                        (userData.role == "admin" && pembeliData != null)
                            ? Row(
                                children: [
                                  SizedBox(height: 4),
                                  Material(
                                    color: Colors.green,
                                    shape: CircleBorder(),
                                    //clipBehavior: Clip.hardEdge,
                                    child: IconButton(
                                      icon: Icon(Icons.account_box_rounded),
                                      color: Colors.white,
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, PembeliScreen.routeName,
                                            arguments: pembeliData);
                                      },
                                    ),
                                  ),
                                  Text(pembeliData.name)
                                ],
                              )
                            : SizedBox(width: 0),
                        SizedBox(width: 8),
                        Text("Info Pengiriman",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Flexible(
                                child: Text("Kurir"),
                                flex: 2,
                                fit: FlexFit.tight),
                            Flexible(child: Text(transaksi.ekspedisi), flex: 3),
                          ],
                        ),
                        (userData.role == "admin")
                            ? Row(
                                children: [
                                  Flexible(
                                      child: Text("Alamat"),
                                      flex: 2,
                                      fit: FlexFit.tight),
                                  Flexible(
                                      child: Text(transaksi.alamat +
                                          ", " +
                                          transaksi.kota +
                                          ", " +
                                          transaksi.prov),
                                      flex: 3),
                                ],
                              )
                            : Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                          child: Text("Alamat"),
                                          flex: 2,
                                          fit: FlexFit.tight),
                                      Flexible(
                                          child: (DateTime.now()
                                                      .difference(
                                                          transaksi.waktuPesan)
                                                      .inHours <
                                                  2) //TODO ganti < ke > untuk debug detail trans pembeli
                                              ? Column(
                                                  children: [
                                                    SizedBox(height: 8),
                                                    TextField(
                                                        controller:
                                                            _alamatController,
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)))),
                                                    SizedBox(height: 8),
                                                  ],
                                                )
                                              : Text(transaksi.alamat),
                                          flex: 3),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                          child: Text("Kota"),
                                          flex: 2,
                                          fit: FlexFit.tight),
                                      Flexible(
                                          child: Text(transaksi.kota), flex: 3),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                          child: Text("Provinsi"),
                                          flex: 2,
                                          fit: FlexFit.tight),
                                      Flexible(
                                          child: Text(transaksi.prov), flex: 3),
                                    ],
                                  ),
                                ],
                              ),
                        userData.role == "admin"
                            ? SizedBox(
                                height: 12,
                              )
                            : SizedBox(
                                height: 0,
                              ),
                        userData.role == "admin" &&
                                !(transaksi.status == "Selesai" ||
                                    transaksi.status == "Dibatalkan")
                            ? TextField(
                                controller: _resiController,
                                decoration: InputDecoration(
                                    label: Text("Resi Pengiriman"),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))))
                            : Row(
                                children: [
                                  Flexible(
                                      child: Text("Resi"),
                                      flex: 2,
                                      fit: FlexFit.tight),
                                  Flexible(
                                      child: transaksi.resi == "" ||
                                              transaksi.resi == null
                                          ? Text("Belum ada resi")
                                          : Text(transaksi.resi.toString()),
                                      flex: 3),
                                ],
                              ),
                        SizedBox(height: 20),
                        Text("Info Pesanan",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Flexible(
                                child: Text("Ongkir"),
                                flex: 2,
                                fit: FlexFit.tight),
                            Flexible(
                                child: Text(
                                    "Rp " + nominal.format(transaksi.ongkir)),
                                flex: 3),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                                child: Text("Jumlah (kg)"),
                                flex: 2,
                                fit: FlexFit.tight),
                            Flexible(
                                child:
                                    Text(transaksi.jumlah.toString() + " kg"),
                                flex: 3),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                                child: Text("Total pembayaran"),
                                flex: 2,
                                fit: FlexFit.tight),
                            Flexible(
                                child: Text("Rp " +
                                    nominal.format(transaksi.ongkir +
                                        transaksi.jumlah *
                                            int.parse(transaksi.produk.harga))),
                                flex: 3),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text("Info Pembayaran",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Flexible(
                                child: Text("Nama rekening"),
                                flex: 2,
                                fit: FlexFit.tight),
                            Flexible(child: Text(transaksi.namaRek), flex: 3),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                                child: Text("Nomor rekening"),
                                flex: 2,
                                fit: FlexFit.tight),
                            Flexible(child: Text(transaksi.noRek), flex: 3),
                          ],
                        ),
                        SizedBox(height: 12),
                        GestureDetector(
                            onTap: () async {
                              if (userData.role == "admin") {
                                Navigator.pushNamed(context, BuktiTF.routeName,
                                    arguments: imgUrl);
                              } else {
                                if (DateTime.now()
                                        .difference(transaksi.waktuPesan)
                                        .inHours <
                                    2) {
                                  //TODO ganti < ke > untuk debug detail trans pembeli
                                  try {
                                    final XFile? pickedFile = await _picker
                                        .pickImage(source: ImageSource.gallery);
                                    print("ini image_picker");
                                    setState(() {
                                      filePath = pickedFile!.path;
                                    });
                                  } catch (e) {
                                    setState(() {
                                      filePath = "";
                                    });
                                  }
                                } else {
                                  Navigator.pushNamed(
                                      context, BuktiTF.routeName,
                                      arguments: imgUrl);
                                }
                              }
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  height:
                                      MediaQuery.of(context).size.width * 2 / 5,
                                  decoration: BoxDecoration(
                                      color: (filePath == null ||
                                              filePath == "" ||
                                              imgUrl == null ||
                                              imgUrl == "")
                                          ? Colors.grey
                                          : null,
                                      borderRadius: BorderRadius.circular(12),
                                      image: (filePath == null ||
                                              filePath == "")
                                          ? (imgUrl == null || imgUrl == "")
                                              ? null
                                              : DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(imgUrl))
                                          : DecorationImage(
                                              fit: BoxFit.cover,
                                              image:
                                                  FileImage(File(filePath)))),
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
                                      Text(
                                        (userData.role == "admin")
                                            ? "View photo"
                                            : DateTime.now()
                                                        .difference(transaksi
                                                            .waktuPesan)
                                                        .inHours <
                                                    2 //TODO ganti < ke > untuk debug detail trans pembeli
                                                ? "Change photo"
                                                : "View photo",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  )),
                                )
                              ],
                            )),
                        SizedBox(height: 12),
                        (userData.role == "admin" &&
                                !(transaksi.status == "Selesai" ||
                                    transaksi.status == "Dibatalkan"))
                            ? DropdownButton(
                                underline: Text(""),
                                isExpanded: true,
                                value: status,
                                items: [
                                  "Menunggu Konfirmasi",
                                  "Dalam Proses",
                                  "Dibatalkan",
                                  "Selesai"
                                ]
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e),
                                          value: e,
                                        ))
                                    .toList(),
                                onChanged: (String? selected) {
                                  setState(() {
                                    status = selected!;
                                  });
                                })
                            : SizedBox(height: 0),
                        SizedBox(height: 16),
                        userData.role == "admin" &&
                                !(transaksi.status == "Selesai" ||
                                    transaksi.status == "Dibatalkan")
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(green),
                                          elevation:
                                              MaterialStateProperty.all(0)),
                                      onPressed: () {
                                        String photo, alamat, resi;
                                        if (filePath == "" ||
                                            filePath == null) {
                                          photo = "-";
                                        } else {
                                          photo = filePath;
                                        }
                                        if (_alamatController.text == "" ||
                                            _alamatController.text == null) {
                                          alamat = "-";
                                        } else {
                                          alamat = _alamatController.text;
                                        }
                                        if (_resiController.text == "" ||
                                            _resiController.text == null) {
                                          resi = "-";
                                        } else {
                                          resi = _resiController.text;
                                        }
                                        TransaksiDB()
                                            .updateTrans(
                                                transaksi.transId,
                                                page,
                                                userData.role,
                                                photo,
                                                status,
                                                alamat,
                                                resi)
                                            .then((value) =>
                                                Navigator.pop(context));
                                      },
                                      child: Text("Simpan")),
                                ],
                              )
                            : (DateTime.now()
                                        .difference(transaksi.waktuPesan)
                                        .inHours <
                                    2) //TODO ganti < ke > untuk debug detail trans pembeli
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                              "Anda hanya dapat mengubah pesanan kurang dari 2 jam setelah pemesanan "),
                                        ),
                                      ),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      green),
                                              elevation:
                                                  MaterialStateProperty.all(0)),
                                          onPressed: () {
                                            String photo, alamat, resi;
                                            if (filePath == "" ||
                                                filePath == null) {
                                              photo = "-";
                                            } else {
                                              photo = filePath;
                                            }
                                            if (_alamatController.text == "" ||
                                                _alamatController.text ==
                                                    null) {
                                              alamat = "-";
                                            } else {
                                              alamat = _alamatController.text;
                                            }
                                            if (_resiController.text == "" ||
                                                _resiController.text == null) {
                                              resi = "-";
                                            } else {
                                              resi = _resiController.text;
                                            }
                                            TransaksiDB()
                                                .updateTrans(
                                                    transaksi.transId,
                                                    page,
                                                    userData.role,
                                                    photo,
                                                    status,
                                                    alamat,
                                                    resi)
                                                .then((value) =>
                                                    Navigator.pop(context));
                                          },
                                          child: Text("Simpan")),
                                    ],
                                  )
                                : SizedBox(height: 0),
                        // DateTime.now().difference(transaksi.waktuPesan).inHours < 2
                        //         ? null
                        //         : null
                      ]),
                ),
              ),
            ),
    );
  }
}
