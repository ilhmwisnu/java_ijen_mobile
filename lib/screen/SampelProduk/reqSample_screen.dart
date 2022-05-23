import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';
import 'package:java_ijen_mobile/screen/SampelProduk/transfer_screen.dart';
import 'package:java_ijen_mobile/utils/ekspedisi.dart';
import 'package:searchfield/searchfield.dart';

class AddSampleRequestScreen extends StatefulWidget {
  static const routeName = 'sample_req';
  const AddSampleRequestScreen({Key? key}) : super(key: key);

  @override
  State<AddSampleRequestScreen> createState() => _AddSampleRequestScreenState();
}

class _AddSampleRequestScreenState extends State<AddSampleRequestScreen> {
  String _imgUrl = "";
  String _prodName = "";
  bool _isLoading = true;
  bool _isInit = false;
  int _hargaOngkir = 0;
  List _provinceList = [];
  List _cityList = [];
  String ekspedisiValue = "";
  String city_id = "";

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
                        DropdownButton(
                          borderRadius: BorderRadius.circular(12),
                          isExpanded: true,
                          hint: Text("Pilih Ekspedisi"),
                          value: (ekspedisiValue == "") ? null : ekspedisiValue,
                          items: ["JNE", "POS", "Tiki"]
                              .map((data) => DropdownMenuItem(
                                    child: Text(data),
                                    value: data.toString().toLowerCase(),
                                  ))
                              .toList(),
                          onChanged: (e) {
                            setState(() {
                              ekspedisiValue = e.toString();
                            });
                          },
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Layanan :",
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        DropdownButton(
                          borderRadius: BorderRadius.circular(12),
                          isExpanded: true,
                          hint: Text("Pilih Layanan"),
                          value: (ekspedisiValue == "") ? null : ekspedisiValue,
                          items: ["JNE", "POS", "Tiki"]
                              .map((data) => DropdownMenuItem(
                                    child: Text(data),
                                    value: data.toString().toLowerCase(),
                                  ))
                              .toList(),
                          onChanged: (e) {
                            setState(() {
                              ekspedisiValue = e.toString();
                            });
                          },
                        ),
                        // SearchField(
                        //   textInputAction: TextInputAction.done,
                        //   suggestions: [SearchFieldListItem("Jember")],
                        //   // controller: ,
                        //   onSubmit: (value) {},
                        //   searchInputDecoration: InputDecoration(
                        //       label: Text("Pilih Ekspedisi"),
                        //       border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(8))),
                        // ),
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
                                  // Navigator.pushNamed(context, TransferScreen.routeName,
                                  //     arguments: {
                                  //       "id": "1",
                                  //       "provinsi": "",
                                  //       "kota": "",
                                  //       "alamat": "",
                                  //       "totalOngkir": 0,
                                  //       "totalHarga": 0
                                  //     });
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
