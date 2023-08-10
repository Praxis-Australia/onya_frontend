import 'package:onya_frontend/util/roundup_pref.dart';
import 'package:flutter/material.dart';
import 'package:onya_frontend/util/my_detailed_card.dart';
import 'package:onya_frontend/util/global_scaffold.dart'; // assuming the import for global scaffold
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onya_frontend/util/my_basiq_connect.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:onya_frontend/util/bottom_navigation_bar.dart';
import '../services/db.dart';
import 'package:onya_frontend/util/global_scaffold.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    double widthOfDevice = MediaQuery.of(context).size.width;
    double heightOfDevice = MediaQuery.of(context).size.height;
    return GlobalScaffold(
      body: SafeArea(
        child: Container(
          color: Color(0x4fF4F1DE),
          child: ListView(
            children: [
              SizedBox(height: heightOfDevice / 50),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: widthOfDevice * 0.05),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.grey.withOpacity(0.5),
              //           spreadRadius: 1,
              //           blurRadius: 1,
              //           offset: const Offset(1, 1),
              //         ),
              //       ],
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(20),
              //       border: Border.all(
              //         color: Color(0xFF003049),
              //         width: 1,
              //       ),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(20),
              //       child: Column(
              //         children: [
              //           SizedBox(height: heightOfDevice / 50),
              //           RoundupPreference()
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: heightOfDevice / 30),
              Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 25.0, top: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Terms of service',
                      style: TextStyle(
                        fontSize: 30.0,
                        // fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: heightOfDevice / 50),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: widthOfDevice * 0.05),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(1, 1),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color(0xFF003049),
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Text(
                      "...", // Terms of service text here
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      currentIndex: 2,
    );
  }
}
