// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tokoonline/constants.dart';
import 'package:tokoonline/models/produk.dart';
import 'package:http/http.dart' as http;
import 'package:tokoonline/users/detail/produkdetailpage.dart';

class SelengkapnyaPage extends StatefulWidget {
  final String title, id, ids;

  const SelengkapnyaPage({Key key, this.title, this.id, this.ids})
      : super(key: key);
  @override
  State<SelengkapnyaPage> createState() => _SelengkapnyaPageState();
}

class _SelengkapnyaPageState extends State<SelengkapnyaPage> {
  List<Produk> produkList = [];
  String iUrl = Uri.http(Palette.sUrl, "/CodeIgniter3").toString();

  Future<List<Produk>> fetchProduk(
      String idkategori, String idsubkategori) async {
    List<Produk> usersList;
    var params = "/CodeIgniter3/produkbykategori";
    var url = Uri.http(Palette.sUrl, params,
        {"idkategori": idkategori, "idsubkategori": idsubkategori});
    try {
      var response = await http.get(url);
      print(idkategori + " " + idsubkategori);
      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        usersList = items.map<Produk>((json) {
          return Produk.fromJson(json);
        }).toList();
        setState(() {
          produkList = usersList;
        });
      }
    } catch (e) {
      usersList = produkList;
    }
    return usersList;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.bg1,
        title: Text(widget.title),
      ),
      body: Container(
        height: size.height,
        margin: EdgeInsets.only(bottom: 7),
        child: FutureBuilder<List<Produk>>(
          future: fetchProduk(widget.id.toString(), widget.ids.toString()),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7),
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) => Card(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => ProdukDetailPage(
                          snapshot.data[i].id,
                          snapshot.data[i].judul,
                          snapshot.data[i].harga,
                          snapshot.data[i].hargax,
                          snapshot.data[i].thumbnail,
                          snapshot.data[i].deskripsi,
                          false,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        iUrl + "/" + snapshot.data[i].thumbnail,
                        fit: BoxFit.fill,
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 5, left: 5),
                          alignment: Alignment.topLeft,
                          child: Text(snapshot.data[i].judul)),
                      Container(
                          padding: EdgeInsets.only(right: 5, bottom: 5),
                          alignment: Alignment.bottomRight,
                          child: Text(
                            snapshot.data[i].harga,
                            style: TextStyle(color: Colors.red),
                          )),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
