import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/produk.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProdukQR extends StatefulWidget {
  static const routeName = "produkQR";

  const ProdukQR({Key? key}) : super(key: key);

  @override
  State<ProdukQR> createState() => _ProdukQRState();
}

class _ProdukQRState extends State<ProdukQR> {
  bool isInit = false;
  late Produk produkitem;
  late PermissionStatus fileStatus;

  @override
  void didChangeDependencies() {
    if (!isInit) {
      setState(() {
        produkitem = ModalRoute.of(context)!.settings.arguments as Produk;
      });
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Produk'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(produkitem.nama),
              Text(produkitem.id),
              QrImage(
                data: produkitem.id,
                size: 200,
              ),
              ElevatedButton(
                  onPressed: () async {
                    checkFileAccess();

                    final qrValRes = QrValidator.validate(
                      data: produkitem.id,
                    );
                    if (qrValRes.status == QrValidationStatus.valid) {
                      final qrCode = qrValRes.qrCode as QrCode;
                      final painter = QrPainter.withQr(
                        qr: qrCode,
                        color: const Color(0x00ffffff),
                        emptyColor: const Color.fromRGBO(255, 255, 255, 100),
                        gapless: false,
                        embeddedImageStyle: null,
                        embeddedImage: null,
                      );

                      String docPath = "/storage/emulated/0/Documents";
                      String path =
                          '$docPath/${produkitem.nama}@${produkitem.id}.png';

                      final picData = await painter.toImageData(2048,
                          format: ImageByteFormat.png) as ByteData;
                      final buffer = picData.buffer;
                      await File(path).writeAsBytes(buffer.asUint8List(
                          picData.offsetInBytes, picData.lengthInBytes));
                      print(path);
                      final snackBar = SnackBar(
                        content: Text('QR Tersimpan di Dokumen'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      print("Error : " + qrValRes.status.toString());
                    }
                  },
                  child: Text('Simpan')),
            ],
          ),
        ),
      ),
    );
  }

  void checkFileAccess() async {
    fileStatus = await Permission.storage.status;
    if (fileStatus == PermissionStatus.denied) {
      if (await Permission.storage.request().isGranted) {
        fileStatus = await Permission.storage.status;
      }
    }
    setState(() {});
  }
}
