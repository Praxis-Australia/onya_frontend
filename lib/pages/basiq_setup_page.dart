import 'package:onya_frontend/util/connect_basiq.dart';
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
        backgroundColor: Color(0x4fF4F1DE),
        body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Connect your bank',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3D405B),
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