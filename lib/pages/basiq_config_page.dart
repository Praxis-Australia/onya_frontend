import 'package:dashboardui/models.dart';
import 'package:flutter/material.dart';
import 'package:dashboardui/services/db.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class BasiqSetupPage extends StatefulWidget {
  @override
  BasiqSetupPageState createState() => BasiqSetupPageState();
}

class BasiqSetupPageState extends State<BasiqSetupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserDoc? userDoc = Provider.of<UserDoc?>(context);
    final DatabaseService db = Provider.of<DatabaseService>(context);

    Future<void> onPress() async {
      try {
        await db.checkBasiqConnections();
        context.go('/');
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
          SizedBox(
            height: 20.0,
          ),
          Center(
              child: Container(
                  width: 300.0,
                  height: 400.0,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text("Open the Button below to connect your bank"),
                          ElevatedButton(
                              onPressed: () => launchUrl(
                                  Uri.parse(userDoc!.basiq["consentLink"])),
                              child: Text("Connect bank account"))
                        ],
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Once you've connected your bank account through the link, click the button below to continue"),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: onPress,
                                child: const Text('Continue'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue, // background
                                  onPrimary: Colors.white, // foreground
                                ),
                              ),
                            )
                          ]),
                    ],
                  ))),
          SizedBox(
            height: 00.0,
          ),
        ])));
  }
}
