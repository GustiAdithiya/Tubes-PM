import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoonline/constants.dart';
import 'package:tokoonline/users/komponent/belum_login.dart';
import 'package:tokoonline/users/transaksi/komponent/transaksi_login.dart';

class TransaksiPage extends StatefulWidget {
  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  bool login = false;
  String userid = "";

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
      appBar: AppBar(
        backgroundColor: Palette.bg1,
        title: Text("Transaksi"),
      ),
      body: login
          ? TransaksiLogin(
              userid: userid,
            )
          : const BelumLogin(),
    );
  }
}
