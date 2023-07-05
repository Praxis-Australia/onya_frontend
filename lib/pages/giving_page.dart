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
    return Scaffold(
      backgroundColor: Color(0x4FF4F1DE),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 500.0,
            child: DonationSetup(onDonationSetupComplete: () {
              context.go('/');
            })
          ),
        ),
      ),
    );
  }
}