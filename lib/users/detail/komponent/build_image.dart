// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BuildImage extends StatelessWidget {
  final String url;
  final bool fav;
  final Function press;
  const BuildImage({
    Key key,
    this.url,
    this.fav,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 300.0,
      width: size.width,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              url,
              height: 300.0,
              width: size.width,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: -10.0,
            bottom: 3.0,
            child: RawMaterialButton(
              onPressed: press,
              fillColor: Colors.white,
              shape: CircleBorder(),
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  fav ? Icons.favorite : Icons.favorite_border,
                  color: Colors.pink,
                  size: 17.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
