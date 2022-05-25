import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';
import 'package:java_ijen_mobile/screen/Lahan/lahanDB.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/produk.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/produkDB.dart';
import 'package:java_ijen_mobile/screen/Petani/petani.dart';
import 'package:java_ijen_mobile/screen/Petani/petaniDB.dart';
import '../../Lahan/lahan.dart';
import '../../Transaksi/reqSample_screen.dart';

class DetailProduct extends StatefulWidget {
  static const routeName = "/detailProduct";
  const DetailProduct({Key? key}) : super(key: key);

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  bool _isInit = false;
  late Produk _produkData;
  late Lahan _lahanData;
  late Petani _petaniData;
  bool _isLoading = true;
  String _imgUrl = "";

  @override
  void didChangeDependencies() async {
    if (!_isInit) {
      final id = ModalRoute.of(context)!.settings.arguments;
      final db = ProdukDB();
      _produkData = await db.getDataById(id.toString());
      _lahanData = await LahanDB().getDataById(_produkData.idlahan);
      _petaniData = await PetaniDB().getPetaniDataById(_produkData.idpetani);
      _imgUrl = await db.getProductImg(_produkData.id);
      setState(() {
        _isLoading = false;
        _isInit = true;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments.toString();
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: (_isLoading)
          ? null
          : Container(
              padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 4),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey)),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AddSampleRequestScreen.routeName,
                                arguments: {
                                  "id" : id,
                                  "imgUrl" : _imgUrl,
                                  "namaProduk" : _produkData.nama,
                                });
                          },
                          child: Text("Minta Sampel"))),
                  SizedBox(width: 8),
                  Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor:
                                  MaterialStateProperty.all(green)),
                          onPressed: () {},
                          child: Text("Pesan"))),
                ],
              )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text("Detail Produk"),
        backgroundColor: darkGrey,
      ),
      body: (_isLoading)
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Container(
                  width: screenSize.width,
                  height: screenSize.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(_imgUrl), fit: BoxFit.cover)),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _produkData.nama,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Rp " + _produkData.harga + "/kg",
                        style: TextStyle(fontSize: 20, color: darkChoco),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Stok : " + _produkData.jumlah,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Lokasi lahan",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text("Rembangan"),
                      SizedBox(height: 16),
                      Text(
                        "Pemilik lahan",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text("Bapak Tejo")
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
