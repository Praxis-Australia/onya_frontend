import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onya_frontend/util/my_card.dart';

class MyRoundupCard extends StatelessWidget {
  final num accAmount;
  final Color color;

  const MyRoundupCard({
    Key? key,
    required this.accAmount,
    required this.color,
  }) : super(key: key);

  DateTime? fromTimestampToDateTime(Timestamp? timestamp) {
    if (timestamp == null) {
      return null;
    }
    return DateTime.fromMicrosecondsSinceEpoch(
        timestamp.microsecondsSinceEpoch);
  }

  @override
  Widget build(BuildContext context) {
    return MyCard(
      titleText: 'Accrued Roundup',
      amount: accAmount.toString(),
      color: color,
    );
  }
}
