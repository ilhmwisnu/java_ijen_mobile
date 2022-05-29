import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/screen/Lahan/editLahan_screen.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/addProduct_screen.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/detailProduct.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/editProduk_screen.dart';
import 'package:java_ijen_mobile/screen/Petani/addPetani_screen.dart';
import 'package:java_ijen_mobile/screen/Petani/editPetani_screen.dart';
import 'package:java_ijen_mobile/screen/Petani/petani_screen.dart';
import 'package:java_ijen_mobile/screen/Lahan/lahan_screen.dart';
import 'package:java_ijen_mobile/screen/Lahan/addLahan_screen.dart';
import 'package:java_ijen_mobile/screen/Transaksi/detailBuktiTF_screen.dart';
import 'package:java_ijen_mobile/screen/Transaksi/detail_transaksi.dart';
import 'package:java_ijen_mobile/screen/Transaksi/notifikasiPesanan.dart';
import 'package:java_ijen_mobile/screen/Transaksi/pesanProduk_screen.dart';
import 'package:java_ijen_mobile/screen/Transaksi/trans_screen.dart';
import 'screen/Auth/login_screen.dart';
import 'screen/Auth/register_screen.dart';
import 'screen/Transaksi/reqSample_screen.dart';
import 'screen/Transaksi/transfer_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        PetaniScreen.routeName: (context) => const PetaniScreen(),
        LahanScreen.routeName: (context) => const LahanScreen(),
        AddPetaniScreen.routeName: (context) => const AddPetaniScreen(),
        AddLahanScreen.routeName: (context) => const AddLahanScreen(),
        AddProdukScreen.routeName: (context) => const AddProdukScreen(),
        EditPetani.routeName: (context) => const EditPetani(),
        EditLahan.routeName: (context) => const EditLahan(),
        EditProduk.routeName: (context) => const EditProduk(),
        DetailProduct.routeName: (context) => const DetailProduct(),
        AddSampleRequestScreen.routeName: (context) =>
            const AddSampleRequestScreen(),
        TransferScreen.routeName: (context) => TransferScreen(),
        KonfirmasiPesanan.routeName: (context) => KonfirmasiPesanan(),
        PesanProduk.routeName: (context) => PesanProduk(),
        TransScreen.routeName: (context) => TransScreen(),
        DetailTransaksi.routeName: (context) => DetailTransaksi(),
        BuktiTF.routeName: (context) => BuktiTF()
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
