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
    // final Iterable<OnyaTransactionDoc>? onyaTransactions =
    //     Provider.of<Iterable<OnyaTransactionDoc>?>(context);

    // final num donationSum = onyaTransactions!.fold(0, (sum, transaction) {
    //   return sum + transaction.amount;
    // });

    double getHeight(num length) {
        if (length == 0) {
          return 0;
        } else if (length * 100 > 400) {
          return 400;
        } else {
          return length * 100;
        }
      }  

    final num donationSum = 0;
    final num roundupAccruedSum = 0;

    // final num roundupAccruedSum = userDoc!.donationMethods['nextDebit']
    //         ['accruedAmount']
    //     .fold(0, (sum, donationSource) {
    //   if (donationSource['method'] == 'roundup') {
    //     return sum + donationSource['amount'];
    //   }
    //   return sum;
    // });

    // Define a variable called blue
    final Color blue = Color(0xFF003049);
    // Define a variable called red
    final Color red = Color(0xFFD62828);

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

          const SizedBox(height: 50),
          Container(
              height: 240,
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

          const SizedBox(height: 25),

          SmoothPageIndicator(
            controller: _controller,
            count: 2,
            effect: const ExpandingDotsEffect(
              activeDotColor: Color(0xFF003049),
            ),
          ),

          const SizedBox(height: 25),

          // Put two boxes of the same color here

          Container(
          // if userDoc!.donationMethods!['donationPreferences'].length is null, then make the height 0
          // otherwise make it a multiple of 200

          height: userDoc!.donationMethods!['donationPreferences'] != null
                ? getHeight(userDoc!.donationMethods!['donationPreferences'].length)
                : 0,                   
          
          child:ListView.builder(
            // get length of list from userDoc of variable userDoc!.donationMethods!['nextDebit']['donationSources']
            itemCount: userDoc!.donationMethods!['donationPreferences'] != null
                ? userDoc!.donationMethods!['donationPreferences'].length
                : 0,
            itemBuilder: (context, index) {
              return GivingCard(index:index);
            },
          )),
        ])),

        
        

        bottomNavigationBar: Container(
          height: 90,
          child: BottomNavigationBar(
            backgroundColor: blue,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            selectedFontSize: 16,
            unselectedFontSize: 16,
            selectedLabelStyle: const TextStyle(
              // change the family to regular flutter font
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 40),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.show_chart, size: 40),
                label: 'Data',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group, size: 40),
                label: 'Pledges',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings, size: 40),
                label: 'Settings',
              ),
            ],
            onTap: (index) {
              switch (index) {
                case 0:
                  context.go('');
                  break;
                case 1:
                  context.go('/data');
                  break;
                case 2:
                  context.go('/pledges');
                  break;
                case 3:
                  context.go('/settings');
                  break;
              }
            },
          ),
        ),
      );
  }
}