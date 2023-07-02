import 'package:onya_frontend/util/roundup_pref.dart';
import 'package:flutter/material.dart';
import 'package:onya_frontend/util/my_detailed_card.dart';
import 'package:onya_frontend/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onya_frontend/util/my_basiq_connect.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:onya_frontend/util/bottom_navigation_bar.dart';

import '../services/db.dart';

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
    return Scaffold(
      backgroundColor: Color(0x4fF4F1DE),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'onya.',
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003049),
                    ),
                  ),
                ],
              ), // Row
            ),
            SizedBox(height: heightOfDevice/50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: heightOfDevice/70),
              child: Container(
                width:widthOfDevice-200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1.0,
                      spreadRadius: 1.0,
                      offset: const Offset(1, 1.0),
                    )
                  ]
                ),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: [
                      SizedBox(height: heightOfDevice/50),
                      RoundupPreference()
                    ]),
                  ),
                ]),
              ),
            ),
            SizedBox(height: heightOfDevice/30),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Terms of service',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003049),
                    ),
                  ),
                ],
              ), // Row
            ),
            SizedBox(height: heightOfDevice/50),
            SizedBox(
              // constraints: BoxConstraints(maxWidth: widthOfDevice - 100),
              width: widthOfDevice-100,
              height: heightOfDevice,
              child:Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                    offset: const Offset(1, 1.0),
                  )
                ],
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              padding: const EdgeInsets.all(30),
              child:SingleChildScrollView(
                child: new Text(
                  "Customer has engaged Basiq Pty Ltd (ABN 2413011011) (Basiq) who operates a data aggregation platform (Platform) to retrieve and collate User Data. User authorises and appoints Customer and its service providers, expressly including Basiq, as User's limited agent solely for the purpose of accessing third party data sources designated by User (User Accounts) through such third party websites, applications and servers, and retrieving information and related documents (User Data) from the designated User Accounts for the purposes of collecting and collating the User Data obtained. Customer and Basiq will use due skill and care in acting as limited agents. For these purposes, User licenses to Customer, and authorises Customer to grant Basiq a non-exclusive, royalty-free sub-license to authentication details and other information required for the access to User Accounts. User agrees that the User Account providers shall be entitled to rely on the foregoing authorisation granted and the appointment as agent. User warrants and agrees that: User is requiring User Data for User's personal and non-commercial use; all information User provides or submits about the User and about User Accounts, is true, accurate, current and complete; User possesses the legal authority to provide the information (e.g. User must be the relevant account holder, or have permission of joint account holders); and User is responsible for updating and maintaining correct information about User (including your personal details) and your User Accounts (including your access information), and information that Basiq retrieves from User Accounts at User's request. User acknowledges that Basiq is acting as Customer's subcontractor and that User's sole recourse is under its agreement with Customer. Basiq is in no way responsible for User's relationship with the providers of User Accounts or Customer, or any of their products, services, acts or omissions. User releases Basiq from all liability and will hold Basiq harmless against any and all claims resulting directly or indirectly from Basiq's access to User Accounts and the retrieval and collation of User Data. To the extent User accesses the Basiq Website or Platform, please note the Basiq End User Terms available on the Basiq Website. For information on Basiq's privacy practices, please review Basiq's privacy policy available on its Website",
                  style: new TextStyle(
                    fontSize: 20.0, color: Colors.black87,
                  ),
                ),
              ),
            )),
          ]
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(currentIndex:3),
    );
  }
}