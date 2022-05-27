import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/produk.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/produkDB.dart';
import 'package:java_ijen_mobile/screen/Transaksi/transaksi.dart';

import '../../utils/cost.dart';

class TransaksiDB {
  Future<List<Transaksi>> getOnProgressSample(
      String uid, String role, String page) async {
    final List<Transaksi> trans = [];
    late DatabaseReference ref;
    if (page == "sampel") {
      ref = FirebaseDatabase.instance.ref('permintaan_sampel');
    } else if (page == "pemesanan") {
      ref = FirebaseDatabase.instance.ref('pemesanan_produk');
    }

    final root = await ref.get();
    for (final id in await root.children) {
      String user = "";
      String namaRek = "";
      String noRek = "";
      late Produk produk;
      String prov = "";
      String kota = "";
      String alamat = "";
      String ekspedisi = "";
      String ongkir = "";
      String waktuPesan = "";
      String status = "";
      String imgUrl = "";
      String jumlah = "0";
      final firstChild = await ref.child(id.key.toString()).get();

      for (final col in firstChild.children) {
        if (col.key == "namaRekening") {
          namaRek = col.value.toString();
        }
        if (col.key == "nomorRekening") {
          noRek = col.value.toString();
        }
        if (col.key == "idProduk") {
          final _prod = ProdukDB();
          produk = await _prod.getDataById(col.value.toString());
          imgUrl = await _prod.getProductImg(col.value.toString());
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
        if (col.key == "biayaOngkir") {
          ongkir = col.value.toString();
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
        if (col.key == "jumlah") {
          jumlah = col.value.toString();
        }
        if (col.key == "user") {
          user = col.value.toString();
        }
      }
      if (uid == user || role == 'admin') {
        if (status != "Selesai") {
          trans.insert(
              trans.length,
              Transaksi(user, namaRek, noRek, produk, prov, kota, alamat,
                  ekspedisi, ongkir, waktuPesan, status, imgUrl, jumlah));
        }
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
      required Cost ekspedisi}) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
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
      'user': userId
    });

    final id = newChild.key.toString();

    final fileName = "$id.jpg";
    print("$pathBuktiTf");
    final storageRef = _storage.ref("sampleTF/$fileName");
    await storageRef.putFile(File(pathBuktiTf)).then((p0) => print("Done"));
  }

  Future<void> AddProdukOrder(
      {required String namaRekening,
      required String nomorRekening,
      required String pathBuktiTf,
      required String idProduk,
      required String provinsi,
      required String kota,
      required String alamat,
      required Cost ekspedisi,
      required int jumlah}) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('pemesanan_produk');
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
    final storageRef = FirebaseStorage.instance.ref("pesanTF/$fileName");
    await storageRef.putFile(File(pathBuktiTf)).then((p0) => print("Done"));
  }
}
