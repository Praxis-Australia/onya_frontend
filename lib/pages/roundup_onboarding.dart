import 'package:onya_frontend/services/db.dart';
import 'package:onya_frontend/util/roundup_pref.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

//import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class RoundupOnboardingPage extends StatefulWidget {
  const RoundupOnboardingPage({super.key});

  @override
  RoundupOnboardingPageState createState() => RoundupOnboardingPageState();
}

class RoundupOnboardingPageState extends State<RoundupOnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'configure roundups.',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ), // Text
              ],
            ), // Row
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Center(
            child: SizedBox(
                width: 300.0,
                height: 400.0,
                child: RoundupPreference(
                  isOnboarding: true,
                )),
          ),
          TextButton(
              // Navigate to '/' when pressed
              onPressed: () {
                context.go('/');
              },
              child: const Text("I want to configure this later.")),
          const SizedBox(
            height: 00.0,
          ),
        ])));
  }
}
