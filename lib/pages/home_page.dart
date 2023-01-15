import 'package:onya_frontend/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:onya_frontend/util/my_icon.dart';
import 'package:onya_frontend/util/my_detailed_card.dart';
import 'package:onya_frontend/util/my_total_donations_card.dart';
import 'package:onya_frontend/util/my_roundup_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // PageView controller
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final UserDoc? userDoc = Provider.of<UserDoc?>(context);

    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'onya.',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  userDoc!.firstName ?? "No name set",
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  child: const Text('Logout'),
                ) // Text
                // Something here
              ],
            ), // Row
          ), // Padding

          const SizedBox(height: 25),
          Container(
              height: 180,
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                children: [
                  // MyTotalDonationsCard(
                  //   total: userDoc.roundup['statistics']['total'],
                  //   lastChecked: userDoc.roundup['nextDebit']['lastChecked'],
                  //   color: Colors.blue,
                  // ),
                  // MyRoundupCard(
                  //   accAmount: userDoc.roundup['nextDebit']['accAmount'],
                  //   lastChecked: userDoc.roundup['nextDebit']['lastChecked'],
                  //   color: Colors.green,
                  // ),
                  // MyCard(
                  //   titleText: 'Ello',
                  //   amount: MyFirebaseFigure(
                  //     collection:'users',
                  //     id:id,
                  //     value:'firstName',
                  //     style:TextStyle(
                  //       fontSize: 20.0,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.white,
                  //     ),
                  //     preString: 'namo: ',
                  //   ),
                  //   date: '12/12/2021',
                  //   color: Colors.green
                  // ),
                  // MyCard(
                  //   titleText: 'Ello',
                  //   amount: MyFirebaseFigure(
                  //     collection:'users',
                  //     id:id,
                  //     value:'lastName',
                  //     style:TextStyle(
                  //       fontSize: 20.0,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.white,
                  //     ),
                  //     preString: 'name: ',
                  //   ),
                  //   date: '12/12/2021',
                  //   color: Colors.red
                  // ),
                  // MyCard(titleText: 'Giving Preferences', amount: 100, date: '12/12/2021', color: Colors.red),
                  // MyCard(titleText: 'Active Methods', amount: 15, date: '12/12/2021', color: Colors.green),
                ],
              )),

          const SizedBox(height: 25),

          SmoothPageIndicator(
            controller: _controller,
            count: 2,
            effect: const ExpandingDotsEffect(
              activeDotColor: Colors.grey,
            ),
          ),

          const SizedBox(height: 25),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // MyIcon(
                    //   icon: 'lib/icons/give-help.png',
                    //   color: Colors.grey.shade100,
                    //   size: 100,
                    //   textDescription: 'Give',
                    //   onPress: () {
                    //     context.go('/give');
                    //   },
                    // ),
                    // MyIcon(
                    //   icon: 'lib/icons/send.png',
                    //   color: Colors.grey.shade100,
                    //   size: 100,
                    //   textDescription: 'Send',
                    //   onPress: () {
                    //     context.go('/send');
                    //   },
                    // ),
                    MyIcon(
                      icon: 'lib/icons/bill.png',
                      color: Colors.grey.shade100,
                      size: 100,
                      textDescription: 'Payments',
                      onPress: () {
                        context.go('/payments');
                      },
                    ),
                    MyIcon(
                      icon: 'lib/icons/settings.png',
                      color: Colors.grey.shade100,
                      size: 100,
                      textDescription: 'Settings',
                      onPress: () {
                        context.go('/settings');
                      },
                    ),
                  ])),

          const SizedBox(height: 25),

          // Column(children: [
          //   // Statistics row
          //   MyDetailedCard(
          //     titleText: 'Statistics',
          //     description: 'View your giving statistics',
          //     color: Colors.blue,
          //     iconPath: 'lib/icons/statistics.png',
          //     width: 400,
          //     onPress: () {
          //       context.go('/stats');
          //     },
          //   ),

          //   MyDetailedCard(
          //     titleText: 'Methods',
          //     description: 'Change your giving methods',
          //     color: Colors.red,
          //     iconPath: 'lib/icons/types.png',
          //     width: 400,
          //     onPress: () {
          //       context.go('/methods');
          //     },
          //   ),

          //   MyDetailedCard(
          //     titleText: 'Settings',
          //     description: 'Change preferences',
          //     color: Colors.green,
          //     iconPath: 'lib/icons/settings.png',
          //     width: 400,
          //     onPress: () {
          //       context.go('/settings');
          //     },
          //   ),
          // ])
        ])));
  }
}
