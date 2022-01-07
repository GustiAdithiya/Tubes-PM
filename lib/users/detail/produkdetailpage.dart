// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tokoonline/constants.dart';
import 'package:tokoonline/helper/dbhelper.dart';
import 'package:tokoonline/models/cabang.dart';
import 'package:tokoonline/models/keranjang.dart';
import 'package:tokoonline/users/detail/komponent/body.dart';
import 'package:tokoonline/users/detail/komponent/build_bottom_app_bar.dart';

class ProdukDetailPage extends StatefulWidget {
  final Widget child;
  final int id;
  final String judul, harga, hargax, thumbnail, deskripsi;
  final bool valstok;

  const ProdukDetailPage(this.id, this.judul, this.harga, this.hargax,
      this.thumbnail, this.deskripsi, this.valstok,
      {Key key, this.child})
      : super(key: key);
  @override
  State<ProdukDetailPage> createState() => _ProdukDetailPageState();
}

class _ProdukDetailPageState extends State<ProdukDetailPage> {
  List<Cabang> cabangList = [];
  String _valcabang;
  bool instok = false;
  String iUrl = Uri.http(Palette.sUrl, "/CodeIgniter3").toString();
  String userid = "";
  DbHelper dbHelper = DbHelper();
  bool fav = false;

  @override
  void initState() {
    super.initState();
    fetchCabang();
    if (widget.valstok == true) {
      instok = widget.valstok;
    }
    cekLogin();
  }

  @override
  void dispose() {
    super.dispose();
  }

  cekLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString('username') ?? "";
    });
    _cekFavorite(widget.id.toString(), userid);
  }

  _cekFavorite(String idproduk, String userid) async {
    var params = "/CodeIgniter3/cekprodukbyfavorite";
    var url = Uri.http(
        Palette.sUrl, params, {"idproduk": idproduk, "userid": userid});
    try {
      var res = await http.get(url);
      if (res.statusCode == 200) {
        if (res.body == "OK") {
          setState(() {
            fav = true;
          });
        } else {
          setState(() {
            fav = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        fav = false;
      });
    }
  }

  klikFavorite(String idproduk, String userid) async {
    String params;
    if (fav) {
      params = '/CodeIgniter3/deletefavorite';
    } else {
      params = '/CodeIgniter3/savefavorite';
    }
    var url = Uri.http(Palette.sUrl, params);
    Map<String, String> body = {"idproduk": idproduk, "userid": userid};
    try {
      final response = await http.post(
        url,
        body: body,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        fav = !fav;
        cekLogin();
      }
    } catch (e) {}
    return params;
  }

  saveKeranjang(Keranjang _keranjang) async {
    Database db = await dbHelper.database;
    var batch = db.batch();
    db.execute(
        'insert into keranjang(idproduk,judul,harga,hargax,thumbnail,jumlah,userid,idcabang) values(?,?,?,?,?,?,?,?)',
        [
          _keranjang.idproduk,
          _keranjang.judul,
          _keranjang.harga,
          _keranjang.hargax,
          _keranjang.thumbnail,
          _keranjang.jumlah,
          _keranjang.userid,
          _keranjang.idcabang
        ]);
    await batch.commit();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/keranjangusers', (route) => false);
  }

  Future<List<Cabang>> fetchCabang() async {
    List<Cabang> usersList;
    var params = "/CodeIgniter3/cabang";
    var url = Uri.http(Palette.sUrl, params);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        usersList = items.map<Cabang>((json) {
          return Cabang.fromJson(json);
        }).toList();
        setState(() {
          cabangList = usersList;
        });
      }
    } catch (e) {
      usersList = cabangList;
    }
    return usersList;
  }

  _cekProdukCabang(String idproduk, String idcabang) async {
    var params = "/CodeIgniter3/cekprodukbycabang";
    var url = Uri.http(
        Palette.sUrl, params, {"idproduk": idproduk, "idcabang": idcabang});
    try {
      var res = await http.get(url);
      if (res.statusCode == 200) {
        if (res.body == "OK") {
          setState(() {
            instok = true;
          });
        } else {
          setState(() {
            instok = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        instok = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.bg1,
        title: Text("Detail Furniture"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Body(
                  judul: widget.judul,
                  harga: widget.harga,
                  deskripsi: widget.deskripsi,
                  url: iUrl + "/" + widget.thumbnail,
                  fav: fav,
                  press: () {
                    klikFavorite(widget.id.toString(), userid);
                  },
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(top: 10, bottom: 10, left: 12),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(const Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(const Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      fillColor: Colors.black,
                      filled: false,
                    ),
                    hint: Text("Pilih Cabang"),
                    value: _valcabang,
                    items: cabangList.map((item) {
                      return DropdownMenuItem(
                        child: Text(item.nama.toString()),
                        value: item.id.toString(),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _valcabang = value;
                        _cekProdukCabang(widget.id.toString(), _valcabang);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BuildBottomAppBar(
        pressK: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/keranjangusers', (Route<dynamic> route) => false);
        },
        pressB: () {
          if (instok == true) {
            Keranjang _keranjangku = Keranjang(
                idproduk: widget.id,
                judul: widget.judul,
                harga: widget.harga,
                hargax: widget.hargax,
                thumbnail: widget.thumbnail,
                jumlah: 1,
                userid: userid,
                idcabang: _valcabang);
            saveKeranjang(_keranjangku);
          }
        },
        instok: instok,
      ),
    );
  }
}
