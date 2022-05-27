import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:java_ijen_mobile/screen/Lahan/lahan_screen.dart';
import 'package:java_ijen_mobile/screen/Petani/petani_screen.dart';
import 'package:java_ijen_mobile/screen/Transaksi/sample_screen.dart';
import '../../const.dart';
import '../../utils/auth.dart';
import '../../widget/menu_admin.dart';
import '../Auth/login_screen.dart';

class HomeOwner extends StatefulWidget {
  UserData userData;

  HomeOwner({Key? key, required this.userData}) : super(key: key);

  @override
  State<HomeOwner> createState() => _HomeOwnerState();
}

class _HomeOwnerState extends State<HomeOwner> {
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
                    child: TextField(
                  decoration: InputDecoration(
                      hintText: "Cari",
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none),
                )),
                IconButton(
                    onPressed: () {},
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
                Navigator.pushNamed(context, SampleScreen.routeName,
                    arguments: [widget.userData, "sampel"]);
              },
            ),
            MenuBtn(
              title: "Transaksi Berlangsung",
              imgPath: "assets/transaksi_berlangsung.png",
              onTap: () {
                Navigator.pushNamed(context, SampleScreen.routeName,
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
                // Navigator.pushNamed(context, LahanScreen.routeName);
              },
            ),
            MenuBtn(
              title: "Rekap Penjualan",
              imgPath: "assets/rekap_penjualan.png",
              onTap: () {
                // Navigator.pushNamed(context, LahanScreen.routeName);
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
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MenuPemb(
              title: "Permintaan Sampel Produk",
              imgPath: "assets/permintaan_sampel.png",
              onTap: () {
                Navigator.pushNamed(context, SampleScreen.routeName,
                    arguments: widget.userData);
              },
            ),
            MenuPemb(
              title: "Transaksi Berlangsung",
              imgPath: "assets/transaksi_berlangsung.png",
              onTap: () {
                // Navigator.pushNamed(context, LahanScreen.routeName);
              },
            ),
            MenuPemb(
              title: "Riwayat Pemesanan",
              imgPath: "assets/riwayat_pemesanan.png",
              onTap: () {
                // Navigator.pushNamed(context, LahanScreen.routeName);
              },
            ),
          ],
        )
      ]),
    );
  }
}
