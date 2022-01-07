// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoonline/constants.dart';
import 'package:tokoonline/models/Pelanggan.dart';
import 'package:tokoonline/users/landingpage.dart';
import 'package:tokoonline/users/profile/komponent/body.dart';
import 'package:tokoonline/users/profile/komponent/image_with_icon.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  final String userid;
  Profile({Key key, this.userid}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Pelanggan> pelangganList = [];
  String iUrl = Uri.http(Palette.sUrl, "/CodeIgniter3").toString();

  @override
  void initState() {
    super.initState();
    //fetchPelanggan(widget.userid);
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LandingPage()));
  }

  Future<List<Pelanggan>> fetchPelanggan(String id) async {
    List<Pelanggan> usersList;
    var params = "/CodeIgniter3/pelanggan";
    var url = Uri.http(Palette.sUrl, params, {"userid": id});
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        usersList = items.map<Pelanggan>((json) {
          return Pelanggan.fromJson(json);
        }).toList();
        setState(() {
          pelangganList = usersList;
        });
      }
    } catch (e) {
      usersList = pelangganList;
    }
    return usersList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.bg1,
        title: Text("Profile"),
        actions: [IconButton(onPressed: _logout, icon: Icon(Icons.logout))],
      ),
      body: FutureBuilder<List<Pelanggan>>(
          future: fetchPelanggan(widget.userid),
          builder: (context, s) {
            if (!s.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            for (int i = 0; i < s.data.length; i++)
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ImageWithIcon(
                      url: iUrl + "/" + pelangganList[i].foto,
                      email: pelangganList[i].email,
                    ),
                  ),
                  Body(
                      nama: pelangganList[i].nama,
                      alamat: pelangganList[i].alamat,
                      telp: pelangganList[i].telp,
                      kota: pelangganList[i].kota,
                      email: pelangganList[i].email),
                ],
              );
          }),
    );
  }
}
