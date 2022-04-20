import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';


class LahanScreen extends StatefulWidget {
  static const routeName = "/lahan";

  const LahanScreen({Key? key}) : super(key: key);

  @override
  State<LahanScreen> createState() => _LahanScreenState();
}

class _LahanScreenState extends State<LahanScreen> {
  late DatabaseReference ref;
  final _listLahan = [];
  bool _isLoading = false;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });

    FirebaseDatabase db = FirebaseDatabase.instance;
    DatabaseReference ref = db.ref('lahan');

    final dataLahan = await ref.get();
    for (final idLahan in dataLahan.children) {
      final currID = idLahan.key.toString();
      final detailLahan = await ref.child(currID).get();
      var data = {};
      data["id"] = currID;
      for (final col in detailLahan.children) {
        if (col.key == "alamat") {
          data["alamat"] = col.value;
        }
        if (col.key == "lat") {
          data["lat"] = col.value;
        }
        if (col.key == "long") {
          data["long"] = col.value;
        }
        if (col.key == "pemilik") {
          DatabaseReference refPT = db.ref('petani');
          final pemilik = await refPT.child(col.value.toString()).child("nama").get();
          data["pemilik"] = pemilik.value;
        }

      }
      _listLahan.insert(_listLahan.length, data);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: darkGrey,
          title: const Text("Data Lahan"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
          backgroundColor: green,
        ),
        body: (_isLoading)
            ? const CircularProgressIndicator()
            : ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _listLahan.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text("${_listLahan[index]["id"].toString()} - ${_listLahan[index]["alamat"].toString()}"),
                      subtitle: Text(
                          "Owner : ${_listLahan[index]["pemilik"].toString()}"),
                      //leading: Text(_listLahan[index]["id"].toString()),
                      trailing: Wrap(spacing: 12, children: const [
                        Icon(Icons.location_on),
                        Icon(Icons.edit)
                      ]),
                    ),
                  );
                },
              )
    );
  }
}
