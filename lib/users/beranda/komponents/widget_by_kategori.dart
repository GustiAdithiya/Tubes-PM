import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tokoonline/constants.dart';
import 'package:tokoonline/models/produk.dart';
import 'package:http/http.dart' as http;
import 'package:tokoonline/users/detail/produkdetailpage.dart';
import 'package:tokoonline/users/selengkapnyapage.dart';

class WidgetByKategori extends StatefulWidget {
  final Widget child;
  final int id;
  final String kategori;
  final int warna;

  const WidgetByKategori(this.id, this.kategori, this.warna,
      {Key key, this.child})
      : super(key: key);

  @override
  _WidgetByKategoriState createState() => _WidgetByKategoriState();
}

class _WidgetByKategoriState extends State<WidgetByKategori> {
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
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(right: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 10),
            padding: EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    widget.kategori,
                    style: TextStyle(color: Colors.white),
                  ),
                  width: 200,
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Palette.colors[widget.warna],
                    boxShadow: [
                      BoxShadow(
                        color: Palette.colors[widget.warna],
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    /*Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context)=>ProdukPage("Kat",widget.id,0,widget.kategori;*/
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SelengkapnyaPage(
                                title: widget.kategori,
                                id: widget.id.toString(),
                                ids: "",
                              )));
                    },
                    child: Text(
                      "Selengkapnya",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            margin: EdgeInsets.only(bottom: 7),
            child: widget.id == null
                ? CircularProgressIndicator()
                : FutureBuilder<List<Produk>>(
                    future: fetchProduk(widget.id.toString(), ""),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(child: CircularProgressIndicator());
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) => Card(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<Null>(
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
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 110,
                                    width: 170,
                                    child: Image.network(
                                      iUrl + "/" + snapshot.data[i].thumbnail,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(snapshot.data[i].judul)),
                                  Container(
                                      padding: EdgeInsets.only(
                                          right: 10, bottom: 10),
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        snapshot.data[i].harga,
                                        style: TextStyle(color: Colors.red),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
