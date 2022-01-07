// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = Color(0xFF050522);
Color secondaryColor = Color(0xFFFFDE69);
Color dangerColor = Color(0xFFEF5858);
Color blackColor = Color(0xFF050522);
Color whiteColor = Color(0xFFF4F4F4);

double defaultMargin = 24;

TextStyle dangerTextStyle = GoogleFonts.roboto(
    fontSize: 36, color: dangerColor, fontWeight: FontWeight.w500);

TextStyle whiteTextStyle = GoogleFonts.poppins(
    fontSize: 14, color: whiteColor, fontWeight: FontWeight.w500);

class Palette {
  static String sUrl = "172.31.1.39";
  static Color bg2 = Colors.purple[800];
  static Color bg1 = const Color.fromRGBO(0, 0, 110, 1);
  static Color orange = Colors.orange;
  static Color accent = Colors.blueAccent;

  static List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.blue,
  ];
}
