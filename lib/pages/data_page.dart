import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:onya_frontend/models.dart';
import 'package:onya_frontend/util/my_icon.dart';
import 'package:onya_frontend/util/my_detailed_card.dart';
import 'package:onya_frontend/util/my_total_donations_card.dart';
import 'package:onya_frontend/util/my_roundup_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onya_frontend/util/giving_card.dart';
import 'package:onya_frontend/util/graph_card.dart';

import 'package:go_router/go_router.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  DataPageState createState() => DataPageState();
}

class DataPageState extends State<DataPage> {
  // PageView controller
  final _controller = PageController();

  // Define a function that takes in length and multiplied it by 200 up to a
  // maximum of 800
  double getHeight(num length) {
    if (length == 0) {
      return 0;
    } else if (length * 100 > 400) {
      return 400;
    } else {
      return length * 100;
    }
  }

  // Create a function which gets the last set of transactions from a user
  


  @override
  Widget build(BuildContext context) {
    final UserDoc? userDoc = Provider.of<UserDoc?>(context);
    final Iterable<OnyaTransactionDoc>? onyaTransactions =
        Provider.of<Iterable<OnyaTransactionDoc>?>(context);

    // Function to get total amount of all transactions
    final num donationSum = onyaTransactions!.fold(0, (sum, transaction) {
      return sum + transaction.amount;
    });

    return Scaffold(
        backgroundColor: Color(0x4fF4F1DE),
        body: SafeArea(
          child: Column(
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
              ), // Padding
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'You have donated ',
                        style: TextStyle(
                          fontSize: 30.0,
                          // fontWeight: FontWeight.bold,
                          color: Color(0xFF003049),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '\$' + donationSum.toString(),
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF003049),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ), // Row
              ), // Padding
              const SizedBox(height: 25),
              Container(
                height:350,
                width:550,
                // decorate this container with a box decoration
                decoration: BoxDecoration(
                  // add shadow to the container
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  // set the color of the box decoration
                  color: Colors.white,
                  // set the border radius of the box decoration
                  borderRadius: BorderRadius.circular(20),
                  // set the border of the box decoration
                  border: Border.all(
                    // set the color of the border
                    color: Colors.white,
                    // set the width of the border
                    width: 1,
                  ),
                ),
                child: GraphCard(),
              
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Your recent transactions ',
                        style: TextStyle(
                          fontSize: 30.0,
                          // fontWeight: FontWeight.bold,
                          color: Color(0xFF003049),
                        ),
                      ),
                    ),
                  ],
                ), // Row
              ), // Padding
              const SizedBox(height: 25),
              // Create a list of transactions
              Container(
                height: 200,
                width: 550,
                // decorate this container with a box decoration
                child: ListView.separated(
                  itemCount: onyaTransactions!.length,
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  itemBuilder: (context, index) {
                    return Container(child:Text(
                      onyaTransactions!.elementAt(index).amount.toString(),
                      // style
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003049),
                      ),
                    ),
                    // decorate this text
                    decoration: BoxDecoration(
                      // add shadow to the text
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      // set the color of the box decoration
                      color: Colors.white,
                      // set the border radius of the box decoration
                      borderRadius: BorderRadius.circular(20),
                      // set the border of the box decoration
                      border: Border.all(
                        // set the color of the border
                        color: Colors.white,
                        // set the width of the border
                        width: 1,
                      ),
                    ),
                    
                    );
                  },
                ),
              ),



          

        ])),

        
        

        bottomNavigationBar: Container(
          height: 90,
          child: BottomNavigationBar(
            backgroundColor: Color(0xFF003049),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            selectedFontSize: 16,
            unselectedFontSize: 16,
            selectedLabelStyle: const TextStyle(
              // change the family to regular flutter font
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 40),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.show_chart, size: 40),
                label: 'Data',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group, size: 40),
                label: 'Pledges',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings, size: 40),
                label: 'Settings',
              ),
            ],
            onTap: (index) {
              switch (index) {
                case 0:
                  context.go('/');
                  break;
                case 1:
                  context.go('/data');
                  break;
                case 2:
                  context.go('/pledges');
                  break;
                case 3:
                  context.go('/settings');
                  break;
              }
            },
          ),
        ),
      );
  }
}