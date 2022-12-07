import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:dashboardui/util/my_card.dart';
import 'package:dashboardui/util/my_icon.dart';
import 'package:dashboardui/util/my_detailed_card.dart';
import 'package:dashboardui/pages/payments_page.dart';
import 'package:dashboardui/pages/send_page.dart';
import 'package:dashboardui/pages/give_page.dart';
import 'package:dashboardui/pages/statistics_page.dart';
import 'package:dashboardui/pages/methods_page.dart';
import 'package:dashboardui/pages/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboardui/util/my_firebase_figure.dart';
import 'package:dashboardui/functions/firebase_user_functions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    String id = "h";
    late User user;
    
    void initState() {
      super.initState();
      user = FirebaseAuth.instance.currentUser!;
      id = user.uid;
      print(id);
    }

    // PageView controller
    final _controller = PageController();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.grey[300],
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right:25.0, top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'onya.',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      MyFirebaseFigure(
                        collection:'users',
                        id:id,
                        value:'firstName',
                        style:TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        preString: '',
                      ) // Text
                      // Something here
                    ],
                  ), // Row
                ), // Padding

                SizedBox(height: 25),
                Container(
                  height:180,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    children: [
                      MyCard(
                        titleText: 'Ello', 
                        amount: MyFirebaseFigure(
                          collection:'users',
                          id:id,
                          value:'bigBucks',
                          style:TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          preString: '\$',
                        ), 
                        date: '12/12/2021', 
                        color: Colors.blue
                      ),
                      // MyCard(titleText: 'Giving Preferences', amount: 100, date: '12/12/2021', color: Colors.red),
                      // MyCard(titleText: 'Active Methods', amount: 15, date: '12/12/2021', color: Colors.green),
                    ],
                  )
                ),
                
                SizedBox(height: 25),

                SmoothPageIndicator(
                  controller: _controller, 
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.grey,
                  ),
                ),

                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:15),
                  child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyIcon(icon: 'lib/icons/give-help.png', 
                      color: Colors.grey.shade100, 
                      size: 100, 
                      textDescription:'Give',
                      onPress: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => GivePage()),
                        );
                      },
                    ),
                    MyIcon(icon: 'lib/icons/send.png', 
                      color: Colors.grey.shade100, 
                      size: 100, 
                      textDescription:'Send',
                      onPress: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SendPage()),
                        );
                      },
                    ),
                    MyIcon(icon: 'lib/icons/bill.png', 
                      color: Colors.grey.shade100, 
                      size: 100, 
                      textDescription:'Payments',
                      onPress: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PaymentsPage()),
                        );
                      },
                    ),
                  ]
                )
                ),

                SizedBox(height: 25),

                Column(
                  children:[
                    // Statistics row
                    MyDetailedCard(
                      titleText: 'Statistics',
                      description: 'View your giving statistics',
                      color: Colors.blue,
                      iconPath: 'lib/icons/statistics.png',
                      width: 400,
                      onPress: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => StatisticsPage()),
                        );
                      },
                    ),

                    MyDetailedCard(
                      titleText: 'Methods',
                      description: 'Change your giving methods',
                      color: Colors.red,
                      iconPath: 'lib/icons/types.png',
                      width: 400,
                      onPress: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MethodsPage()),
                        );
                      },
                    ),

                    MyDetailedCard(
                      titleText: 'Settings',
                      description: 'Change preferences',
                      color: Colors.green,
                      iconPath: 'lib/icons/settings.png',
                      width: 400,
                      onPress: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SettingsPage()),
                        );
                      },
                    ),
                  ]
                )
              ]
            )
          )
        );
    }
}