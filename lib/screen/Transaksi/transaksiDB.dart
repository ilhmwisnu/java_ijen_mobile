import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
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

  static Future<void> AddProdukOrder(
      {required String namaRekening,
      required String nomorRekening,
      required String pathBuktiTf,
      required String idProduk,
      required String provinsi,
      required String kota,
      required String alamat,
      required Cost ekspedisi,
      required int jumlah}) async {
    DatabaseReference ref = _db.ref('pemesanan_produk');
    DatabaseReference newChild = ref.push();
    final userId = FirebaseAuth.instance.currentUser!.uid;
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
      'jumlah': jumlah.toString(),
      'status': 'Menunggu konfirmasi',
      "user": userId
    });

    final orderId = newChild.key.toString();

    final fileName = "$orderId.jpg";
    print("$pathBuktiTf");
    final storageRef = _storage.ref("pesanTF/$fileName");
    await storageRef.putFile(File(pathBuktiTf)).then((p0) => print("Done"));
  }
}
