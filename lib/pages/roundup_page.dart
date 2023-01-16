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

    print(roundupTransactionSources.length);
    print(roundupTransactionSources.first);

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
                  height: 600,
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
                          Container(
                            child: ListView.builder(
                              itemCount: roundupTransactionSources.length,
                              itemBuilder: (context, index) {
                                return Text(
                                    roundupTransactionSources[index]['amount']);
                              },
                            ),
                          )
                        ])),
                  ]))),
        ]), // Row
      ),
    );
  }
}
