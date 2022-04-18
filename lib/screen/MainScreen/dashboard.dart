import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/const.dart';
import 'package:java_ijen_mobile/screen/MainScreen/product_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

class MainScreen extends StatefulWidget {
  static const routeName = "/MainScreen";
  User? user;

  MainScreen({Key? key, this.user}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    
    List<Widget> _pages = [
      HomeOwner(user: widget.user),
      ProductPage(),
      ProfilePage()
    ];

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
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
        body: _pages[_selectedIndex]);
  }
}
