import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/produkDB.dart';
import 'package:java_ijen_mobile/screen/Transaksi/transaksi.dart';
import 'package:java_ijen_mobile/screen/Transaksi/transaksiDB.dart';
import 'package:java_ijen_mobile/utils/auth.dart';
import 'package:intl/intl.dart';
import 'package:java_ijen_mobile/widget/trans_card.dart';

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
    _listTransaksi = await TransaksiDB().getOnProgressSample(userId, role);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                return TransCard(
                    transaksi: _listTransaksi[index], onClickUbah: () {});
              },
            ),
    );
  }
}
