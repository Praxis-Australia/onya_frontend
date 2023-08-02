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
import 'package:onya_frontend/functions/font_sizing_functions.dart';
import 'package:onya_frontend/util/global_scaffold.dart';

import 'package:go_router/go_router.dart';

import '../util/donation_setup.dart';
import '../util/global_scaffold.dart';

class PledgePage extends StatefulWidget {
  const PledgePage({super.key});

  @override
  PledgePageState createState() => PledgePageState();
}

class PledgePageState extends State<PledgePage> {
  // PageView controller
  final _controller = PageController();
  bool _isModalOpen = false;

  // Define a function that takes in length and multiplied it by 200 up to a
  // maximum of 800
  double getHeight(num length, num heightOfDevice) {
    if (length == 0) {
      return 0;
    } else if (length * heightOfDevice / 6 > heightOfDevice / 2) {
      return heightOfDevice / 2;
    } else {
      return length * heightOfDevice / 6;
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserDoc? userDoc = Provider.of<UserDoc?>(context);
    final Iterable<OnyaTransactionDoc>? onyaTransactions =
        Provider.of<Iterable<OnyaTransactionDoc>?>(context);
    double widthOfDevice = MediaQuery.of(context).size.width;
    double heightOfDevice = MediaQuery.of(context).size.height;

    return !_isModalOpen
        ? GlobalScaffold(
            currentIndex: 2,
            body: Scaffold(
                backgroundColor: Color(0x4fF4F1DE),
                body: SafeArea(
                    child: Column(children: [
                  // const SizedBox(height: 25),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          // Make this string work even if ${userDoc!.firstName}! is null
                          'Great stuff ' + (userDoc!.firstName ?? 'User') + '!',
                          style: TextStyle(
                            fontSize: 400 * 40.0 / widthOfDevice,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF003049),
                          ),
                        ),
                      ],
                    ), // Row
                  ), // Padding

                  SizedBox(height: heightOfDevice / 70),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You have made the pledge:',
                          style: TextStyle(
                            fontSize: 200 * 50.0 / widthOfDevice,
                            // fontWeight: FontWeight.bold,
                            color: Color(0xFF003049),
                          ),
                        ),
                      ],
                    ), // Row
                  ), // Padding

                  SizedBox(height: heightOfDevice / 50),

                  GivingCardsList(width: widthOfDevice - 50),

                  // Button sending you to the onboarding/method page
                  Container(
                    child: userDoc!.donationMethods['roundup']['isEnabled']
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkResponse(
                                  onTap: () {
                                    setState(() {
                                      _isModalOpen = true;
                                    });
                                  },
                                  splashFactory: InkRipple.splashFactory,
                                  borderRadius: BorderRadius.circular(
                                      30), // Make sure this value is equal to the CircleAvatar radius
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xFF003049),
                                    radius:
                                        30, // Adjust this value to make the circle bigger or smaller
                                    child: Icon(Icons.add,
                                        color: Colors.white,
                                        size: 30.0), // Increase the icon size
                                  ),
                                ),
                              ],
                            ),
                          ),
                  )
                ]))))
        : GlobalScaffold(
            body: DonationSetupModal(closeModal: () {
              setState(() {
                _isModalOpen = false;
              });
            }),
            currentIndex: 2);
  }
}

class DonationSetupModal extends StatelessWidget {
  final void Function() closeModal;
  const DonationSetupModal({Key? key, required this.closeModal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x4FF4F1DE),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 500.0,
                child: DonationSetup(onDonationSetupComplete: closeModal),
              ),
            ),
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: closeModal,
            ),
          ),
        ],
      ),
    );
  }
}
