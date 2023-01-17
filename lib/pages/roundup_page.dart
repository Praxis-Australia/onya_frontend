import 'package:onya_frontend/services/db.dart';
import 'package:onya_frontend/util/my_roundup_card.dart';
import 'package:onya_frontend/util/roundup_pref.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models.dart';

class RoundupPage extends StatefulWidget {
  const RoundupPage({Key? key}) : super(key: key);

  @override
  RoundupPageState createState() => RoundupPageState();
}

class RoundupPageState extends State<RoundupPage> {
  @override
  Widget build(BuildContext context) {
    final UserDoc userDoc = Provider.of<UserDoc?>(context)!;
    final List<dynamic> roundupTransactionSources = userDoc
        .donationMethods['nextDebit']['donationSources']
        .where((donationSource) => donationSource['method'] == 'roundup')
        .toList();

    final num roundupAccruedSum = userDoc.donationMethods['nextDebit']
            ['donationSources']
        .fold(0, (sum, donationSource) {
      if (donationSource['method'] == 'roundup') {
        return sum + donationSource['amount'];
      }
      return sum;
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
                            'Round-up transactions',
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          MyRoundupCard(
                            accAmount: roundupAccruedSum / 100,
                            color: Colors.green,
                          ),
                          // Listview of widgets for each element in roundupTransactionSources
                          Column(
                              children: roundupTransactionSources
                                  .map((donationSource) =>
                                      RoundupTransactionItem(
                                          data: donationSource))
                                  .toList()),
                        ])),
                  ]))),
        ]), // Row
      ),
    );
  }
}

// Widget which gets a transaction ID and calls returns widget with data from Future call
class RoundupTransactionItem extends StatelessWidget {
  const RoundupTransactionItem({Key? key, required this.data})
      : super(key: key);

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    final DatabaseService db = Provider.of<DatabaseService>(context);
    final String id = data['basiqTransaction'].id;
    return FutureBuilder<BasiqTransactionDoc?>(
        future: db.getBasiqTransaction(id),
        builder: (context, AsyncSnapshot<BasiqTransactionDoc?> asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            final BasiqTransactionDoc snapshot = asyncSnapshot.data!;
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
                    Text("Transaction name: ${snapshot.description}"),
                    Text(
                        "Transaction date: ${DateTime.fromMillisecondsSinceEpoch(snapshot.postDate!.millisecondsSinceEpoch)}"),
                    Text("Transaction amount: ${-1 * snapshot.amount / 100}"),
                    Text("Rounded up amount: ${data['amount']}"),
                  ],
                ));
          } else if (asyncSnapshot.hasError) {
            return const Text("Error");
          }
          return const Text("Not loaded");
        });
  }
}
