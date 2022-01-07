// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tokoonline/constants.dart';
import 'package:tokoonline/helper/dbhelper.dart';
import 'package:tokoonline/models/keranjang.dart';

class WidgetKeranjang extends StatefulWidget {
  const WidgetKeranjang({Key key}) : super(key: key);

  @override
  _WidgetKeranjangState createState() => _WidgetKeranjangState();
}

class _WidgetKeranjangState extends State<WidgetKeranjang> {
  DbHelper dbHelper = DbHelper();
  List<Keranjang> keranjanglist = [];
  int _subtotal = 0;
  String iUrl = Uri.http(Palette.sUrl, "/CodeIgniter3").toString();

  @override
  void initState() {
    super.initState();
    getKeranjang();
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<List<Keranjang>>(
              future: getKeranjang(),
              builder: (c, s) {
                if (!s.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

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
                          boxShadow: const [
                            BoxShadow(color: Colors.white, spreadRadius: 1),
                          ],
                        ),
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.all(10),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.network(
                                iUrl + "/" + s.data[i].thumbnail,
                                height: 110,
                                width: 110,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            border:
                                                Border.all(color: Colors.grey),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (s.data[i].jumlah > 1) {
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
                                            margin: EdgeInsets.only(top: 10),
                                            padding: EdgeInsets.fromLTRB(
                                                0, 7, 10, 5),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: InkWell(
                                                onTap: () {
                                                  _deleteKeranjang(
                                                      s.data[i].id);
                                                },
                                                child: Container(
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        color: Colors.red),
                                                    boxShadow: const [
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
                            ],
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
