import 'package:firebase_database/firebase_database.dart';
import 'package:java_ijen_mobile/screen/Petani/petani.dart';

class PetaniDB {
  FirebaseDatabase db = FirebaseDatabase.instance;

  Future<List<Petani>> getPetani() async {
    final List<Petani> petani = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref('petani');

    final root = await ref.get();
    for (final id in await root.children) {
      String alamat = "";
      String nama = "";
      String lid = id.key.toString();

      final firstChild = await ref.child(lid).get();
      for (final col in firstChild.children) {
        if (col.key == "alamat") {
          alamat = col.value.toString();
        }
        if (col.key == "nama") {
          nama = col.value.toString();
        }
      }
      petani.insert(petani.length, Petani(lid, alamat, nama));
    }
    return petani;
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

  Future<Petani> getPetaniDataById(String id) async {
    DatabaseReference ref = db.ref('petani/$id');
    Map<String, String> data = {};
    String alamat = "";
    String nama = "";

    final firstChild = await ref.get();
    for (final col in firstChild.children) {
      if (col.key == "alamat") {
        alamat = col.value.toString();
      }
      if (col.key == "nama") {
        nama = col.value.toString();
      }
    }
    return Petani(id, alamat, nama);
  }

  Future<void> updatePetani(String nama, String alamat, String id) async {
    DatabaseReference ref = db.ref('petani/$id');
    await ref.update({"nama": nama, "alamat": alamat});
  }
}
