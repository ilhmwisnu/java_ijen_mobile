import 'package:java_ijen_mobile/screen/MainScreen/product/produk.dart';

class Transaksi {
  String transId,
      user,
      namaRek,
      noRek,
      prov,
      kota,
      alamat,
      ekspedisi,
      status,
      imgUrl;
  late int ongkir, jumlah;
  late DateTime waktuPesan;
  Produk produk;

  Transaksi(
      this.transId,
      this.user,
      this.namaRek,
      this.noRek,
      this.produk,
      this.prov,
      this.kota,
      this.alamat,
      this.ekspedisi,
      String ongkir,
      String waktuPesan,
      this.status,
      this.imgUrl,
      String jumlah) {
    this.ongkir = int.parse(ongkir);
    this.jumlah = int.parse(jumlah);
    this.waktuPesan = DateTime.parse(waktuPesan);
  }
}
