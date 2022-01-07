import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tokoonline/constants.dart';
import 'package:tokoonline/models/kategori.dart';
import 'package:tokoonline/users/beranda/komponents/widget_by_kategori.dart';

class DepanPage extends StatefulWidget {
  @override
  State<DepanPage> createState() => _DepanPageState();
}

class _DepanPageState extends State<DepanPage> {
  List<Kategori> kategorilist = [];

  @override
  void initState() {
    super.initState();
    fetchKategori();
  }

  @override
  void dispose() {
    super.dispose();
    kategorilist = null;
  }

  Future<List<Kategori>> fetchKategori() async {
    List<Kategori> usersList;
    var params = "/CodeIgniter3/kategoribyproduk";
    var url = Uri.http(Palette.sUrl, params);
    try {
      print(url);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        usersList = items.map<Kategori>((json) {
          return Kategori.fromJson(json);
        }).toList();
        setState(() {
          kategorilist = usersList;
        });
      }
    } catch (e) {
      usersList = kategorilist;
    }
    return usersList;
  }

  Future<Null> _refresh() {
    return fetchKategori().then((_kategori) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (int i = 0; i < kategorilist.length; i++)
                          WidgetByKategori(kategorilist[i].id,
                              kategorilist[i].nama.toString(), i),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
