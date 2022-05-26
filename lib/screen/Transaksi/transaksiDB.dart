import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:java_ijen_mobile/screen/Transaksi/transaksi.dart';

import '../../utils/cost.dart';

class TransaksiDB {
  Future<List<Transaksi>> getTrans(String uid, String role) async {
    final List<Transaksi> trans = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref('permintaan_sampel');

    final root = await ref.get();
    for (final id in await root.children) {
      String user = "";
      String namaRek = "";
      String noRek = "";
      String produk = "";
      String prov = "";
      String kota = "";
      String alamat = "";
      String ekspedisi = "";
      String ongkir = "";
      String waktuPesan = "";
      String status = "";
      final firstChild = await ref.child(id.key.toString()).get();

      for (final col in firstChild.children) {
        if (col.key == "namaRekening") {
          namaRek = col.value.toString();
        }
        if (col.key == "nomorRekening") {
          noRek = col.value.toString();
        }
        if (col.key == "idProduk") {
          DatabaseReference ref2 = FirebaseDatabase.instance
              .ref('produk')
              .child(col.value.toString());
          final children = await ref2.get();
          for (final child in await children.children) {
            if (child.key == "nama") {
              produk = child.value.toString();
            }
          }
        }
        if (col.key == "provinsi") {
          prov = col.value.toString();
        }
        if (col.key == "kota") {
          kota = col.value.toString();
        }
        if (col.key == "alamat") {
          alamat = col.value.toString();
        }
        if (col.key == "layananEkspedisi") {
          ekspedisi = col.value.toString();
        }
        if (col.key == "waktuPemesanan") {
          waktuPesan = col.value.toString();
        }
        if (col.key == "status") {
          status = col.value.toString();
        }
        if (col.key == "user") {
          user = col.value.toString();
        }
      }
      if (uid == user || role == 'admin') {
        trans.insert(
            trans.length,
            Transaksi(user, namaRek, noRek, produk, prov, kota, alamat,
                ekspedisi, ongkir, waktuPesan, status));
      }
    }
    return trans;
  }

  Future<void> AddSampleRequest(
      {required String namaRekening,
      required String nomorRekening,
      required String pathBuktiTf,
      required String idProduk,
      required String provinsi,
      required String kota,
      required String alamat,
      required Cost ekspedisi,
      required String uid}) async {
    final _db = FirebaseDatabase.instance;
    final _storage = FirebaseStorage.instance;
    DatabaseReference ref = _db.ref('permintaan_sampel');
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
      'status': 'Menunggu konfirmasi',
      'user': uid
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
