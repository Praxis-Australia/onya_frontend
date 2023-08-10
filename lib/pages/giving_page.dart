import 'package:flutter/material.dart';
import 'package:onya_frontend/util/donation_setup.dart';
import 'package:go_router/go_router.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({Key? key}) : super(key: key);

  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  @override
  Widget build(BuildContext context) {
    double heightOfPageContainer = MediaQuery.of(context).size.height;
    double widthOfPageContainer = MediaQuery.of(context).size.width;

    if (heightOfPageContainer > 900) {
      heightOfPageContainer = 900;
    }

    if (widthOfPageContainer > 450) {
      widthOfPageContainer = 450;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 226, 226),
      body: Center(
        child: Container(
          width: widthOfPageContainer,
          height: heightOfPageContainer,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              color: Color(0x4fF4F1DE),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: DonationSetup(onDonationSetupComplete: () {
                  context.go('/');
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
