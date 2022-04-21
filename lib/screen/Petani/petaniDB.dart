import 'package:firebase_database/firebase_database.dart';

class petaniDB {
  final _listPetani = [];
  late int lastID;
  FirebaseDatabase db = FirebaseDatabase.instance;

  Future<List> getAll() async {
    DatabaseReference ref = db.ref('petani');

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
        if (col.key == "nama") {
          data["nama"] = col.value;
        }
      }
      _listPetani.insert(_listPetani.length, data);
    }
    lastID = _listPetani.length;
    return _listPetani;
  }

  void addPetani(List value) {
    throw "add Lahan";
  }
}
