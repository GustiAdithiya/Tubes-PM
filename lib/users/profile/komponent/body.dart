// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tokoonline/users/profile/komponent/build_text_field.dart';

class Body extends StatefulWidget {
  final String nama, kota, alamat, telp, email;
  const Body(
      {Key key, this.nama, this.kota, this.alamat, this.telp, this.email})
      : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple[900], Colors.indigo[800]],
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  BuildTextField(
                    title: widget.nama,
                    judul: "Nama",
                  ),
                  BuildTextField(title: widget.alamat, judul: "Alamat"),
                  BuildTextField(title: widget.kota, judul: "Kota"),
                  BuildTextField(title: widget.telp, judul: "Telp"),
                  BuildTextField(title: widget.email, judul: "Email"),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 50,
                  width: 100,
                  child: Align(
                    child: Text(
                      'Edit',
                      style: TextStyle(color: Colors.white70, fontSize: 20),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
