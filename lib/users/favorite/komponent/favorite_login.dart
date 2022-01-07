import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tokoonline/constants.dart';
import 'package:tokoonline/models/produk.dart';
import 'package:tokoonline/users/detail/produkdetailpage.dart';

class FavoriteLogin extends StatefulWidget {
  final String userid;
  const FavoriteLogin({Key key, this.userid}) : super(key: key);

  @override
  _FavoriteLoginState createState() => _FavoriteLoginState();
}

class _FavoriteLoginState extends State<FavoriteLogin> {
  List<Produk> produkList = [];
  String iUrl = Uri.http(Palette.sUrl, "/CodeIgniter3").toString();

  Future<List<Produk>> fetchProduk(String id) async {
    List<Produk> usersList;
    var params = "/CodeIgniter3/produkbyfavorite";
    var url = Uri.http(Palette.sUrl, params, {"id": id});
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        usersList = items.map<Produk>((json) {
          return Produk.fromJson(json);
        }).toList();
        setState(() {
          produkList = usersList;
        });
      }
    } catch (e) {
      usersList = produkList;
    }
    return usersList;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        margin: const EdgeInsets.only(bottom: 7),
        child: FutureBuilder<List<Produk>>(
          future: fetchProduk(widget.userid),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7),
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) => Card(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => ProdukDetailPage(
                          snapshot.data[i].id,
                          snapshot.data[i].judul,
                          snapshot.data[i].harga,
                          snapshot.data[i].hargax,
                          snapshot.data[i].thumbnail,
                          snapshot.data[i].deskripsi,
                          false,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Container(
                            child: Image.network(
                              iUrl + "/" + snapshot.data[i].thumbnail,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            right: -20.0,
                            child: RawMaterialButton(
                              onPressed: () {},
                              fillColor: Colors.white,
                              shape: const CircleBorder(),
                              elevation: 4.0,
                              child: const Padding(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.pink,
                                  size: 17.0,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                          padding: const EdgeInsets.only(top: 5, left: 5),
                          alignment: Alignment.topLeft,
                          child: Text(snapshot.data[i].judul)),
                      Container(
                          padding: const EdgeInsets.only(right: 5, bottom: 5),
                          alignment: Alignment.bottomRight,
                          child: Text(
                            snapshot.data[i].harga,
                            style: const TextStyle(color: Colors.red),
                          )),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
