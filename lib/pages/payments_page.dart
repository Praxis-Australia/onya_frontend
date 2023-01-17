import 'package:flutter/material.dart';
import 'package:onya_frontend/util/my_transaction_card.dart';
import 'package:onya_frontend/pages/home_page.dart';
import 'package:onya_frontend/functions/firebase_user_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models.dart';
import '../util/my_total_donations_card.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({Key? key}) : super(key: key);

  @override
  PaymentsPageState createState() => PaymentsPageState();
}

class PaymentsPageState extends State<PaymentsPage> {
  @override
  Widget build(BuildContext context) {
    final Iterable<OnyaTransactionDoc>? onyaTransactions =
        Provider.of<Iterable<OnyaTransactionDoc>?>(context);

    final num donationSum = onyaTransactions!.fold(0, (sum, transaction) {
      return sum + transaction.amount;
    });

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(children: [
          Padding(
              padding:
                  const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
              child: Row(children: [
                const RotatedBox(
                  quarterTurns: 2,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: const Text(
                    'home',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ), // InkWell Text
                )
              ])),
          const SizedBox(height: 15),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(40))),
                  child: Column(children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 15.0),
                        child: Column(children: [
                          const Text(
                            'Issued Transactions',
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          MyTotalDonationsCard(
                            total: donationSum / 100,
                            color: Colors.blue,
                          ),
                          // Listview of widgets for each element in roundupTransactionSources
                          Column(
                              children: onyaTransactions
                                  .map((transaction) =>
                                      OnyaTransactionItem(data: transaction))
                                  .toList()),
                        ])),
                  ]))),
        ]), // Row
      ),
    );
  }
}

class OnyaTransactionItem extends StatelessWidget {
  const OnyaTransactionItem({Key? key, required this.data}) : super(key: key);

  final OnyaTransactionDoc data;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        // Add rounded corners and black border
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.black)),
        child: Column(
          children: [
            Text("Transaction amount: ${data.amount / 100}"),
            Text(
                "Transaction issued on: ${DateTime.fromMillisecondsSinceEpoch(data.created.millisecondsSinceEpoch)}")
          ],
        ));
  }
}
