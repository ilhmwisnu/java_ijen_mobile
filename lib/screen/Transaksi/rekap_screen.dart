import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/produkDB.dart';
import 'package:java_ijen_mobile/screen/Transaksi/transaksi.dart';
import 'package:java_ijen_mobile/screen/Transaksi/transaksiDB.dart';

class RekapScreen extends StatefulWidget {
  static const routeName = "rekapScreen";
  const RekapScreen({Key? key}) : super(key: key);

  @override
  State<RekapScreen> createState() => _RekapScreenState();
}

class _RekapScreenState extends State<RekapScreen> {
  int tahun = 2022;
  int bulan = DateTime.now().month;
  int totalPendapatan = 0;
  Map<String, dynamic> productSold = Map();
  bool isLoading = true;

  @override
  void initState() {
    fetchData();
    // TODO: implement initState
    super.initState();
  }

  void fetchData() async {
    var trans = await TransaksiDB().getSuccesTrans(bulan, tahun);
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
      totalPendapatan += tran.jumlah * int.parse(tran.produk.harga);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    const months = {
      1: "Januari",
      2: "Februari",
      3: "Maret",
      4: "April",
      5: "Mei",
      6: "Juni",
      7: "Juli",
      8: "Agustus",
      9: "September",
      10: "Oktober",
      11: "November",
      12: "Desember",
    };

    const years = [2022, 2023, 2024];

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: darkGrey,
        title: Text("Rekap Penjualan"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Bulan",
                        style: TextStyle(color: Colors.grey.shade500)),
                    DropdownButton(
                        borderRadius: BorderRadius.circular(15),
                        value: bulan,
                        items: months.entries
                            .map((e) => DropdownMenuItem(
                                value: e.key, child: Text(e.value)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            bulan = int.parse(value.toString());
                            isLoading = true;
                            totalPendapatan = 0;
                            productSold = Map();
                            fetchData();
                          });
                        }),
                  ],
                ),
                SizedBox(width: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tahun",
                        style: TextStyle(color: Colors.grey.shade500)),
                    DropdownButton(
                        borderRadius: BorderRadius.circular(15),
                        value: tahun,
                        items: years
                            .map((e) => DropdownMenuItem(
                                value: e, child: Text(e.toString())))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            tahun = int.parse(value.toString());
                            isLoading = true;
                            totalPendapatan = 0;
                            productSold = Map();
                            fetchData();
                          });
                        }),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: defaultPadding,
            ),
            Text(
              "Total Pendapatan",
              style: TextStyle(color: Colors.grey.shade800),
            ),
            Text(
              "Rp " + totalPendapatan.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: defaultPadding),
            (isLoading)
                ? Center(
                    child: Padding(
                    padding: const EdgeInsets.all(defaultPadding * 2),
                    child: CircularProgressIndicator(),
                  ))
                : Column(
                    children: [
                      for (var entry in productSold.entries)
                        Container(
                          margin: EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // boxShadow: shadow,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                        image: NetworkImage(entry.value["img"]),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry.key,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text("Terjual " +
                                      entry.value["jumlah"].toString() +
                                      ' Kg')
                                ],
                              )
                            ],
                          ),
                        )
                    ],
                  ),
            (productSold.entries.length == 0 && (!isLoading))
                ? Text(
                    "Tidak ada penjualan",
                    style: TextStyle(fontSize: 16),
                  )
                : SizedBox(
                    height: 0,
                  )
          ],
        ),
      )),
    );
  }
}
