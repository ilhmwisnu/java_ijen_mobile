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

    //TODO : nyambil url bukti transfer taruh di class Transaksi
    final root = await ref.get();
    for (final id in await root.children) {
      String transId = id.key.toString();
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
      String resi = "";
      final firstChild = await ref.child(transId).get();

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
        if (col.key == "resi") {
          resi = col.value.toString();
        }
      }
      if (uid == user || role == 'admin' && page == 'sampel') {
        if (status != "Selesai" || status != "Dibatalkan") {
          trans.insert(
              trans.length,
              Transaksi(
                  transId,
                  user,
                  namaRek,
                  noRek,
                  produk,
                  prov,
                  kota,
                  alamat,
                  ekspedisi,
                  ongkir,
                  waktuPesan,
                  status,
                  imgUrl,
                  jumlah,
                  resi));
        }
      }
    }
    return trans;
  }

  Future<Transaksi> getTransById(String transId, String page) async {
    late DatabaseReference ref;
    if (page == "sampel") {
      ref = FirebaseDatabase.instance.ref('permintaan_sampel/$transId');
    } else if (page == "pemesanan") {
      ref = FirebaseDatabase.instance.ref('pemesanan_produk/$transId');
    }

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
    String resi = "";

    final child = await ref.get();
    for (final col in child.children) {
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
      if (col.key == "resi") {
        resi = col.value.toString();
      }
    }
    Transaksi transItem = Transaksi(
        transId,
        user,
        namaRek,
        noRek,
        produk,
        prov,
        kota,
        alamat,
        ekspedisi,
        ongkir,
        waktuPesan,
        status,
        imgUrl,
        jumlah,
        resi);
    return transItem;
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
      'status': 'Menunggu Konfirmasi',
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

    DatabaseReference ref2 =
        FirebaseDatabase.instance.ref('produk/-N2jv6-7tNGg6Rbs7R9Q');
    final dbJumlah = await ref2.child('/jumlah').get();
    ref2.update({'jumlah': int.parse(dbJumlah.value.toString()) - jumlah});

    final orderId = newChild.key.toString();

    final fileName = "$orderId.jpg";
    print("$pathBuktiTf");
    final storageRef = FirebaseStorage.instance.ref("pesanTF/$fileName");
    await storageRef.putFile(File(pathBuktiTf)).then((p0) => print("Done"));
  }

  Future<String> getBuktiImg(id, page) async {
    final filename = "$id.jpg";
    FirebaseStorage storage = FirebaseStorage.instance;
    late Reference ref;
    if (page == "sampel") {
      ref = storage.ref("sampleTF/$filename");
    } else if (page == "pemesanan") {
      ref = storage.ref("buktiTF/$filename");
    }

    final res = await ref.getDownloadURL();
    return res;
  }

  Future<void> updateTrans(String transId, String page, String role,
      String pathBuktiTF, String status, String alamat, String resi) async {
    late DatabaseReference ref;
    if (page == "sampel") {
      ref = FirebaseDatabase.instance.ref('permintaan_sampel/$transId');
    } else if (page == "pemesanan") {
      ref = FirebaseDatabase.instance.ref('pemesanan_produk/$transId');
    }

    if (pathBuktiTF != "-") {
      final filename = "$transId.jpg";
      FirebaseStorage storage = FirebaseStorage.instance;
      late Reference refImg;
      if (page == "sampel") {
        refImg = storage.ref("sampleTF/$filename");
      } else if (page == "pemesanan") {
        refImg = storage.ref("buktiTF/$filename");
      }

      await refImg.putFile(File(pathBuktiTF)).then((p0) => print("Done"));
    }
    if (status != "-") {
      ref.update({"status": status});
    }
    if (alamat != "-") {
      ref.update({"alamat": alamat});
    }
    if (resi != "-") {
      ref.update({"resi": resi});
    }
  }
}
