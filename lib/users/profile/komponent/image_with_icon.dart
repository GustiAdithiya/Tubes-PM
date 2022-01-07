import 'package:flutter/material.dart';

class ImageWithIcon extends StatelessWidget {
  final String url, email;
  const ImageWithIcon({Key key, this.url, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool image = url == null ? false : true;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.black12,
                child: ClipOval(
                  child: image
                      ? Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 100,
                        )
                      : Image.network(
                          url,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Positioned(
                  bottom: 1,
                  right: 1,
                  child: Container(
                    height: 40,
                    width: 40,
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ))
            ],
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              email,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
        ],
      ),
    );
  }
}
