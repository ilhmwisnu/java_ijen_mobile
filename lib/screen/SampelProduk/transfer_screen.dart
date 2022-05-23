import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:java_ijen_mobile/const.dart';

class TransferScreen extends StatefulWidget {
  static const routeName = "transfer";
  const TransferScreen({Key? key}) : super(key: key);

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          elevation: 0,
          title: Text("Transfer"),
          backgroundColor: darkGrey,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Data Pengirim",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      label: Text("Nama Rekening Pengirim"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                      label: Text("Nomor Rekening Pengirim"),
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                SizedBox(height: defaultPadding),
                Text(
                  "Metode Pembayaran",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.all(defaultPadding),
                  child: Row(
                    children: [
                      Text("Gambar"),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nama Pemiliki Rekening"),
                          Text("Nomor rekening"),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: defaultPadding),
                Text(
                  "Bukti Transfer",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 12),
                //   GestureDetector(
                // onTap: () async {
                //   try {
                //     final XFile? pickedFile =
                //         await _picker.pickImage(source: ImageSource.gallery);
                //     print("ini image_picker");
                //     setState(() {
                //       filePath = pickedFile!.path;
                //     });
                //   } catch (e) {
                //     setState(() {
                //       filePath = "";
                //     });
                //   }
                // },
                // child: Stack(
                //   children: [
                //     Container(
                //       width: double.maxFinite,
                //       height: MediaQuery.of(context).size.width * 3 / 4,
                //       decoration: BoxDecoration(
                //         color: (filePath == null || filePath == "")
                //             ? Colors.grey
                //             : null,
                //         borderRadius: BorderRadius.circular(15),
                //         image: (filePath == null || filePath == "")
                //             ? (remoteImg == null || remoteImg == "")
                //                 ? null
                //                 : DecorationImage(
                //                     fit: BoxFit.cover,
                //                     image: NetworkImage(remoteImg))
                //             : DecorationImage(
                //                 fit: BoxFit.cover,
                //                 image: FileImage(File(filePath))),
                //       ),
                //     ),
                //     Positioned(
                //       top: 0,
                //       bottom: 0,
                //       right: 0,
                //       left: 0,
                //       child: Center(
                //           child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Icon(
                //             Icons.add_a_photo,
                //             color: Colors.white,
                //           ),
                //           SizedBox(height: 8),
                //           Text(
                //             "Change photo",
                //             style: TextStyle(color: Colors.white),
                //           )
                //         ],
                //       )),
                //     )
                //   ],
                // )),
              ],
            ),
          ),
        ));
  }
}
