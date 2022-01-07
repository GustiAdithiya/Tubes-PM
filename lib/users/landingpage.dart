// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tokoonline/constants.dart';
import 'package:tokoonline/users/profile/akunpage.dart';
import 'package:tokoonline/users/beranda/beranda.dart';
import 'package:tokoonline/users/favorite/favoritepage.dart';
import 'package:tokoonline/users/keranjang/keranjangpage.dart';
import 'package:tokoonline/users/transaksi/transaksipage.dart';

class LandingPage extends StatefulWidget {
  final Widget child;
  final String nav;

  const LandingPage({Key key, this.nav, this.child}) : super(key: key);
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _bottomNavCurrentIndex = 0;
  final List<Widget> _container = [
    BerandaPage(),
    FavoritePage(),
    KeranjangPage(),
    TransaksiPage(),
    AkunPage(),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.nav == '0') {
      _bottomNavCurrentIndex = 0;
    } else if (widget.nav == '1') {
      _bottomNavCurrentIndex = 1;
    } else if (widget.nav == '2') {
      _bottomNavCurrentIndex = 2;
    } else if (widget.nav == '3') {
      _bottomNavCurrentIndex = 3;
    } else if (widget.nav == '4') {
      _bottomNavCurrentIndex = 4;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _bottomNavCurrentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _container[_bottomNavCurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Palette.bg1,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _bottomNavCurrentIndex = index;
          });
        },
        currentIndex: _bottomNavCurrentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey),
            label: "Beranda",
            activeIcon: Icon(
              Icons.home,
              color: Palette.bg1,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.grey),
            label: "Favorite",
            activeIcon: Icon(
              Icons.favorite,
              color: Palette.bg1,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.grey),
            label: "Keranjang",
            activeIcon: Icon(
              Icons.shopping_cart,
              color: Palette.bg1,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz_sharp, color: Colors.grey),
            label: "Transaksi",
            activeIcon: Icon(
              Icons.swap_horiz_sharp,
              color: Palette.bg1,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.grey),
            label: "Akun",
            activeIcon: Icon(
              Icons.person,
              color: Palette.bg1,
            ),
          ),
        ],
      ),
    );
  }
}
