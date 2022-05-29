import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/screen/Transaksi/transaksi.dart';
import '../const.dart';
import 'package:intl/intl.dart';

class TransCard extends StatelessWidget {
  late Transaksi transaksi;
  Function()? onClickDetail;
  Function()? onClickSelesai;
  String role;

  TransCard(
      {Key? key,
      required this.transaksi,
      required this.onClickDetail,
      required this.onClickSelesai,
      required this.role})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('dd-MM-yyyy  HH:mm');
    NumberFormat nominal = NumberFormat("#,##0", "en_US");
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: defaultPadding),
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
            boxShadow: shadow,
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      color: darkGrey,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(formatter.format(transaksi.waktuPesan))
                  ],
                ),
                Text(
                  transaksi.status,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: (transaksi.status == "Menunggu Konfirmasi" ||
                            transaksi.status == "Dalam Proses")
                        ? Colors.amber.shade600
                        : transaksi.status == "Dibatalkan"
                            ? Colors.grey.shade500
                            : green,
                  ),
                )
              ],
            ),
            SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: 50,
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
                    Text(
                      transaksi.produk.nama,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      transaksi.jumlah == 0
                          ? "Gratis"
                          : "Rp. " +
                              nominal
                                  .format(int.parse(transaksi.produk.harga)) +
                              "/kg",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total : Rp " +
                      nominal.format(transaksi.ongkir +
                          (int.parse(transaksi.produk.harga) *
                              transaksi.jumlah)),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                role == "pembeli"
                    ? Pembeli()
                    : SizedBox(
                        height: 0,
                      )
              ],
            ),
          ],
        ),
      ),
      onTap: onClickDetail,
    );
  }

  Widget Pembeli() {
    return transaksi.status == "Dalam Proses"
        ? ElevatedButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 8, vertical: 0)),
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(green)),
            onPressed: onClickSelesai,
            child: Text(
              "Pesanan Diterima",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ))
        : SizedBox(height: 0);
  }

  Widget Admin() {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: Text("Ubah status transaksi"),
          ),
        ),
        ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor:
                    MaterialStateProperty.all(Colors.grey.shade500)),
            onPressed: onClickDetail,
            child: Text("Detail"))
      ],
    );
  }
}
