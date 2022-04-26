import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/screen/Lahan/lahan.dart';

class LahanDB {
  FirebaseDatabase db = FirebaseDatabase.instance;

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

  Future<List<Lahan>> getLahan() async {
    final List<Lahan> lahan = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref('lahan');

    final root = await ref.get();
    for (final id in await root.children) {
      List pos = [];
      String alamat = "";
      String idpemilik = "";
      String namapemilik = "";
      String lid = id.key.toString();

      final firstChild = await ref.child(lid).get();
      for (final col in firstChild.children) {
        if (col.key == "alamat") {
          alamat = col.value.toString();
        }
        if (col.key == "lat") {
          pos.insert(0, col.value);
        }
        if (col.key == "long") {
          pos.insert(1, col.value);
        }
        if (col.key == "pemilik") {
          idpemilik = col.value.toString();
          DatabaseReference refPT = db.ref('petani');
          final petaniChild =
              await refPT.child(col.value.toString()).child("nama").get();
          namapemilik = petaniChild.value.toString();
        }
      }
      lahan.insert(
          lahan.length,
          Lahan(lid, alamat, pos[0].toString(), pos[1].toString(), idpemilik,
              namapemilik));
    }
    return lahan;
  }

  Future<Lahan> getDataById(String id) async {
    DatabaseReference ref = db.ref('lahan/$id');
    List pos = [];
    String alamat = "";
    String idpemilik = "";
    String namapemilik = "";

    final detailLahan = await ref.get();
    for (var col in detailLahan.children) {
      if (col.key == "alamat") {
        alamat = col.value.toString();
      }
      if (col.key == "lat") {
        pos.insert(0, col.value);
      }
      if (col.key == "long") {
        pos.insert(1, col.value);
      }
      if (col.key == "pemilik") {
        idpemilik = col.value.toString();
        DatabaseReference refPT = db.ref('petani');
        final petaniChild =
            await refPT.child(col.value.toString()).child("nama").get();
        namapemilik = petaniChild.value.toString();
      }
    }
    Lahan lahanItem = Lahan(id, alamat, pos[0], pos[1], idpemilik, namapemilik);
    return lahanItem;
  }

  Future<Lahan> getLahanDataById(String id) async {
    DatabaseReference ref = db.ref('lahan/$id');
    final detailPetani = await ref.get();
    List pos = [];
    String alamat = "";
    String idpemilik = "";
    String namapemilik = "";

    for (var col in detailPetani.children) {
      if (col.key == "alamat") {
        alamat = col.value.toString();
      }
      if (col.key == "lat") {
        pos.insert(0, col.value);
      }
      if (col.key == "long") {
        pos.insert(1, col.value);
      }
      if (col.key == "pemilik") {
        idpemilik = col.value.toString();
        DatabaseReference refPT = db.ref('petani');
        final petaniChild =
            await refPT.child(col.value.toString()).child("nama").get();
        namapemilik = petaniChild.value.toString();
      }
    }
    Lahan lahanItem = Lahan(id, alamat, pos[0], pos[1], idpemilik, namapemilik);
    return lahanItem;
  }

  Future<void> updateLahan(
      String alamat, String pemilik, String id, String lat, String long) async {
    DatabaseReference ref = db.ref('lahan/$id');
    await ref.update(
        {"pemilik": pemilik, "alamat": alamat, "lat": lat, "long": long});
  }
}
