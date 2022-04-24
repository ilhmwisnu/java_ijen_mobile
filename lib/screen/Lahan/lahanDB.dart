import 'package:firebase_database/firebase_database.dart';

class LahanDB {
  FirebaseDatabase db = FirebaseDatabase.instance;

  Future<List> getAll() async {
    final _listLahan = [];

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
    return _listLahan;
  }

  Future<List> getIDList() async {
    final _listID = [];
    DatabaseReference ref = db.ref('lahan');

    final dataLahan = await ref.get();
    for (final idLahan in dataLahan.children) {
      _listID.insert(_listID.length, idLahan.key.toString());
    }
    return _listID;
  }

  Future<void> addLahan(String alamat, String pemilik, String lat, String long) async {
    DatabaseReference ref = db.ref('lahan');
    final list = await getIDList();
    int last = list.length + 1;
    String inputID = "LH" + last.toString();
    await ref
        .child(inputID)
        .set({"alamat": alamat, "pemilik": pemilik, "lat": lat, "long": long});
  }
}
