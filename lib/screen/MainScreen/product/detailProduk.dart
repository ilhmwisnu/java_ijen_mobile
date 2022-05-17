import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';

class DetailProduct extends StatelessWidget {
  static const routeName = "/detailProduct";
  const DetailProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 4),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: () {},
                      child: Text("Minta Sampel"))),
              SizedBox(width: 8),
              Expanded(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(green)),
                      onPressed: () {},
                      child: Text("Pesan"))),
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text("Detail Produk"),
        backgroundColor: darkGrey,
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.amber,
            width: screenSize.width,
            height: screenSize.width,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama Produk",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rp 30.000",
                  style: TextStyle(fontSize: 20, color: darkChoco),
                ),
                SizedBox(height: 8),
                Text(
                  "Stok : 99",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                SizedBox(height: 16),
                Text(
                  "Lokasi lahan",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text("Rembangan"),
                SizedBox(height: 16),
                Text(
                  "Pemilik lahan",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text("Bapak Tejo")
              ],
            ),
          )
        ],
      ),
    );
  }
}
