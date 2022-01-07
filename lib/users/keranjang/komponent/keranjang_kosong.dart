import 'package:flutter/material.dart';
import 'package:tokoonline/models/keranjang.dart';

class KeranjangKosong extends StatefulWidget {
  final List<Keranjang> keranjanglist;
  const KeranjangKosong({Key key, this.keranjanglist}) : super(key: key);

  @override
  _KeranjangKosongState createState() => _KeranjangKosongState();
}

class _KeranjangKosongState extends State<KeranjangKosong> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 1)),
        builder: (c, s) => s.connectionState == ConnectionState.done
            ? widget.keranjanglist.isEmpty
                ? SafeArea(
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.only(left: 25, right: 25),
                        child: Text("Keranjang Kosong",
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
