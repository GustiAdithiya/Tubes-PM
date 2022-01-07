// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_element

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tokoonline/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tokoonline/models/kategori.dart';
import 'package:tokoonline/users/selengkapnyapage.dart';

class KategoriPage extends StatefulWidget {
  @override
  State<KategoriPage> createState() => _KategoriPageState();
}

class _KategoriPageState extends State<KategoriPage> {
  List<Kategori> kategorilist = [];
  bool ktgr = true;
  String idk, title;

  @override
  void initState() {
    super.initState();
    fetchKategori(idk);
  }

  @override
  void dispose() {
    super.dispose();
    kategorilist = null;
  }

  Future<List<Kategori>> fetchKategori(String id) async {
    List<Kategori> usersList;
    var url;
    if (ktgr) {
      var params = "/CodeIgniter3/kategoribyproduk";
      url = Uri.http(Palette.sUrl, params);
    } else {
      var params = "/CodeIgniter3/subkategoribyproduk";
      url = Uri.http(Palette.sUrl, params, {"id": id});
    }

    try {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kategori Produk",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: ktgr ? _kategori() : _subkategori(),
    );
  }

  Widget _kategori() {
    return Container(
      color: Colors.white54,
      child: ListView.builder(
        itemCount: kategorilist.length,
        itemBuilder: (context, index) => Card(
          child: InkWell(
            onTap: () {
              setState(() {
                ktgr = !ktgr;
                fetchKategori(kategorilist[index].id.toString());
                title = kategorilist[index].nama;
                idk = kategorilist[index].id.toString();
              });
            },
            child: ListTile(
              leading: Icon(Icons.label),
              title: Text(kategorilist[index].nama),
              trailing: Icon(Icons.arrow_right_sharp),
            ),
          ),
        ),
      ),
    );
  }

  Widget _subkategori() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
            size: 20,
          ),
          onPressed: () {
            setState(() {
              ktgr = !ktgr;
              fetchKategori(idk);
            });
          },
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SelengkapnyaPage(
                              title: title,
                              id: idk,
                              ids: "",
                            )));
                  },
                  child: Text(
                    "Lihat Semua Produk",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.blueAccent),
                  )),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: kategorilist.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  leading: Icon(Icons.label),
                  title: Text(kategorilist[index].nama),
                  trailing: Icon(Icons.arrow_right_sharp),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SelengkapnyaPage(
                              title: kategorilist[index].nama,
                              id: idk,
                              ids: kategorilist[index].id.toString(),
                            )));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
