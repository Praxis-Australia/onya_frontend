import 'package:flutter/material.dart';
import 'package:onya_frontend/util/my_firebase_figure.dart';
import 'package:intl/intl.dart';

class MyCard extends StatelessWidget {
  final String amount;
  final String titleText;
  final color;

  const MyCard(
      {Key? key,
      required this.titleText,
      required this.amount,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Container(
            width: 400,
            padding: EdgeInsets.all(25.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 5),
              Text(titleText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 5),
              Text('\$ ' + amount,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 10),
            ])));
  }
}
