import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dashboardui/util/my_card.dart';

class MyTotalDonationsCard extends StatelessWidget {
  final Color color;
  final num total;
  final Timestamp? lastChecked;

  const MyTotalDonationsCard({
    Key? key,
    required this.total,
    required this.lastChecked,
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
      titleText: 'Total Donations',
      amount: total.toString(),
      date: fromTimestampToDateTime(lastChecked),
      color: color,
    );
  }
}
