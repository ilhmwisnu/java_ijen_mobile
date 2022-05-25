import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../utils/cost.dart';

class Transaksi {
  Transaksi._();

  static final _db = FirebaseDatabase.instance;
  static final _storage = FirebaseStorage.instance;

  static Future<void> AddSampleRequest({
    required String namaRekening,
    required String nomorRekening,
    required String pathBuktiTf,
    required String idProduk,
    required String provinsi,
    required String kota,
    required String alamat,
    required Cost ekspedisi,
  }) async {
    DatabaseReference ref = _db.ref('sampleRequest');
    DatabaseReference newChild = ref.push();
    await newChild.set({
      'namaRekening': namaRekening,
      'nomorRekening': nomorRekening,
      'idProduk': idProduk,
      'provinsi': provinsi,
      'kota': kota,
      'alamat': alamat,
      'layananEkspedisi': ekspedisi.namaLayanan,
      'biayaOngkir': ekspedisi.harga,
      'waktuPemesanan': DateTime.now().toString(),
      'isDone': false.toString()
    });

    final id = newChild.key.toString();

    final fileName = "$id.jpg";
    print("$pathBuktiTf");
    final storageRef = _storage.ref("sampleTF/$fileName");
    await storageRef.putFile(File(pathBuktiTf)).then((p0) => print("Done"));
  }
}
