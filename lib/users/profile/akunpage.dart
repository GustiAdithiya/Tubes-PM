// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoonline/users/komponent/belum_login.dart';
import 'package:tokoonline/users/profile/komponent/profile.dart';

class AkunPage extends StatefulWidget {
  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  bool login = false;
  String userid;

  @override
  void initState() {
    super.initState();
    cekLogin();
  }

  cekLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      login = prefs.getBool('login') ?? false;
      userid = prefs.getString('username') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: login ? Profile(userid: userid) : BelumLogin(),
    );
  }
}
