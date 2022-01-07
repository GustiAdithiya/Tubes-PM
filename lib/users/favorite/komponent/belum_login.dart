import 'package:flutter/material.dart';
import 'package:tokoonline/constants.dart';
import 'package:tokoonline/login/login_screen.dart';

class BelumLogin extends StatelessWidget {
  const BelumLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Anda Belum Login"),
              const Text("Silahkan Login"),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    color: Palette.bg1,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
