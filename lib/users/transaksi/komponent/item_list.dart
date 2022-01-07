// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks

import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  final String nota, tanggal, harga, userid, st;
  const ItemList(
      {Key key, this.nota, this.tanggal, this.harga, this.userid, this.st})
      : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset.zero,
            ),
          ],
        ),
        width: double.infinity,
        height: 100,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 25,
                  width: 60,
                  decoration: BoxDecoration(
                    color: widget.st == "1"
                        ? Colors.blue
                        : widget.st == "2"
                            ? Colors.teal
                            : widget.st == "3"
                                ? Colors.green
                                : Colors.red,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.st == "1"
                          ? "proses"
                          : widget.st == "2"
                              ? "di antar"
                              : widget.st == "3"
                                  ? "selesai"
                                  : "cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Icon(
                        Icons.shopping_bag,
                        size: 30,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Nota : " + widget.nota),
                            Text("Tanggal : " + widget.tanggal),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        /* Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Icon(Icons.shopping_bag),
            ),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.green,
                      child: Text("status"),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(kategori[widget.i].id.toString()),
                            Text(kategori[widget.i].nama),
                            Text(
                              "Rp. 100.000",
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      */
      ),
    );
  }
}
