import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';

class KonfirmasiPesanan extends StatelessWidget {
  static const routeName = "konfirmasi";
  const KonfirmasiPesanan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(2 * defaultPadding),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Pesanan Terkonfirmasi",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 24),
          Image.asset("assets/1653275077854 1.png"),
          // SizedBox(height: defaultPadding),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              "Pesanan telah terkonfirmasi dan akan diteruskan ke Penjual. Silahkan melihat Transaksi Berlangsung untuk mengecek transaksi secara berkala.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: ElevatedButton(
          //           style: ButtonStyle(
          //               elevation: MaterialStateProperty.all(0),
          //               backgroundColor: MaterialStateProperty.all(green)),
          //           onPressed: () {},
          //           child: Text("Lihat data transaksi")),
          //     )
          //   ],
          // ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(darkChoco)),
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: Text("Kembali ke Menu Utama")),
              )
            ],
          ),
        ]),
      ),
    ));
  }
}
