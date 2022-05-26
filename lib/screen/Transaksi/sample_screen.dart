import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/produkDB.dart';
import 'package:java_ijen_mobile/screen/Transaksi/transaksi.dart';
import 'package:java_ijen_mobile/screen/Transaksi/transaksiDB.dart';
import 'package:java_ijen_mobile/utils/auth.dart';
import 'package:intl/intl.dart';

class SampleScreen extends StatefulWidget {
  static const routeName = "/sample_screen";

  const SampleScreen({Key? key}) : super(key: key);

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  bool isInit = false;
  bool _isLoading = false;
  String uid = "";
  List<Transaksi> _listTransaksi = [];

  @override
  void didChangeDependencies() {
    if (!isInit) {
      final user = ModalRoute.of(context)!.settings.arguments as UserData;
      final userId = FirebaseAuth.instance.currentUser!.uid;
      fetchData(userId, user.role);
    }
    super.didChangeDependencies();
  }

  void fetchData(userId, role) async {
    setState(() {
      _isLoading = true;
    });
    _listTransaksi =
        await TransaksiDB().getTrans(userId, role); //TODO " " itu role
    // print(_listTransaksi);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: darkGrey,
        title: Text("Permintaan Sample"),
      ),
      body: (_isLoading)
          ? Center(child: const CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(defaultPadding),
              itemCount: _listTransaksi.length,
              itemBuilder: (BuildContext context, int index) {
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
                              Text(formatter
                                  .format(_listTransaksi[index].waktuPesan))
                            ],
                          ),
                          Text(
                            "Menunggu konfirmasi",
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
                                    image: NetworkImage(
                                        _listTransaksi[index].imgUrl))),
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                _listTransaksi[index].produk.nama,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w700),
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
                        "Total : Rp " + _listTransaksi[index].ongkir.toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
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
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.grey.shade500)),
                              onPressed: () {},
                              child: Text("Ubah"))
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
