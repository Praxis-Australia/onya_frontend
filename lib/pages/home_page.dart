import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:onya_frontend/models.dart';
import 'package:onya_frontend/util/my_icon.dart';
import 'package:onya_frontend/util/my_detailed_card.dart';
import 'package:onya_frontend/util/my_total_donations_card.dart';
import 'package:onya_frontend/util/my_roundup_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onya_frontend/util/giving_card.dart';
import 'package:onya_frontend/util/bottom_navigation_bar.dart';

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
    final Iterable<OnyaTransactionDoc>? onyaTransactions =
        Provider.of<Iterable<OnyaTransactionDoc>?>(context);

    double getHeight(num length, num heightOfDevice) {
        if (length == 0) {
          return 0;
        } else if (length * 100 > heightOfDevice/2) {
          return heightOfDevice/2;
        } else {
          return length * 100;
        }
      }  

    final num roundupAccruedSum = userDoc?.donationMethods['nextDebit']['accruedAmount'] ?? 0;
    final num donationSum = onyaTransactions?.fold(0, (sum, transaction) {
      return (sum ?? 0) + transaction.amount;
    }) ?? 0;

    // Define a variable called blue
    final Color blue = Color(0xFF003049);
    // Define a variable called red
    final Color red = Color(0xFFD62828);
    double widthOfDevice = MediaQuery.of(context).size.width;
    double heightOfDevice = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color(0x4fF4F1DE),
        body: SafeArea(
            child: Column(children: [
                          // const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'onya.',
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003049),
                  ),
                ),
              ],
            ), // Row
          ), // Padding

          SizedBox(height: heightOfDevice/40),
          Container(
              height: heightOfDevice/4,
              width: widthOfDevice,
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                children: [
                  MyTotalDonationsCard(
                    total: donationSum / 100,
                    color: Color(0xFF003049),
                  ),
                  MyRoundupCard(
                    accAmount: roundupAccruedSum / 100,
                    color: Color(0xFF003049),
                  ),
                ],
              )),

          SizedBox(height: heightOfDevice/40),

          SmoothPageIndicator(
            controller: _controller,
            count: 2,
            effect: const ExpandingDotsEffect(
              activeDotColor: Color(0xFF003049),
            ),
          ),

          const SizedBox(height: 25),

          // Put two boxes of the same color here
          GivingCardsList(
            width: widthOfDevice/1.1
          ),
        ])),
        bottomNavigationBar: BottomNavigationBarWidget(currentIndex:0)
      );
  }
}