import 'package:flutter/material.dart';
import 'package:dashboardui/util/my_detailed_card.dart';
import 'package:dashboardui/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboardui/util/my_basiq_connect.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String id = "h";
  late User user;

  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    id = user.uid;
    print(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(children: [
          Padding(
              padding:
                  const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
              child: Container(
                  child: Row(children: [
                RotatedBox(
                  quarterTurns: 2,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: Text(
                    'home',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ), // InkWell Text
                )
              ]))),
          SizedBox(height: 15),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  child: Column(children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 15.0),
                        child: Container(
                            child: Row(children: [
                          Text(
                            'Connections',
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]))),
                    Container(
                      height: 300,
                      child: MyBasiqConnect(id: id),
                    ),
                  ]))),
        ]), // Row
      ),
    );
  }
}
