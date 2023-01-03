import 'package:dashboardui/util/connect_basiq.dart';
import 'package:flutter/material.dart';

class BasiqSetupPage extends StatefulWidget {
  const BasiqSetupPage({super.key});

  @override
  BasiqSetupPageState createState() => BasiqSetupPageState();
}

class BasiqSetupPageState extends State<BasiqSetupPage> {
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
                  'setup bank connection.',
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
          const Center(child: ConnectBasiq()),
          const SizedBox(
            height: 00.0,
          ),
        ])));
  }
}
