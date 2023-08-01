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
import 'package:onya_frontend/util/global_scaffold.dart';

import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // PageView controller
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final UserDoc? userDoc = Provider.of<UserDoc?>(context);
    double getHeight(num length, num heightOfDevice) {
        if (length == 0) {
          return 0;
        } else if (length * 100 > heightOfDevice/2) {
          return heightOfDevice/2;
        } else {
          return length * 100;
        }
    }

    final num donationSum = 0;
    final num roundupAccruedSum = 0;
    double widthOfDevice = MediaQuery.of(context).size.width;
    double heightOfDevice = MediaQuery.of(context).size.height;

    return GlobalScaffold(
      body: Container(
        color: Color(0x4fF4F1DE),
        child: SafeArea(
            child: Column(children: [
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

          Container(
            width: widthOfDevice/1.1,
            height: userDoc!.donationMethods['donationPreferences'] != null
                  ? getHeight(userDoc!.donationMethods!['donationPreferences'].length, heightOfDevice)
                  : 0,                   

            child:ListView.builder(
              itemCount: userDoc!.donationMethods['donationPreferences'] != null
                  ? userDoc!.donationMethods['donationPreferences'].length
                  : 0,
              itemBuilder: (context, index) {
                return GivingCard(index:index);
              },
            ),
          ),
        ])),
      ),
      currentIndex: 0,
    );
  }
}
