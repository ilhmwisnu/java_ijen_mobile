import 'package:firebase_database/firebase_database.dart';

class PetaniDB {
  final _listPetani = [];
  FirebaseDatabase db = FirebaseDatabase.instance;

  Future<List> getAll() async {
    DatabaseReference ref = db.ref('petani');

    final dataLahan = await ref.get();
    for (final lahan in dataLahan.children) {
      final currID = lahan.key.toString();
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
    return _listPetani;
  }

  Future<List> getIDList() async {
    final _listID = [];
    DatabaseReference ref = db.ref('petani');

    final dataLahan = await ref.get();
    for (final idLahan in dataLahan.children) {
      _listID.insert(_listID.length, idLahan.key.toString());
    }
    return _listID;
  }

  Future<void> addPetani(String nama, String alamat) async {
    DatabaseReference ref = db.ref("petani");
    final list = await getIDList();

    int last = list.length + 1;
    String inputID = "PT" + last.toString();
    await ref.child(inputID).set({"nama": nama, "alamat": alamat});
  }
}
