import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoonline/constants.dart';
import 'package:tokoonline/users/favorite/komponent/favorite_login.dart';
import 'package:tokoonline/users/komponent/belum_login.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
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
        title: const Text("Faforite"),
      ),
      body: login
          ? FavoriteLogin(
              userid: userid,
            )
          : const BelumLogin(),
    );
  }
}
