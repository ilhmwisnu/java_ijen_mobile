import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

import '../../const.dart';
import '../../utils/cost.dart';
import '../../utils/ekspedisi.dart';
import 'transfer_screen.dart';

class PesanProduk extends StatefulWidget {
  static const routeName = "pesanProduk";
  const PesanProduk({Key? key}) : super(key: key);

  @override
  State<PesanProduk> createState() => _PesanProdukState();
}

class _PesanProdukState extends State<PesanProduk> {
  String _prodId = "";
  String _imgUrl = "";
  String _prodName = "";
  int _jumlahProduk = 1;
  int _hargaProduk = 0;
  bool _isLoading = true;
  bool _isInit = false;
  int _hargaOngkir = 0;
  List _provinceList = [];
  List _cityList = [];
  var selectedProvince = null;
  var city_id = null;
  var selectedCourier = null;
  bool isGetCostData = false;
  List<Cost> costData = [];
  TextEditingController _alamatController = TextEditingController();

  @override
  void initState() {
    Ekspedisi.getProvince().then((data) {
      setState(() {
        _provinceList = data;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      final data =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      setState(() {
        _prodId = data["id"];
        _imgUrl = data["imgUrl"];
        _prodName = data["namaProduk"];
        _hargaProduk = int.parse(data["harga"]);
        _isLoading = false;
        _isInit = true;
      });
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void getCity(id) {
    Ekspedisi.getCityById(id).then((data) => {
          setState(() {
            _cityList = data;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    final _alamatNode = FocusNode();
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Pesan Produk"),
        backgroundColor: darkGrey,
      ),
      body: (_isLoading)
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                      boxShadow: shadow,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(_imgUrl))),
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  _prodName,
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "Rp " + _hargaProduk.toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 8),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Jumlah :",
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                            Row(
                              children: [
                                OutlinedButton(
                                    onPressed: () {
                                      if (_jumlahProduk != 1) {
                                        setState(() {
                                          _jumlahProduk -= 1;
                                        });
                                      }
                                    },
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                          color: Colors.grey.shade600),
                                    )),
                                SizedBox(width: 12),
                                Text(
                                  _jumlahProduk.toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(width: 12),
                                OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        _jumlahProduk += 1;
                                      });
                                    },
                                    child: Text(
                                      "+",
                                      style: TextStyle(
                                          color: Colors.grey.shade600),
                                    )),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 8),
                        SearchField(
                          textInputAction: TextInputAction.done,
                          suggestions: _provinceList
                              .map((e) => SearchFieldListItem(e["province"]))
                              .toList(),
                          // controller: ,
                          onSuggestionTap: (selected) {
                            selectedProvince = _provinceList.firstWhere(
                                (element) =>
                                    element["province"] ==
                                    selected.searchKey)["province"];
                            var id = _provinceList.firstWhere((element) =>
                                element["province"] ==
                                selected.searchKey)["province_id"];
                            getCity(id);
                            // print(id);
                          },
                          onSubmit: (value) {},
                          searchInputDecoration: InputDecoration(
                              label: Text("Provinsi"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        SizedBox(height: 12),
                        SearchField(
                          textInputAction: TextInputAction.done,
                          suggestions: (_cityList == [])
                              ? []
                              : _cityList
                                  .map((e) => SearchFieldListItem(
                                      e["type"] + " " + e["city_name"]))
                                  .toList(),
                          onSuggestionTap: (selected) {
                            city_id = _cityList.firstWhere((city) =>
                                city["type"] + " " + city["city_name"] ==
                                selected.searchKey)["city_id"];
                          },
                          onSubmit: (value) {},
                          searchInputDecoration: InputDecoration(
                              label: Text("Kabupaten/Kota"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        SizedBox(height: 12),
                        TextField(
                          focusNode: _alamatNode,
                          minLines: 1,
                          maxLines: 3,
                          controller: _alamatController,
                          decoration: InputDecoration(
                              label: Text("Detail alamat"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Ekspedisi :",
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        SizedBox(height: 4),
                        GestureDetector(
                            onTap: (() {
                              _alamatNode.unfocus();
                              if (city_id == null) {
                                final snackBar = SnackBar(
                                  content:
                                      const Text('Anda belum memilih kota'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                setState(() {
                                  isGetCostData = true;
                                });
                                Ekspedisi.getSampleCost(city_id).then(
                                  (value) {
                                    costData = value;
                                    setState(() {
                                      isGetCostData = false;
                                    });
                                  },
                                ).then((value) {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          padding:
                                              EdgeInsets.all(defaultPadding),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Pilih Layanan Pengiriman",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                for (var cost in costData)
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        _hargaOngkir =
                                                            cost.harga;
                                                        selectedCourier = cost;
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Divider(),
                                                          Text(
                                                            cost.namaLayanan,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Text("Rp " +
                                                              cost.harga
                                                                  .toString()),
                                                          Text("Estimasi : " +
                                                              cost.estimasi),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                });
                              }
                            }),
                            child: (isGetCostData)
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  )
                                : (selectedCourier == null)
                                    ? Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.grey.shade500)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Pilih Pengiriman"),
                                            Icon(
                                              Icons.arrow_right_outlined,
                                              color: Colors.grey.shade600,
                                            )
                                          ],
                                        ))
                                    : Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.grey.shade500)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  selectedCourier.namaLayanan,
                                                  style: TextStyle(),
                                                ),
                                                Text(selectedCourier.harga
                                                    .toString()),
                                              ],
                                            ),
                                            Icon(
                                              Icons.arrow_right_outlined,
                                              color: Colors.grey.shade600,
                                            )
                                          ],
                                        ))),
                        SizedBox(height: 4),
                        Divider(),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Total Ongkos Kirim :"),
                                Text(
                                  "Rp ${_hargaOngkir + _hargaProduk * _jumlahProduk}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  if (selectedProvince != null &&
                                      city_id != null &&
                                      selectedCourier != null &&
                                      _alamatController.text != "") {
                                    final cityName = _cityList.firstWhere(
                                        (city) =>
                                            city["city_id"] ==
                                            city_id)["city_name"];
                                    Navigator.pushNamed(
                                        context, TransferScreen.routeName,
                                        arguments: {
                                          "id": _prodId,
                                          "namaProduk": _prodName,
                                          "provinsi": selectedProvince,
                                          "kota": cityName,
                                          "alamat": _alamatController.text,
                                          "ekspedisi": selectedCourier,
                                          "totalHarga": _hargaProduk,
                                          "jumlah": _jumlahProduk
                                        });
                                  } else {
                                    final snackBar = SnackBar(
                                      content: const Text(
                                          'Data tidak boleh kosong!'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                                child: Text(
                                  "Bayar",
                                  style: TextStyle(fontSize: 16),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(green),
                                  elevation: MaterialStateProperty.all(0),
                                )),
                          ],
                        )
                      ]),
                ),
              ),
            ),
    );
  }
}
