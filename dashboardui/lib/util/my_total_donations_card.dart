import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dashboardui/util/my_card.dart';

class MyTotalDonationsCard extends StatelessWidget {
    final String id;
    final color;

    const MyTotalDonationsCard({
        Key? key,
        required this.id,
        required this.color,
    }) : super(key: key);

    DateTime fromTimestampToDateTime(Timestamp timestamp) {
        return DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);
    }

    @override
    Widget build(BuildContext context) {
        return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').doc(id).snapshots(),
            builder: (context, snapshot) {
                if (!snapshot.hasData) {
                return MyCard(
                    titleText: 'Total Donations',
                    amount: 'Loading',
                    date: DateTime.now(),
                    color: color,
                );
                } else {
                return MyCard(
                    titleText: 'Total Donations',
                    amount: snapshot.data!['roundup']['statistics']['total'].toString(),
                    date: fromTimestampToDateTime(snapshot.data!['roundup']['nextDebit']['lastChecked']),
                    color: color,
                );
                }
            }
        );
    }
}