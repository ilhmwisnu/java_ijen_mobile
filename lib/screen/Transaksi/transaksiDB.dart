import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/produk.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/produkDB.dart';
import 'package:java_ijen_mobile/screen/Transaksi/transaksi.dart';

import '../../utils/cost.dart';

class TransaksiDB {
  Future<List<Transaksi>> getOnProgressTrans(
      String uid, String role, String page) async {
    final List<Transaksi> trans = [];
    late DatabaseReference ref;
    if (page == "sampel") {
      ref = FirebaseDatabase.instance.ref('permintaan_sampel');
    } else {
      ref = FirebaseDatabase.instance.ref('pemesanan_produk');
    }

    final root = await ref.get();
    for (final id in root.children) {
      final data = id.value as Map;
      String transId = id.key.toString();
      late Produk produk;
      String imgUrl = "";

      final _prod = ProdukDB();
      produk = await _prod.getDataById(data["idProduk"].toString());
      imgUrl = await _prod.getProductImg(data["idProduk"].toString());
      // print(data);
      if (uid == data["user"] || role == 'admin') {
        if (data["status"] == 'Dalam Proses' ||
            data["status"] == "Menunggu Konfirmasi") {
          // print("Masuk");
          trans.insert(
              trans.length,
              Transaksi(
                transId,
                data["user"],
                data["namaRekening"],
                data["nomorRekening"],
                produk,
                data["provinsi"],
                data["kota"],
                data["alamat"],
                data["layananEkspedisi"],
                data["biayaOngkir"].toString(),
                data["waktuPemesanan"],
                data["status"],
                imgUrl,
                (data["jumlah"] == null) ? "0" : data["jumlah"],
                (data["resi"] == null) ? "" : data["resi"],
              ));
        }
      }
    }
    trans.sort((a, b) {
      return DateTime.now()
          .difference(a.waktuPesan)
          .compareTo(DateTime.now().difference(b.waktuPesan));
    });
    return trans;
  }

  Future<List<Transaksi>> getOnFinishedTrans(
      String uid, String role, String page) async {
    final List<Transaksi> trans = [];
    late DatabaseReference ref, ref2;
    ref = FirebaseDatabase.instance.ref('permintaan_sampel');
    ref2 = FirebaseDatabase.instance.ref('pemesanan_produk');

    final root = await ref.get();
    final root2 = await ref2.get();

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
      if (uid == user || role == 'admin') {
        if (status == 'Dibatalkan' || status == "Selesai") {
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

    for (final id in await root2.children) {
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
      final firstChild2 = await ref2.child(transId).get();

      for (final col in firstChild2.children) {
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
      if (uid == user || role == 'admin') {
        if (status == 'Dibatalkan' || status == "Selesai") {
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
    trans.sort((a, b) {
      return DateTime.now()
          .difference(a.waktuPesan)
          .compareTo(DateTime.now().difference(b.waktuPesan));
    });
    return trans;
  }

  Future<List<Transaksi>> getSuccesTrans(bulan, tahun) async {
    List<Transaksi> finishedTrans = [];
    final ref = FirebaseDatabase.instance.ref('pemesanan_produk');
    final res = await ref.get();
    var data = res.value as Map;

    DateTime start = DateTime(tahun, bulan);
    DateTime end = DateTime(tahun, bulan + 1);

    for (var e in data.entries) {
      var transDate = DateTime.parse(e.value["waktuPemesanan"]);
      if (e.value["status"] == "Selesai" &&
          transDate.isAfter(start) &&
          transDate.isBefore(end)) {
        Produk produk = await ProdukDB().getDataById(e.value["idProduk"]);
        String imgUrl = await ProdukDB().getProductImg(e.value["idProduk"]);
        finishedTrans.add(Transaksi(
            e.key,
            e.value["user"],
            e.value["namaRekening"],
            e.value["nomorRekening"],
            produk,
            e.value["provinsi"],
            e.value["kota"],
            e.value["alamat"],
            e.value["layananEkspedisi"],
            e.value["biayaOngkir"].toString(),
            e.value["waktuPemesanan"],
            e.value["status"],
            imgUrl,
            e.value["jumlah"].toString(),
            (e.value['resi'] == null) ? "" : e.value["resi"]));
      }
    }
    // print(finishedTrans);

    return finishedTrans;
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
      'status': 'Menunggu Konfirmasi',
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

  Future<String> getBuktiImg(id, page, jumlah) async {
    final filename = "$id.jpg";
    FirebaseStorage storage = FirebaseStorage.instance;
    late Reference ref;
    if (page == "sampel") {
      ref = storage.ref("sampleTF/$filename");
    } else if (page == "pemesanan") {
      ref = storage.ref("pesanTF/$filename");
    } else {
      if (jumlah == 0) {
        ref = storage.ref("sampleTF/$filename");
      } else {
        ref = storage.ref("pesanTF/$filename");
      }
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
        refImg = storage.ref("pesanTF/$filename");
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
