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
import 'package:onya_frontend/functions/font_sizing_functions.dart';
import 'package:go_router/go_router.dart';
import 'package:onya_frontend/util/donation_setup.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _controller = PageController();
  bool _isModalOpen = false;

  double getHeight(num length, num heightOfDevice) {
    if (length == 0) {
      return 0;
    } else if (length * 100 > heightOfDevice / 2) {
      return heightOfDevice / 2;
    } else {
      return length * 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserDoc? userDoc = Provider.of<UserDoc?>(context);
    final Iterable<OnyaTransactionDoc>? onyaTransactions =
        Provider.of<Iterable<OnyaTransactionDoc>?>(context);

    final num roundupAccruedSum =
        userDoc?.donationMethods['nextDebit']['accruedAmount'] ?? 0;
    final num donationSum = onyaTransactions?.fold(0, (sum, transaction) {
          return (sum ?? 0) + transaction.amount;
        }) ??
        0;

    final Color blue = Color(0xFF003049);
    final Color red = Color(0xFFD62828);
    double widthOfDevice = MediaQuery.of(context).size.width;
    double heightOfDevice = MediaQuery.of(context).size.height;

    return GlobalScaffold(
        body: !_isModalOpen
            ? Container(
                color: Color(0x4fF4F1DE),
                child: SafeArea(
                    child: Column(children: [
                  SizedBox(height: heightOfDevice / 40),
                  Container(
                      height: heightOfDevice / 4,
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
                  SizedBox(height: heightOfDevice / 40),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 2,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Color(0xFF003049),
                    ),
                  ),
                  const SizedBox(height: 25),
                  GivingCardsList(width: 400),
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
                                    radius: 30,
                                    child: Icon(Icons.add,
                                        color: Colors.white,
                                        size: 30.0), // Increase the icon size
                                  ),
                                ),
                              ],
                            ),
                          ),
                  )
                ])),
              )
            : DonationSetupModal(closeModal: () {
                setState(() {
                  _isModalOpen = false;
                });
              }),
        currentIndex: 0);
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
