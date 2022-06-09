import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';

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
            
          ],
        ),
      )),
    );
  }
}
