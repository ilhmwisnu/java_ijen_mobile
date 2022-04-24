import 'dart:developer';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';
import 'package:java_ijen_mobile/screen/Lahan/lahanDB.dart';

import 'addLahan_screen.dart';
import 'lahan.dart';

class LahanScreen extends StatefulWidget {
  static const routeName = "/lahan";

  const LahanScreen({Key? key}) : super(key: key);

  @override
  State<LahanScreen> createState() => _LahanScreenState();
}

class _LahanScreenState extends State<LahanScreen> {
  bool _isLoading = false;
  late List<Lahan> _listLahan;
  late int _totalData;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    setState(() {
      _isLoading = true;
    });
    _listLahan = await LahanDB().getLahan();
    _totalData = _listLahan.length;
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
            ? Center(child: const CircularProgressIndicator())
            : ListView.builder(
          padding: const EdgeInsets.all(8),
                itemCount: _totalData,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                          "${_listLahan[index].id} - ${_listLahan[index].alamat}"),
                      subtitle:
                          Text("Owner : ${_listLahan[index].namapemilik}"),
                      //leading: Text(_listLahan[index]["id"].toString()),
                      trailing: Wrap(spacing: 12, children: [
                        IconButton(
                          icon: Icon(Icons.location_on),
                          onPressed: () {
                            gmapsLinks(
                                _listLahan[index].lat, _listLahan[index].long);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {},
                        ),
                      ]),
                    ),
                  );
                },
              ));
  }

  gmapsLinks(String lat, String long) async {
    Uri url = Uri.parse("https://maps.google.com/?q=$lat,$long");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
