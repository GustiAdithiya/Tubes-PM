// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  final String title, judul;
  const BuildTextField({Key key, this.title, this.judul}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              judul + " :",
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ),
          Container(
            height: 40,
            width: 300,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(width: 1.0, color: Colors.white70)),
          ),
        ],
      ),
    );
  }
}
