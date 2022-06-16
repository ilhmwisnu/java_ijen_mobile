import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:java_ijen_mobile/screen/Lahan/lahan_screen.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/detailProduct.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/editProduk_screen.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/produk.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/produkDB.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/produkQR.dart';
import 'package:java_ijen_mobile/screen/MainScreen/scan_screen.dart';
import 'package:java_ijen_mobile/screen/Petani/petani_screen.dart';
import 'package:java_ijen_mobile/screen/Transaksi/rekap_screen.dart';
import 'package:java_ijen_mobile/screen/Transaksi/trans_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import '../../const.dart';
import '../../utils/auth.dart';
import '../../widget/menu_admin.dart';
import '../Auth/login_screen.dart';
import '../Transaksi/transaksiDB.dart';

class HomeOwner extends StatefulWidget {
  UserData userData;

  HomeOwner({Key? key, required this.userData}) : super(key: key);

  @override
  State<HomeOwner> createState() => _HomeOwnerState();
}

class _HomeOwnerState extends State<HomeOwner> {
  bool isLoading = true;
  List<Map<String, dynamic>> recomProduct = [];

  @override
  void initState() {
    fetchData();
    // TODO: implement initState
    super.initState();
  }

  void fetchData() async {
    var trans = await TransaksiDB()
        .getSuccesTrans(DateTime.now().month, DateTime.now().year);

    Map<String, dynamic> productSold = Map();

    for (var tran in trans) {
      if (!productSold.containsKey(tran.produk.nama)) {
        var img = await ProdukDB().getProductImg(tran.produk.id);
        productSold[tran.produk.nama] = {
          "produk": tran.produk,
          "jumlah": tran.jumlah,
          "img": img
        };
      } else {
        productSold[tran.produk.nama]["jumlah"] += tran.jumlah;
      }
    }

    for (var e in productSold.entries) {
      recomProduct.add(e.value);
    }
    recomProduct.sort((a, b) {
      return a["jumlah"] - b["jumlah"];
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: SafeArea(
          child: Stack(
        children: [
          Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 110,
                  width: double.infinity,
                  color: darkGrey,
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "JAVA IJEN",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                          "Yakin ingin logout dari aplikasi ?"),
                                      actions: [
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.grey)),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Batal")),
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.red)),
                                            onPressed: () {
                                              FireAuth.logOut().then((value) =>
                                                  Navigator
                                                      .pushNamedAndRemoveUntil(
                                                          context,
                                                          LoginScreen.routeName,
                                                          (route) => false));
                                            },
                                            child: Text("Logout"))
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(
                              Icons.logout,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  )),
              SizedBox(height: 56),
              (widget.userData.role == "admin")
                  ? AdminView(screenSize, context)
                  : PembeliView(screenSize),
              SizedBox(height: defaultPadding),
              // Text("Role : " + widget.userData.role)
              // Text("data")
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 80, right: defaultPadding, left: defaultPadding),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadow,
                  borderRadius: BorderRadius.circular(15)),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Expanded(
                    child: Text(
                  "Scan produk disini untuk melihat detail",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                )),
                IconButton(
                    onPressed: () async {
                      late PermissionStatus camStatus;

                      camStatus = await Permission.camera.status;
                      if (camStatus == PermissionStatus.denied) {
                        if (await Permission.camera.request().isGranted) {
                          camStatus = await Permission.camera.status;
                        }
                      }

                      var result = await BarcodeScanner.scan();
                      if (result.rawContent != "") {
                        Produk produk = await ProdukDB()
                            .getDataById(result.rawContent.toString());
                        if (produk.nama != null && produk.nama != "") {
                          Navigator.pushNamed(context, DetailProduct.routeName,
                              arguments: [produk.id, produk]);
                        } else {
                          final snackBar = SnackBar(
                            content: Text('QR Invalid'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } else {
                        final snackBar = SnackBar(
                          content: Text('QR Invalid'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    icon: Icon(
                      Icons.qr_code_scanner,
                      size: 32,
                    ))
              ]),
            ),
          )
        ],
      )),
    );
  }

  // Tampilan buat Admin
  Widget AdminView(Size screenSize, BuildContext context) {
    return Container(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MenuBtn(
              title: "Permintaan Sampel Produk",
              imgPath: "assets/permintaan_sampel.png",
              onTap: () {
                Navigator.pushNamed(context, TransScreen.routeName,
                    arguments: [widget.userData, "sampel"]);
              },
            ),
            MenuBtn(
              title: "Transaksi Berlangsung",
              imgPath: "assets/transaksi_berlangsung.png",
              onTap: () {
                Navigator.pushNamed(context, TransScreen.routeName,
                    arguments: [widget.userData, "pemesanan"]);
              },
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MenuBtn(
              title: "Riwayat Pemesanan",
              imgPath: "assets/riwayat_pemesanan.png",
              onTap: () {
                Navigator.pushNamed(context, TransScreen.routeName,
                    arguments: [widget.userData, "riwayat"]);
              },
            ),
            MenuBtn(
              title: "Rekap Penjualan",
              imgPath: "assets/rekap_penjualan.png",
              onTap: () {
                Navigator.pushNamed(context, RekapScreen.routeName);
              },
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MenuBtn(
              title: "Data Lahan",
              imgPath: "assets/data_lahan.png",
              onTap: () {
                Navigator.pushNamed(context, LahanScreen.routeName);
              },
            ),
            MenuBtn(
              title: "Data Petani",
              imgPath: "assets/data_petani.png",
              onTap: () {
                Navigator.pushNamed(context, PetaniScreen.routeName);
              },
            )
          ],
        ),
      ]),
    );
  }

  //Tampilan buat Pembeli
  Widget PembeliView(Size screenSize) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MenuPemb(
                title: "Permintaan Sampel Produk",
                imgPath: "assets/permintaan_sampel.png",
                onTap: () {
                  Navigator.pushNamed(context, TransScreen.routeName,
                      arguments: [widget.userData, "sampel"]);
                },
              ),
              MenuPemb(
                title: "Transaksi Berlangsung",
                imgPath: "assets/transaksi_berlangsung.png",
                onTap: () {
                  Navigator.pushNamed(context, TransScreen.routeName,
                      arguments: [widget.userData, "pemesanan"]);
                },
              ),
              MenuPemb(
                title: "Riwayat Pemesanan",
                imgPath: "assets/riwayat_pemesanan.png",
                onTap: () {
                  Navigator.pushNamed(context, TransScreen.routeName,
                      arguments: [widget.userData, "riwayat"]);
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(defaultPadding).copyWith(bottom: 0),
            child: Text(
              "Rekomendasi",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            // padding: EdgeInsets.all(defaultPadding),
            width: MediaQuery.of(context).size.width,
            height: 224 + defaultPadding * 4,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: recomProduct.length,
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      (widget.userData.role == "admin")
                          ? Navigator.pushNamed(context, EditProduk.routeName,
                                  arguments: recomProduct[index]["produk"].id)
                              .whenComplete(() => fetchData())
                          : Navigator.pushNamed(
                              context, DetailProduct.routeName, arguments: [
                              recomProduct[index]["produk"].id,
                              null
                            ]);
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(defaultPadding).copyWith(
                              top: defaultPadding * 2,
                              bottom: defaultPadding * 2 + 4,
                              right: 0),
                          width: (MediaQuery.of(context).size.width -
                                  defaultPadding * 3) /
                              2,
                          decoration: BoxDecoration(
                              boxShadow: shadow,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8)),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            recomProduct[index]["img"]))),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        recomProduct[index]["produk"].nama,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                          "Rp ${recomProduct[index]["produk"].harga} /kg",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                      Text(
                                        "Stok : ${recomProduct[index]["produk"].jumlah}",
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                        (widget.userData.role == "admin")
                            ? Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(99),
                                      color: Colors.black.withOpacity(0.2)),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.qr_code,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, ProdukQR.routeName,
                                          arguments: recomProduct[index]
                                              ["produk"]);
                                    },
                                  ),
                                ))
                            : SizedBox(
                                width: 0,
                              )
                      ],
                    ))),
          ),
        ],
      ),
    );
  }
}
