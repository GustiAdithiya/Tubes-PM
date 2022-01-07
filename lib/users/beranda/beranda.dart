import 'package:flutter/material.dart';
import 'package:tokoonline/constants.dart';
import 'package:tokoonline/users/beranda/komponents/depanpage.dart';
import 'package:tokoonline/users/beranda/komponents/kategoripage.dart';

class BerandaPage extends StatefulWidget {
  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _activeTabIndex;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onTap: () {},
          readOnly: true,
          style: TextStyle(fontSize: 15),
          decoration: InputDecoration(
            hintText: "Search",
            prefixIcon: Icon(
              Icons.search,
              color: Palette.orange,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white),
            ),
            fillColor: Color(0xfff3f3f4),
            filled: true,
          ),
        ),
        backgroundColor: Palette.bg1,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Palette.orange,
          labelColor: Palette.orange,
          unselectedLabelColor: Colors.grey,
          labelPadding: EdgeInsets.all(0),
          tabs: [
            Tab(text: "Beranda"),
            Tab(text: "Kategori"),
          ],
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          DepanPage(),
          KategoriPage(),
        ],
      ),
    );
  }
}
