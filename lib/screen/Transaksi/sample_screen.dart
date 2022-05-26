import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';
import 'package:java_ijen_mobile/screen/Transaksi/transaksi.dart';
import 'package:java_ijen_mobile/screen/Transaksi/transaksiDB.dart';

class SampleScreen extends StatefulWidget {
  static const routeName = "/sample_screen";

  const SampleScreen({Key? key}) : super(key: key);

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  bool _isLoading = false;
  String uid = "";
  late List<Transaksi> _listTransaksi;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    setState(() {
      _isLoading = true;
    });
    // TODO get current user id
    // print(uid + "1");
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user != null) {
    //     uid = user.uid;
    //   }
    // });
    // print(uid + "2");
    // TODO get user role
    // final ref = FirebaseDatabase.instance.ref('/user/$uid');
    // ref.onValue.listen((DatabaseEvent event) {
    //   final data = event.snapshot.value;
    //   print(data);
    // });
    _listTransaksi = await TransaksiDB()
        .getTrans("FytU5wkyMDWh8iFxDlLSTYfzjXp1", "admin"); //TODO " " itu role
    print(_listTransaksi);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGrey,
        title: Text("Transaksi Berlangsung"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pushNamed(context, AddPetaniScreen.routeName)
          //     .whenComplete(() => fetchData());
        },
        child: Icon(Icons.add),
        backgroundColor: green,
      ),
      body: (_isLoading)
          ? Center(child: const CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _listTransaksi.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(_listTransaksi[index].produk),
                    subtitle: Text(_listTransaksi[index].alamat +
                        _listTransaksi[index].kota),
                    //leading: Text(_listLahan[index]["id"].toString()),
                    trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // print(_listPetani[index]["nama"]);
                          // Navigator.pushNamed(context, EditPetani.routeName,
                          //     arguments: _listTransaksi[index].id)
                          //     .whenComplete(() => fetchData());
                        }),
                  ),
                );
              },
            ),
    );
  }
}
