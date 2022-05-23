import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';
import 'package:java_ijen_mobile/screen/SampelProduk/transfer_screen.dart';
import 'package:searchfield/searchfield.dart';

class AddSampleRequestScreen extends StatefulWidget {
  static const routeName = 'sample_req';
  const AddSampleRequestScreen({Key? key}) : super(key: key);

  @override
  State<AddSampleRequestScreen> createState() => _AddSampleRequestScreenState();
}

class _AddSampleRequestScreenState extends State<AddSampleRequestScreen> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Permintaan Sampel"),
        backgroundColor: darkGrey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
                boxShadow: shadow,
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                            image: NetworkImage(
                                "https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/A_small_cup_of_coffee.JPG/220px-A_small_cup_of_coffee.JPG"))),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Nama Kopi",
                        style: TextStyle(
                            fontSize: 27, fontWeight: FontWeight.w700),
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
                suggestions: [SearchFieldListItem("Jember")],
                // controller: ,
                onSubmit: (value) {},
                searchInputDecoration: InputDecoration(
                    label: Text("Provinsi"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
              SizedBox(height: 12),
              SearchField(
                textInputAction: TextInputAction.done,
                suggestions: [SearchFieldListItem("Jember")],
                // controller: ,
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
              SearchField(
                textInputAction: TextInputAction.done,
                suggestions: [SearchFieldListItem("Jember")],
                // controller: ,
                onSubmit: (value) {},
                searchInputDecoration: InputDecoration(
                    label: Text("Pilih kurir"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
              SizedBox(height: 8),
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
                        "Rp 999999",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          TransferScreen.routeName,
                          arguments: {
                            "id" : "1",
                            "provinsi" : "",
                            "kota" : "",
                            "alamat" : "",
                            "totalOngkir" : 0,
                            "totalHarga" : 0
                          }
                        );
                      },
                      child: Text(
                        "Bayar",
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(green),
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
