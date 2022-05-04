import 'dart:io';

import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/produk.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/produkDB.dart';
import '../../../utils/auth.dart';
import '../../../const.dart';
import 'addProduk_screen.dart';

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
  List<String> _prodImg = [];

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
    for (var i = 0; i < _totalData; i++) {
      final imgUrl = await ProdukDB().getProductImg(_listProduk[i].id);
      _prodImg.add(imgUrl);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text("PRODUK"),
          backgroundColor: darkGrey,
        ),
        floatingActionButton: (widget.userData.role == "admin")
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddProdukScreen.routeName)
                      .whenComplete(() => fetchData());
                },
                child: Icon(Icons.add),
                backgroundColor: green,
              )
            : null,
        body: SafeArea(
          child: AdminView(screenSize, context),
        ));
  }

  // Widget PembeliView(Size screenSize) {
  //   return Container(
  //       child: (_isLoading)
  //           ? Center(child: const CircularProgressIndicator())
  //           : ListView.builder(
  //               padding: const EdgeInsets.all(8),
  //               itemCount: _totalData,
  //               itemBuilder: (BuildContext context, int index) {
  //                 return GestureDetector(
  //                     onTap: () {
  //                       print("card");
  //                     },
  //                     child: Card(
  //                       child: Column(children: [
  //                         Container(
  //                             height: 150.0,
  //                             child: Ink.image(
  //                               image: NetworkImage(_prodImg[index]),
  //                               fit: BoxFit.cover,
  //                             )),
  //                         ListTile(
  //                           title: Text(_listProduk[index].nama),
  //                           subtitle: Text(
  //                               "Rp${_listProduk[index].harga}/kg - Stok ${_listProduk[index].jumlah} kg"),
  //                         )
  //                       ]),
  //                     ));
  //               },
  //             ));
  // }

  Widget AdminView(Size screenSize, BuildContext context) {
    return Container(
      child: (_isLoading)
          ? Center(child: const CircularProgressIndicator())
          : GridView.builder(
              itemCount: _totalData,
              padding: EdgeInsets.all(defaultPadding),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 3.9,
                crossAxisSpacing: defaultPadding,
                mainAxisSpacing: defaultPadding,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                    child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(_prodImg[index]))),
                      ),
                      Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _listProduk[index].nama,
                                style: TextStyle(fontSize: 16),
                              ),
                              Text("Rp ${_listProduk[index].harga} /kg",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Stok : ${_listProduk[index].jumlah}",
                                    style:
                                        TextStyle(color: Colors.grey.shade600),
                                  ),
                                  (widget.userData.role == "admin")
                                      ? IconButton(
                                          color: Colors.grey.shade500,
                                          padding: EdgeInsets.zero,
                                          onPressed: () {},
                                          constraints: BoxConstraints(),
                                          icon: Icon(Icons.edit))
                                      : Container()
                                ],
                              )
                            ],
                          ))
                    ],
                  ),
                ));
              }),
    );
  }
}
