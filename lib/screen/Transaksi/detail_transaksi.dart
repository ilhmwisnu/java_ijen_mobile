import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';
import 'package:java_ijen_mobile/screen/Transaksi/transaksi.dart';
import 'package:java_ijen_mobile/utils/auth.dart';

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
  TextEditingController _resiController =
      TextEditingController(); //TODO : ambil data resi
  String filePath = '';
  late UserData userData;
  late String status;

  @override
  void didChangeDependencies() {
    if (!isInit) {
      final arg =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      setState(() {
        transaksi = arg['transaksi'];
        userData = arg['userData'];
        isInit = true;
        _isLoading = false;
        status = transaksi.status;
      });
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
                                        : "Rp " + transaksi.produk.harga,
                                    style: TextStyle(fontSize: 16)),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 8),
                        Divider(),
                        SizedBox(height: 8),
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
                        Row(
                          children: [
                            Flexible(
                                child: Text("Alamat"),
                                flex: 2,
                                fit: FlexFit.tight),
                            Flexible(
                                child: Text(transaksi.alamat +
                                    ", " +
                                    transaksi.prov +
                                    ", " +
                                    transaksi.kota),
                                flex: 3),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        (userData.role == "admin") ? TextField(
                          minLines: 1,
                          maxLines: 3,
                          controller: _resiController,
                          decoration: InputDecoration(
                              label: Text("Resi Pengiriman"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ) : Row(
                          children: [
                            Flexible(
                                child: Text("Resi"),
                                flex: 2,
                                fit: FlexFit.tight),
                            Flexible(
                                child: Text(""), //TODO : transaksi.resi
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
                                child:
                                    Text("Rp " + transaksi.ongkir.toString()),
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
                                child: Text(transaksi.jumlah.toString()),
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
                                    (transaksi.ongkir +
                                            transaksi.jumlah *
                                                int.parse(
                                                    transaksi.produk.harga))
                                        .toString()),
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
                              //TODO : Navigate ke foto bukti transfer
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  height:
                                      MediaQuery.of(context).size.width * 1 / 5,
                                  decoration: BoxDecoration(
                                    color: (filePath == null || filePath == "")
                                        ? Colors.grey
                                        : null,
                                    borderRadius: BorderRadius.circular(12),
                                    image: (filePath == null || filePath == "")
                                        ? null
                                        : DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage("")),
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
                                        (filePath == "")
                                            ? "View photo"
                                            : "Change photo",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  )),
                                )
                              ],
                            )),
                        SizedBox(height: 12),
                        DropdownButton(
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
                            }),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(green),
                                    elevation: MaterialStateProperty.all(0)),
                                onPressed: () {},
                                child: Text("Simpan")),
                          ],
                        )
                      ]),
                ),
              ),
            ),
    );
  }
}
