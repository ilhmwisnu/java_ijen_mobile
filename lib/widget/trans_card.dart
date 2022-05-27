import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/screen/Transaksi/transaksi.dart';
import '../const.dart';
import 'package:intl/intl.dart';

class TransCard extends StatelessWidget {
  late Transaksi transaksi;
  Function()? onClickUbah;
  TransCard({Key? key, required this.transaksi, required this.onClickUbah})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    return Container(
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
                  color: Colors.amber.shade600,
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "Gratis",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 12),
          Text(
            "Total : Rp " + transaksi.ongkir.toString(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 4),
          Divider(),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Text(
                      "Anda hanya dapat mengubah pesanan kurang dari 2 jam setelah pemesanan "),
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey.shade500)),
                  onPressed: onClickUbah,
                  child: Text("Ubah"))
            ],
          )
        ],
      ),
    );
  }
}
