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

class PledgePage extends StatefulWidget {
  const PledgePage({super.key});

  @override
  PledgePageState createState() => PledgePageState();
}

class PledgePageState extends State<PledgePage> {
  // PageView controller
  final _controller = PageController();

  // Define a function that takes in length and multiplied it by 200 up to a
  // maximum of 800
  double getHeight(num length, num heightOfDevice) {
    if (length == 0) {
      return 0;
    } else if (length * heightOfDevice/6 > heightOfDevice/2) {
      return heightOfDevice/2;
    } else {
      return length * heightOfDevice/6;
    }
  }  

  @override
  Widget build(BuildContext context) {
    final UserDoc? userDoc = Provider.of<UserDoc?>(context);
    final Iterable<OnyaTransactionDoc>? onyaTransactions =
        Provider.of<Iterable<OnyaTransactionDoc>?>(context);
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

          const SizedBox(height: 25),

          Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  // Make this string work even if ${userDoc!.firstName}! is null
                  'Great stuff ' + (userDoc!.firstName ?? 'User') + '!',
                  style: TextStyle(
                    fontSize: 400*50.0/widthOfDevice,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003049),
                  ),
                ),
              ],
            ), // Row
          ), // Padding

          SizedBox(height: heightOfDevice/70),

          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'You have made the following pledges:',
                  style: TextStyle(
                    fontSize: 200*50.0/widthOfDevice,
                    // fontWeight: FontWeight.bold,
                    color: Color(0xFF003049),
                  ),
                ),
              ],
            ), // Row
          ), // Padding

          SizedBox(height: heightOfDevice/50),

          Container(
            width: widthOfDevice - 50,
          // if userDoc!.donationMethods!['donationPreferences'].length is null, then make the height 0
          // otherwise make it a multiple of 200

          height: userDoc!.donationMethods!['donationPreferences'] != null
                ? getHeight(userDoc!.donationMethods!['donationPreferences'].length, heightOfDevice)
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

          // const SizedBox(height: 25),

          // Padding(
          //   padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       const Text(
          //         'You can see our updated list of charities at the link here',
          //         style: TextStyle(
          //           fontSize: 24.0,
          //           // fontWeight: FontWeight.bold,
          //           color: Color(0xFF003049),
          //         ),
          //       ),
          //     ],
          //   ), // Row
          // ), // Padding

          // const SizedBox(height: 25),

          // Button sending you to the onboarding/method page

          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkResponse(
                  onTap: () {
                    context.go('/onboarding/method');
                  },
                  splashFactory: InkRipple.splashFactory,
                  borderRadius: BorderRadius.circular(30), // Make sure this value is equal to the CircleAvatar radius
                  child: CircleAvatar(
                    backgroundColor: Color(0xFF003049),
                    radius: 30, // Adjust this value to make the circle bigger or smaller
                    child: Icon(Icons.add, color: Colors.white, size: 30.0), // Increase the icon size
                  ),
                ),
              ],
            ), // Row
          ), // Padding

          

        ])),

        
        

        bottomNavigationBar: BottomNavigationBarWidget(currentIndex:2)
      );
  }
}