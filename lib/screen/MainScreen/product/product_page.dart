import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/detailProduct.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/produk.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/produkDB.dart';
import '../../../utils/auth.dart';
import '../../../const.dart';
import 'addProduct_screen.dart';
import 'editProduk_screen.dart';

class ProductPage extends StatefulWidget {
  UserData userData;

  ProductPage({Key? key, required this.userData}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool _isLoading = true;
  late List<Produk> _listProduk;
  late int _totalData;
  List<String> _prodImg = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    _listProduk = await ProdukDB().getProduk();
    _totalData = _listProduk.length;
    for (var i = 0; i < _totalData; i++) {
      final imgUrl = await ProdukDB().getProductImg(_listProduk[i].id);
      _prodImg.add(imgUrl);
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
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
          child: View(screenSize, context),
        ));
  }

  Widget View(Size screenSize, BuildContext context) {
    final screnWidth = MediaQuery.of(context).size.width;
    return Container(
      child: (_isLoading)
          ? Center(child: const CircularProgressIndicator())
          : GridView.builder(
              itemCount: _totalData,
              padding: EdgeInsets.all(defaultPadding),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: screnWidth / 505,
                crossAxisSpacing: defaultPadding,
                mainAxisSpacing: defaultPadding,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      (widget.userData.role == "admin")
                          ? Navigator.pushNamed(context, EditProduk.routeName,
                                  arguments: _listProduk[index].id)
                              .whenComplete(() => fetchData())
                          : Navigator.pushNamed(
                              context, DetailProduct.routeName,
                              arguments: [_listProduk[index].id, null]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: shadow,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8)),
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
                                  Text(
                                    "Stok : ${_listProduk[index].jumlah}",
                                    style:
                                        TextStyle(color: Colors.grey.shade600),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ));
              }),
    );
  }
}
