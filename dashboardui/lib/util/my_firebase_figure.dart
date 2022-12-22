import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyFirebaseFigure extends StatelessWidget {
  final String collection;
  final String id;
  final String value;
  final TextStyle style;
  final String preString;

  const MyFirebaseFigure({
    Key? key,
    required this.collection,
    required this.id,
    required this.value,
    required this.style,
    required this.preString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('users').doc(id).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading");
          } else {
            return Text(
              preString + snapshot.data![value],
              style: style,
            );
          }
        });
  }
}
