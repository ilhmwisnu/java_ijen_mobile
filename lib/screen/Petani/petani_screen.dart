import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';
import 'package:java_ijen_mobile/screen/Petani/addPetani_screen.dart';
import 'package:java_ijen_mobile/screen/Petani/petaniDB.dart';

class PetaniScreen extends StatefulWidget {
  static const routeName = "/petani";

  const PetaniScreen({Key? key}) : super(key: key);

  @override
  State<PetaniScreen> createState() => _PetaniScreenState();
}

class _PetaniScreenState extends State<PetaniScreen> {
  bool _isLoading = false;
  late List _listPetani;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    setState(() {
      _isLoading = true;
    });
    _listPetani = await petaniDB().getAll();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGrey,
        title: Text("Data Petani"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddPetaniScreen.routeName);
        },
        child: Icon(Icons.add),
        backgroundColor: green,
      ),
      body: (_isLoading)
          ? const CircularProgressIndicator()
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _listPetani.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(
                        "${_listPetani[index]["id"].toString()} - ${_listPetani[index]["nama"].toString()}"),
                    subtitle: Text(_listPetani[index]["alamat"].toString()),
                    //leading: Text(_listLahan[index]["id"].toString()),
                    trailing:
                        Wrap(spacing: 12, children: const [Icon(Icons.edit)]),
                  ),
                );
              },
            ),
    );
  }
}
