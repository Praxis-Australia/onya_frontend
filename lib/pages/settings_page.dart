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
                      """
These Terms of Service (“Terms”), constitute an agreement between you and Onya (ABN 56 303 385 312), hereafter referred to as “Onya”, “we”, “our” and “us”. These terms govern the use of our website, subdomains, applications and services, hereafter referred to as “Services”. Please read these Terms carefully before use. Contact us if you have any questions. By using Onya, it is deemed that you have read and understand these terms, conclusively accept these terms, and agree to be bound by these Terms. If you do not agree to these terms, you should not access or use our website, subdomain, application and services.

DATA SOURCE ACCESS

Onya has engaged Basiq Pty Ltd (ABN 95 616 592 011) (Basiq) which operates a data aggregation platform (Platform) to retrieve and collate User Data.

You authorise and appoint Onya and its service providers, expressly including Basiq, as your limited agent solely for the purpose of accessing third party data sources designated by you (User Accounts) through such third party websites, applications and servers, and retrieving information and related documents (User Data) from the designated User Accounts for the purposes of collecting and collating the User Data obtained. Onya and Basiq will use due skill and care in acting as limited agents.

For these purposes, you license to Onya, and authorise Onya to grant Basiq a non-exclusive, royalty-free sub-license to authentication details and other information required for the access to User Accounts.

You agree that the User Account providers shall be entitled to rely on the foregoing authorisation granted and the appointment as agent.

USER WARRANTIES

You warrant and agree that:

You use our Services at your own risk;
The Services will only be used for your own lawful purpose in accordance with these Terms;
If there are any unauthorised access or use of our Services or any breach of security, you must immediately notify Onya of such activity;
You require User Data for your personal and non-commercial use;
All information you provide or submit about you and about User Accounts, is true, accurate, current and complete;
You possess the legal authority to provide the information (e.g. you must be the relevant account holder, or have permission of joint account holders); and
You are responsible for updating and maintaining correct (a) information about you (including your personal details) and your User Accounts (including your access information), and (b) information that Basiq retrieves from User Accounts at your request.

USER ACKNOWLEDGEMENT

You acknowledge that Basiq is acting as Onya’s subcontractor and that your sole recourse is under your agreement with Onya. Basiq is in no way responsible for your relationship with the providers of User Accounts or Onya, or any of their products, services, acts or omissions. You release Basiq from all liability and will hold Basiq harmless against any and all claims resulting directly or indirectly from Basiq’s access to User Accounts and the retrieval and collation of User
Data.

To the extent you access the Basiq Website or Platform, please note the Basiq End User Terms available on the Basiq Website.

For information on Basiq’s privacy practices, please review Basiq’s privacy policy available on its Website.

DISCLAIMERS

You acknowledge and agree that:

Your use of our Services and all information, products or content are provided to you in good faith on an “as is” and “as available” basis. To the fullest extent permitted by law, you and Service Providers expressly disclaim all warranties of any kind as to our Services and all information, products and other content (including that of third parties) included in or accessible from our Services;
You are responsible for determining the suitability of any Services and you rely on any Content or other information provided via our Services at your own risk;
Use of our Services, Content and other information provided by Onya and Service Providers is at your own risk and the restrictions applicable to Onya are equally applicable to you;
Onya and Basiq make no warranty that:
Our Services will meet your requirements;
The quality of our Services will meet your expectations;
Our Services will be uninterrupted or error-free;
Any information, product or content obtained via our Services will be accurate or reliable; and
Any errors in the software or technology will be corrected.
You download or otherwise obtain through the use of our Services the material or data at your own discretion and risk and that you will be solely responsible for any infections, contaminations or damage to their computer, system or network; and
Onya and Basiq are not responsible or liable for delays, inaccuracies, errors or omissions arising out of your use of our Services, any third party software, services or operating system.

INDEMNIFICATION

To the full extend permitted by law, you agree to indemnify, defend and hold harmless the Onya and its affiliates and each of its directors, officers, employees and agents from and against any and all claims, liabilities, damages, losses, costs, expenses or fees (including legal fees) arising out of:
Any violation of these Terms or of any intellectual property or other right by you;
any use or misuse of our Services, Content or data from or by you, your employees, contractors or agents or any third party; and
Any breach of law, regulation or licence by you.
You agree that Basiq is a third party beneficiary to the above provisions, with all rights to enforce such provisions as if Basiq is a party to these Terms.

This Agreement is governed by the laws of the Australian Capital Territory, Australia. You agree to submit to the non-exclusive jurisdiction of the courts located within Australian Capital Territory, Australia.

""", // Terms of service text here
                      style: TextStyle(
                        fontSize: 8.0,
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
