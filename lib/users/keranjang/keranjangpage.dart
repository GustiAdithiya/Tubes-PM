// ignore_for_file: use_key_in_widget_constructors

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tokoonline/constants.dart';
import 'package:tokoonline/helper/dbhelper.dart';
import 'package:intl/intl.dart';
import 'package:tokoonline/login/login_screen.dart';
import 'package:tokoonline/models/keranjang.dart';

class KeranjangPage extends StatefulWidget {
  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  DbHelper dbHelper = DbHelper();
  List<Keranjang> keranjanglist = [];
  int _subtotal = 0;
  String iUrl = Uri.http(Palette.sUrl, "/CodeIgniter3").toString();
  bool login = false;
  String userid = "";

  @override
  void initState() {
    super.initState();
    getKeranjang();
    cekLogin();
  }

  loadingProses(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _klikCheckout(List<Keranjang> _keranjang) async {
    loadingProses(context);
    var params = '/CodeIgniter3/klikbayar';
    var body = {'listkeranjang': json.encode(_keranjang)};
    var url = Uri.http(Palette.sUrl, params);
    try {
      http.post(url, body: body).then((value) {
        var res = value.body.toString();
        if (res == "OK") {
          Navigator.of(context).pop();
          _kosongkanKeranjang();
          _scaffold.currentState.showSnackBar(SnackBar(
              content: Text("Pembelian Berhasil"),
              duration: Duration(seconds: 3)));
        }
      });
    } catch (e) {}
    return params;
  }

  Future<List<Keranjang>> getKeranjang() async {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Keranjang>> listFuture = dbHelper.getKeranjang();
      listFuture.then((_keranjanglist) {
        if (mounted) {
          setState(() {
            keranjanglist = _keranjanglist;
          });
        }
      });
    });
    int subtotal = 0;
    for (int i = 0; i < keranjanglist.length; i++) {
      if (keranjanglist[i].hargax.trim() != "0") {
        subtotal +=
            keranjanglist[i].jumlah * int.parse(keranjanglist[i].hargax.trim());
      }
    }
    setState(() {
      _subtotal = subtotal;
    });
    return keranjanglist;
  }

  cekLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      login = prefs.getBool('login') ?? false;
      userid = prefs.getString('username') ?? "";
    });
    print(login);
  }

  _tambahJmlhKeranjang(int id) async {
    Database db = await dbHelper.database;
    var batch = db.batch();
    db.execute('update keranjang set jumlah=jumlah+1 where id=?', [id]);
    await batch.commit();
  }

  _kurangJmlhKeranjang(int id) async {
    Database db = await dbHelper.database;
    var batch = db.batch();
    db.execute('update keranjang set jumlah=jumlah-1 where id=?', [id]);
    await batch.commit();
  }

  _deleteKeranjang(int id) async {
    Database db = await dbHelper.database;
    var batch = db.batch();
    db.execute('delete from keranjang where id=?', [id]);
    await batch.commit();
  }

  _kosongkanKeranjang() async {
    Database db = await dbHelper.database;
    var batch = db.batch();
    db.execute('delete from keranjang');
    await batch.commit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        backgroundColor: Palette.bg1,
        title: Text("Keranjang"),
      ),
      body: keranjanglist.isEmpty ? _keranjangKosong() : _widgetKeranjang(),
      bottomNavigationBar: Visibility(
        visible: keranjanglist.isEmpty ? false : true,
        child: BottomAppBar(
          color: Colors.transparent,
          child: Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total", style: TextStyle(fontSize: 14)),
                        Text(
                            "Rp. " +
                                NumberFormat.currency(
                                        locale: 'ID',
                                        symbol: "",
                                        decimalDigits: 0)
                                    .format(_subtotal)
                                    .toString(),
                            style: TextStyle(color: Colors.red, fontSize: 18))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      login
                          ? _klikCheckout(keranjanglist)
                          : Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Container(
                      height: 40,
                      child: Center(
                        child: Text(
                          'Check Out',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Palette.bg1,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Palette.bg1,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            height: 70,
            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[100],
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  Widget _keranjangKosong() {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 1)),
        builder: (c, s) => s.connectionState == ConnectionState.done
            ? keranjanglist.isEmpty
                ? SafeArea(
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.only(left: 25, right: 25),
                        child: Text("Keranjang Kosong",
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  Widget _widgetKeranjang() {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<List<Keranjang>>(
              future: getKeranjang(),
              builder: (c, s) {
                if (!s.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                return ListView.builder(
                    itemCount: s.data.length,
                    itemBuilder: (c, i) {
                      return Container(
                        height: 110,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[300],
                              width: 1,
                            ),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.white, spreadRadius: 1),
                          ],
                        ),
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.all(10),
                          title: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.network(
                                  iUrl + "/" + s.data[i].thumbnail,
                                  height: 110,
                                  width: 110,
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          s.data[i].judul,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          s.data[i].harga,
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.red),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 100,
                                              margin: EdgeInsets.only(top: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      if (s.data[i].jumlah >
                                                          1) {
                                                        _kurangJmlhKeranjang(
                                                            s.data[i].id);
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.green,
                                                      size: 22,
                                                    ),
                                                  ),
                                                  Text(
                                                    s.data[i].jumlah.toString(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      _tambahJmlhKeranjang(
                                                          s.data[i].id);
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.green,
                                                      size: 22,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 7, 10, 5),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: InkWell(
                                                    onTap: () {
                                                      _deleteKeranjang(
                                                          s.data[i].id);
                                                    },
                                                    child: Container(
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color: Colors.red),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.red,
                                                            spreadRadius: 1,
                                                          )
                                                        ],
                                                      ),
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: Colors.white,
                                                        size: 22,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                      );
                    });
              },
            )),
          ],
        ),
      ),
    );
  }
}
