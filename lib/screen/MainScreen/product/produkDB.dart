import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/produk.dart';

class ProdukDB {
  FirebaseDatabase db = FirebaseDatabase.instance;

  Future<String> addProduk(String nama, String jumlah, String petani,
      String lahan, String proses, String harga) async {
    DatabaseReference ref = db.ref('produk');
    DatabaseReference newChild = await ref.push();
    await newChild.set({
      "nama": nama,
      "jumlah": jumlah,
      "petani": petani,
      "lahan": lahan,
      "proses": proses,
      "harga": harga
    });
    return newChild.key.toString();
  }

  Future<List<Produk>> getProduk() async {
    final List<Produk> produk = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref('produk');

    final root = await ref.get();
    for (final id in await root.children) {
      String pid = id.key.toString();
      final res = await ref.child(pid).get();
      final data = res.value as Map;

      produk.insert(
          produk.length,
          Produk(pid, data["nama"], data["jumlah"].toString(), data["petani"],
              data["lahan"], data["proses"], data["harga"].toString(), ""));
    }
    return produk;
  }

  Future<Produk> getDataById(String id) async {
    DatabaseReference ref = db.ref('produk/$id');
    String nama = "";
    String harga = "";
    String jumlah = "";
    String petani = "";
    String lahan = "";
    String proses = "";
    String img = "";

    // final firstChild = await ref.get();
    final res = await ref.get();
    final data = res.value as Map;
    // for (final col in firstChild.children) {
    //   if (col.key == "harga") {
    //     harga = col.value.toString();
    //   }
    //   if (col.key == "jumlah") {
    //     jumlah = col.value.toString();
    //   }
    //   if (col.key == "lahan") {
    //     lahan = col.value.toString();
    //   }
    //   if (col.key == "nama") {
    //     nama = col.value.toString();
    //   }
    //   if (col.key == "petani") {
    //     petani = col.value.toString();
    //   }
    //   if (col.key == "proses") {
    //     proses = col.value.toString();
    //   }
    //   if (col.key == "img") {
    //     img = col.value.toString();
    //   }
    // }
    // Produk produkItem =
    //     Produk(id, nama, jumlah, petani, lahan, proses, harga, img);
    Produk produkItem = Produk(
        id,
        data["nama"],
        data["jumlah"].toString(),
        data["petani"],
        data["lahan"],
        data["proses"],
        data["harga"].toString(),
        "");
    return produkItem;
  }

  Future<void> updateProduk(String id, String nama, String jumlah,
      String petani, String lahan, String proses, String harga) async {
    DatabaseReference ref = db.ref('produk/$id');
    await ref.update({
      "nama": nama,
      "jumlah": jumlah,
      "petani": petani,
      "lahan": lahan,
      "proses": proses,
      "harga": harga
    });
  }

  Future<void> addProductImg(id, path) async {
    FirebaseStorage _storage = FirebaseStorage.instance;
    final fileName = "$id.jpg";
    print("$path");
    final ref = _storage.ref("produk/$fileName");
    await ref.putFile(File(path)).then((p0) => print("Done"));
  }

  Future<String> getProductImg(id) async {
    FirebaseStorage _storage = FirebaseStorage.instance;
    final fileName = "$id.jpg";
    final ref = _storage.ref("produk/$fileName");
    final res = await ref.getDownloadURL();
    return res;
  }
}
