// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tokoonline/launcher.dart';
import 'package:tokoonline/users/landingpage.dart' as users;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LauncherPage(),
        routes: <String, WidgetBuilder>{
          '/landingusers': (context) => users.LandingPage(),
          '/keranjangusers': (context) => users.LandingPage(nav: '2'),
          // '/signup': (context) => SignupPage(),
          // '/forgot': (context) => Forgotpage(),
        });
  }
}
