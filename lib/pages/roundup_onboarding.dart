import 'package:flutter/material.dart';
import 'package:onya_frontend/services/db.dart';
import 'package:onya_frontend/util/roundup_pref.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RoundupOnboardingPage extends StatefulWidget {
  const RoundupOnboardingPage({Key? key}) : super(key: key);

  @override
  _RoundupOnboardingPageState createState() => _RoundupOnboardingPageState();
}

class _RoundupOnboardingPageState extends State<RoundupOnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x4fF4F1DE),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Centered heading saying "Almost there..."
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Almost there...',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff3D405B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50.0),
            Center(
              child: SizedBox(
                width: 350.0,
                height: 400.0,
                child: RoundupPreference(isOnboarding: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}