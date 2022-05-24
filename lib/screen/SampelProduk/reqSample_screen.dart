import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';
import 'package:java_ijen_mobile/screen/SampelProduk/transfer_screen.dart';
import 'package:java_ijen_mobile/utils/ekspedisi.dart';
import 'package:searchfield/searchfield.dart';

import '../../utils/cost.dart';

class AddSampleRequestScreen extends StatefulWidget {
  static const routeName = 'sample_req';
  const AddSampleRequestScreen({Key? key}) : super(key: key);

  @override
  State<AddSampleRequestScreen> createState() => _AddSampleRequestScreenState();
}

class _AddSampleRequestScreenState extends State<AddSampleRequestScreen> {
  String _prodId = "";
  String _imgUrl = "";
  String _prodName = "";
  bool _isLoading = true;
  bool _isInit = false;
  int _hargaOngkir = 0;
  List _provinceList = [];
  List _cityList = [];
  var selectedProvince = "";
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
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Permintaan Sampel"),
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
                                Text("Gratis"),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 8),
                        Divider(),
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
                                  "Rp ${_hargaOngkir}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  final cityName = _cityList.firstWhere(
                                          (city) => city["city_id"] == city_id)[
                                      "city_name"];
                                  // print(_prodId);
                                  // print(_prodName);
                                  // print(selectedProvince);
                                  // print(_cityList.firstWhere((city) =>
                                  //     city["city_id"] == city_id)["city_name"]);
                                  // print(_alamatController.text);
                                  // print(selectedCourier);
                                  // print(_hargaOngkir);
                                  Navigator.pushNamed(
                                      context, TransferScreen.routeName,
                                      arguments: {
                                        "id": _prodId,
                                        "namaProduk": _prodName,
                                        "provinsi": selectedProvince,
                                        "kota": cityName,
                                        "alamat": _alamatController.text,
                                        "ekspedisi": selectedCourier,
                                        "totalOngkir": _hargaOngkir,
                                        "totalHarga" : 0
                                      });
                                },
                                child: Text(
                                  "Bayar",
                                  style: TextStyle(fontSize: 16),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(green),
                                  elevation: MaterialStateProperty.all(0),
                                ))
                          ],
                        )
                      ]),
                ),
              ),
            ),
    );
  }
}
