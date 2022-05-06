import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product/product_page.dart';
import '../../utils/auth.dart';
import 'home_page.dart';
import 'profile/profile_page.dart';

class MainScreen extends StatefulWidget {
  static const routeName = "/MainScreen";
  User? user;

  MainScreen({Key? key, this.user}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late UserData _userData;
  bool isLoading = false;

  List<BottomNavigationBarItem> _bottomNavBar() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        label: "Produk",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: "Profil",
      ),
    ];
  }

  Future<void> getUserData() async {
    setState(() {
      isLoading = true;
    });
    final result = await FireAuth.getUserData(widget.user!.uid);
    _userData = result;
    print(_userData.img);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = (isLoading)
        ? [
            Center(child: CircularProgressIndicator()),
            Center(child: CircularProgressIndicator()),
            Center(child: CircularProgressIndicator()),
          ]
        : [
            HomeOwner(
              userData: _userData,
            ),
            ProductPage(
              userData: _userData,
            ),
            ProfilePage(
              user: widget.user,
              reload: () {
                getUserData();
                setState(() {
                  
                });
              },
              userData: _userData
            )
          ];

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          iconSize: 32,
          items: _bottomNavBar(),
          currentIndex: _selectedIndex,
          selectedItemColor: darkChoco,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        backgroundColor: Colors.white,
        body: _pages[_selectedIndex]);
  }
}
