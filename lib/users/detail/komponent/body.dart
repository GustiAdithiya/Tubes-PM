// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tokoonline/users/detail/komponent/build_image.dart';

class Body extends StatelessWidget {
  final String judul, harga, deskripsi, url;
  final bool fav;
  final Function press;
  const Body(
      {Key key,
      this.judul,
      this.harga,
      this.deskripsi,
      this.url,
      this.fav,
      this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10.0),
        BuildImage(
          url: url,
          fav: fav,
          press: press,
        ),
        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            judul,
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          child: Text(
            harga,
            style: TextStyle(
              color: Colors.red,
              fontSize: 27.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 30.0),
        Text(
          "Deskripsi",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          deskripsi,
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }
}
