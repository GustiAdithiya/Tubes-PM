// ignore_for_file: prefer_const_constructors, missing_return

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tokoonline/constants.dart';
import 'package:tokoonline/helper/dbhelper.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  final String nav;
  const LoginScreen({Key key, this.nav}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isChecked = false;
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController kota = TextEditingController();
  TextEditingController telp = TextEditingController();
  TextEditingController cpass = TextEditingController();

  bool visible = true;
  DbHelper dbHelper = DbHelper();
  final _form = GlobalKey<FormState>(); //for storing form state.
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  _createAccount() async {
    String params = '/CodeIgniter3/register';
    var url = Uri.http(Palette.sUrl, params);
    Map<String, String> body = {
      "userid": user.text,
      "alamat": alamat.text,
      "kota": kota.text,
      "telp": telp.text,
      "email": email.text,
      "pass": pass.text
    };
    try {
      final response = await http.post(
        url,
        body: body,
      );
      if (response.statusCode == 200) {
        _scaffold.currentState.showSnackBar(SnackBar(
          content: Text("Registration Success",
              style: TextStyle(color: primaryColor)),
          duration: Duration(seconds: 3),
          backgroundColor: secondaryColor,
        ));
      }
    } catch (e) {}
    return params;
  }

  @override
  void initState() {
    super.initState();
  }

  _updateKeranjang(String userid) async {
    Database db = await dbHelper.database;
    var batch = db.batch();
    db.execute('update keranjang set userid=?', [userid]);
    await batch.commit();
  }

  _showAlertDialog(BuildContext context, String e) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context),
    );
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text(e),
      actions: [okButton],
    );
    showDialog(
      context: context,
      builder: (context) => alert,
    );
  }

  _cekLogin() async {
    setState(() {
      visible = true;
    });
    final prefs = await SharedPreferences.getInstance();
    var params = "/CodeIgniter3/login";
    var url = Uri.http(
        Palette.sUrl, params, {"username": user.text, "password": pass.text});
    try {
      var res = await http.get(url);
      print(url);
      if (res.statusCode == 200) {
        var response = json.decode(res.body);
        if (response['response_status'] == 'OK') {
          prefs.setBool('login', true);
          prefs.setString('username', response['data'][0]['username']);
          prefs.setString('nama', response['data'][0]['nama']);
          prefs.setString('email', response['data'][0]['email']);
          prefs.setString('level', response['data'][0]['level']);
          prefs.setString('foto', response['data'][0]['foto']);
          setState(() {
            visible = false;
          });
          if (response['data'][0]['level'] == '1') {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/landingadmin', (route) => false);
          } else if (response['data'][0]['level'] == '2') {
            prefs.setString('alamat', response['data'][0]['alamat']);
            prefs.setString('kota', response['data'][0]['kota']);
            prefs.setString('telp', response['data'][0]['telp']);
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/landingcabang', (route) => false);
          } else {
            prefs.setString('alamat', response['data'][0]['alamat']);
            prefs.setString('kota', response['data'][0]['kota']);
            prefs.setString('telp', response['data'][0]['telp']);
            if (widget.nav == "") {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/landingusers', (route) => false);
            } else {
              _updateKeranjang(response['data'][0]['username']);
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/keranjangusers', (route) => false);
            }
          }
        } else {
          setState(() {
            visible = false;
          });
          _showAlertDialog(context, response['response_message']);
        }
      }
    } catch (e) {
      setState(() {
        visible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      backgroundColor: primaryColor,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          children: [
            Image.asset(
              'assets/logo-furniture.png',
              height: 333,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "Welcome",
                style: dangerTextStyle,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Lorem ipsum dolor sit amet, \nconsectetur adipiscing elit, \nsed do eiusmod",
              textAlign: TextAlign.center,
              style: whiteTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 51,
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width - 2 * defaultMargin,
              child: ElevatedButton(
                onPressed: () {
                  _register(context);
                },
                child: Text('Create Account',
                    style: whiteTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: primaryColor)),
                style: ElevatedButton.styleFrom(
                    primary: secondaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17))),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width - 2 * defaultMargin,
              child: ElevatedButton(
                onPressed: () {
                  _login(context);
                },
                child: Text('Login',
                    style: whiteTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: secondaryColor)),
                style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: secondaryColor, width: 3),
                        borderRadius: BorderRadius.circular(17))),
              ),
            ),
            SizedBox(
              height: 36,
            ),
            Center(
              child: Text(
                "All Right Reserved @2021",
                style: whiteTextStyle.copyWith(
                    fontSize: 11, color: secondaryColor),
              ),
            ),
            SizedBox(
              height: defaultMargin,
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> _login(BuildContext context) {
    return showModalBottomSheet(
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Container(
                  color: primaryColor,
                  child: Container(
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40))),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: defaultMargin),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Welcome Back!!!",
                                        style: whiteTextStyle.copyWith(
                                            color: blackColor, fontSize: 20),
                                      ),
                                      Text(
                                        "Login",
                                        style: dangerTextStyle.copyWith(
                                            color: blackColor, fontSize: 30),
                                      ),
                                    ],
                                  ),

                                  // Button close
                                  IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: defaultMargin),
                                child: TextField(
                                  controller: user,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: "info@example.com",
                                      labelText: 'username/email',
                                      prefixIcon: Icon(Icons.person)),
                                )),
                            SizedBox(
                              height: 20,
                            ),

                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: defaultMargin),
                                child: TextField(
                                  controller: pass,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: "password",
                                      labelText: 'password',
                                      prefixIcon: Icon(Icons.lock_outline)),
                                )),

                            SizedBox(
                              height: 14,
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin),
                              child: Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFD7D7D7),
                                      border: Border.all(
                                          color: primaryColor, width: 3),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Checkbox(
                                      checkColor: Color(0xFFD7D7D7),
                                      value: _isChecked,
                                      onChanged: (value) {
                                        setState(() {
                                          _isChecked = !value;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Remember me",
                                      style: whiteTextStyle.copyWith(
                                          color: primaryColor, fontSize: 12)),
                                  Spacer(),
                                  Text("Forgot Password?",
                                      style: whiteTextStyle.copyWith(
                                          color: primaryColor, fontSize: 12))
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 20,
                            ),

                            // NOTE: BUTTON LOGIN
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin),
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: _cekLogin,
                                  child: Text('Login',
                                      style: whiteTextStyle.copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: secondaryColor)),
                                  style: ElevatedButton.styleFrom(
                                      primary: primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(17))),
                                ),
                              ),
                            ),

                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Don’t have an account?",
                                    style: whiteTextStyle.copyWith(
                                        color: primaryColor, fontSize: 18)),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    _register(context);
                                  },
                                  child: Text(" Register",
                                      style: dangerTextStyle.copyWith(
                                          fontSize: 18)),
                                ),
                              ],
                            ),
                            SizedBox(height: defaultMargin),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          });
        });
  }

  Future<dynamic> _register(BuildContext context) {
    return showModalBottomSheet(
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Container(
                  color: primaryColor,
                  child: Container(
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40))),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: defaultMargin),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hello...",
                                        style: whiteTextStyle.copyWith(
                                            color: blackColor, fontSize: 20),
                                      ),
                                      Text(
                                        "Register",
                                        style: dangerTextStyle.copyWith(
                                            color: blackColor, fontSize: 30),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              height: 350,
                              child: Form(
                                key: _form,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: defaultMargin),
                                          child: TextFormField(
                                            controller: user,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              hintText: "username",
                                              labelText: 'username',
                                              prefixIcon: Icon(Icons.person),
                                            ),
                                            validator: (text) {
                                              if (text == null ||
                                                  text.isEmpty) {
                                                return 'username cannot be empty';
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: defaultMargin),
                                          child: TextFormField(
                                            controller: email,
                                            validator: (text) {
                                              if (text == null ||
                                                  text.isEmpty) {
                                                return 'email cannot be empty';
                                              }
                                            },
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                hintText: "info@example.com",
                                                labelText: 'email',
                                                prefixIcon: Icon(Icons.mail)),
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: defaultMargin),
                                          child: TextFormField(
                                            controller: alamat,
                                            validator: (text) {
                                              if (text == null ||
                                                  text.isEmpty) {
                                                return 'alamat cannot be empty';
                                              }
                                            },
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                hintText: "alamat",
                                                labelText: 'alamat',
                                                prefixIcon: Icon(
                                                    Icons.location_on_sharp)),
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: defaultMargin),
                                          child: TextFormField(
                                            controller: kota,
                                            validator: (text) {
                                              if (text == null ||
                                                  text.isEmpty) {
                                                return 'kota cannot be empty';
                                              }
                                            },
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                hintText: "kota",
                                                labelText: 'kota',
                                                prefixIcon:
                                                    Icon(Icons.location_city)),
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: defaultMargin),
                                          child: TextFormField(
                                            controller: telp,
                                            validator: (text) {
                                              if (text == null ||
                                                  text.isEmpty) {
                                                return 'telp cannot be empty';
                                              }
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                hintText: "089112345678",
                                                labelText: 'telp',
                                                prefixIcon: Icon(Icons.phone)),
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: defaultMargin),
                                          child: TextFormField(
                                            controller: pass,
                                            validator: (text) {
                                              if (text == null ||
                                                  text.isEmpty) {
                                                return 'password cannot be empty';
                                              } else if (text.length < 8) {
                                                return "Enter valid password of more then 8 characters!";
                                              }
                                            },
                                            obscureText: true,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                hintText: "password",
                                                labelText: 'password',
                                                prefixIcon: Icon(Icons.lock)),
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: defaultMargin),
                                          child: TextFormField(
                                            controller: cpass,
                                            obscureText: true,
                                            validator: (text) {
                                              if (text != pass.text) {
                                                return 'password is not correct';
                                              }
                                            },
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                hintText: "confirm password",
                                                labelText: 'confirm password',
                                                prefixIcon: Icon(Icons.lock)),
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // NOTE: BUTTON REGISTER
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin),
                              child: SizedBox(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: () {
                                    final isValid =
                                        _form.currentState.validate();
                                    if (!isValid) {
                                      return;
                                    } else {
                                      _createAccount();
                                      Navigator.pop(context);
                                      _scaffold.currentState
                                          .showSnackBar(SnackBar(
                                        content: Text("Registration Success",
                                            style:
                                                TextStyle(color: primaryColor)),
                                        duration: Duration(seconds: 3),
                                        backgroundColor: secondaryColor,
                                      ));
                                    }
                                    setState(() {
                                      user.text = "";
                                      pass.text = "";
                                      alamat.text = "";
                                      kota.text = "";
                                      telp.text = "";
                                      email.text = "";
                                      cpass.text = "";
                                    });
                                  },
                                  child: Text('Register',
                                      style: whiteTextStyle.copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: secondaryColor)),
                                  style: ElevatedButton.styleFrom(
                                      primary: primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(17))),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Already have account?",
                                    style: whiteTextStyle.copyWith(
                                        color: primaryColor, fontSize: 18)),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    _login(context);
                                  },
                                  child: Text(" Login",
                                      style: dangerTextStyle.copyWith(
                                          fontSize: 18)),
                                ),
                              ],
                            ),
                            SizedBox(height: defaultMargin),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          });
        });
  }
}
