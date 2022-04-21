import 'package:firebase_database/firebase_database.dart';

class lahanDB {
  final _listLahan = [];
  late DatabaseReference ref;
  late int lastID;

  Future<List> getAll() async {
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
          final pemilik =
              await refPT.child(col.value.toString()).child("nama").get();
          data["pemilik"] = pemilik.value;
        }
      }
      _listLahan.insert(_listLahan.length, data);
    }
    lastID = _listLahan.length;
    return _listLahan;
  }

  void addLahan(List value) {
    throw "add Lahan";
  }
}
