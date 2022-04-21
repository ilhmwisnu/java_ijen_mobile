import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';
import 'package:java_ijen_mobile/screen/Lahan/lahanDB.dart';

import 'addLahan_screen.dart';

class LahanScreen extends StatefulWidget {
  static const routeName = "/lahan";

  const LahanScreen({Key? key}) : super(key: key);

  @override
  State<LahanScreen> createState() => _LahanScreenState();
}

class _LahanScreenState extends State<LahanScreen> {
  bool _isLoading = false;
  late List _listLahan;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    setState(() {
      _isLoading = true;
    });
    _listLahan = await lahanDB().getAll();
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
          onPressed: () {
            Navigator.pushNamed(context, AddLahanScreen.routeName);
          },
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
