// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tokoonline/constants.dart';

class BuildBottomAppBar extends StatelessWidget {
  final Function pressK, pressB;
  final bool instok;
  const BuildBottomAppBar({
    Key key,
    this.pressK,
    this.pressB,
    this.instok,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        height: 60,
        padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.grey[100],
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                height: 50,
                width: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Palette.bg1,
                  ),
                ),
                child: IconButton(
                  onPressed: pressK,
                  icon: Icon(
                    Icons.add_shopping_cart_outlined,
                    color: Palette.bg1,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: GestureDetector(
                    onTap: pressB,
                    child: Container(
                      height: 40,
                      child: Center(
                        child: Text(
                          'Beli Sekarang',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: instok == true ? Palette.bg1 : Colors.grey,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: instok == true ? Palette.bg1 : Colors.grey,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
