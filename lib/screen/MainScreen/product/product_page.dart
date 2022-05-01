import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/produk.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/produkDB.dart';
import '../../../utils/auth.dart';
import '../../../const.dart';

class ProductPage extends StatefulWidget {
  UserData userData;

  ProductPage({Key? key, required this.userData}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool _isLoading = false;
  late List<Produk> _listProduk;
  late int _totalData;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    setState(() {
      _isLoading = true;
    });
    _listProduk = await ProdukDB().getProduk();
    _totalData = _listProduk.length;
    print(_listProduk[0].img);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Kalo mau akses role bisa pake widget.userData.role disini

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      child: (widget.userData.role == "admin")
          ? AdminView(screenSize, context)
          : PembeliView(screenSize),
    ));
  }

  Widget PembeliView(Size screenSize) {
    return Container(
        child: (_isLoading)
            ? Center(child: const CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _totalData,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        print("card");
                      },
                      child: Card(
                        child: Column(children: [
                          Container(
                              height: 150.0,
                              child: Ink.image(
                                image: NetworkImage(_listProduk[index].img),
                                fit: BoxFit.cover,
                              )),
                          ListTile(
                            title: Text(_listProduk[index].nama),
                            subtitle: Text(
                                "Rp${_listProduk[index].harga}/kg - Stok ${_listProduk[index].jumlah} kg"),
                          )
                        ]),
                      ));
                },
              ));
  }

  Widget AdminView(Size screenSize, BuildContext context) {
    return Container(
        child: (_isLoading)
            ? Center(child: const CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _totalData,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        print("card");
                      },
                      child: Card(
                        child: Column(children: [
                          Container(
                              height: 150.0,
                              child: Ink.image(
                                image: NetworkImage(_listProduk[index].img),
                                fit: BoxFit.cover,
                              )),
                          ListTile(
                            title: Text(_listProduk[index].nama),
                            subtitle: Text(
                                "Rp${_listProduk[index].harga}/kg - Stok ${_listProduk[index].jumlah} kg"),
                            trailing: Wrap(spacing: 12, children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  print("edit");
                                },
                              ),
                            ]),
                          )
                        ]),
                      ));
                },
              ));
  }
}
