import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:onya_frontend/models.dart';
import 'package:onya_frontend/util/my_icon.dart';
import 'package:onya_frontend/util/my_detailed_card.dart';
import 'package:onya_frontend/util/my_total_donations_card.dart';
import 'package:onya_frontend/util/my_roundup_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onya_frontend/util/giving_card.dart';
import 'package:onya_frontend/util/bottom_navigation_bar.dart';

class GlobalScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  GlobalScaffold({
    Key? key,
    required this.body,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBarHeight =
        MediaQuery.of(context).size.height / 10; // 1/8th of the screen height

    double heightOfPageContainer = MediaQuery.of(context).size.height;
    double widthOfPageContainer = MediaQuery.of(context).size.width;

    if (heightOfPageContainer > 900) {
      heightOfPageContainer = 900;
    }

    if (widthOfPageContainer > 450) {
      widthOfPageContainer = 450;
    }

    return Container(
      color: const Color.fromARGB(255, 231, 226, 226),
      child: Center(
        child: Container(
          width: widthOfPageContainer,
          height: heightOfPageContainer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                40.0), // Adjust this for desired curvature
            color: Colors.grey, // Background color of the container
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 3), // Adjust for shadow position
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(appBarHeight),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Color(0x4fF4F1DE),
                  elevation: 0,
                  toolbarHeight:
                      appBarHeight, // Setting the toolbarHeight to the calculated appBarHeight
                  title: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height /
                          100, // Setting a top padding to half the appBarHeight
                    ),
                    child: Align(
                      // Using Align instead of Row
                      alignment: Alignment.topLeft,
                      child: Text(
                        'onya.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: appBarHeight * 0.4,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: IconButton(
                        icon: Icon(Icons.logout, color: Colors.black),
                        onPressed: () async {
                          await _auth.signOut();
                          // Navigate to login or another appropriate page after signout.
                        },
                      ),
                    ),
                  ],
                  centerTitle: false,
                ),
              ),
              body: Container(
                child: body,
              ),
              bottomNavigationBar:
                  BottomNavigationBarWidget(currentIndex: currentIndex),
            ),
          ),
        ),
      ),
    );
  }
}
