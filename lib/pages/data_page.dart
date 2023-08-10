import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:intl/intl.dart';

import 'package:onya_frontend/models.dart';
import 'package:onya_frontend/util/my_icon.dart';
import 'package:onya_frontend/util/my_detailed_card.dart';
import 'package:onya_frontend/util/my_total_donations_card.dart';
import 'package:onya_frontend/util/my_roundup_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onya_frontend/util/giving_card.dart';
import 'package:onya_frontend/util/graph_card.dart';
import 'package:onya_frontend/util/bottom_navigation_bar.dart';
import 'package:onya_frontend/util/global_scaffold.dart';
import 'package:onya_frontend/util/transaction_widget.dart';

import 'package:go_router/go_router.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    double widthOfDevice = MediaQuery.of(context).size.width;
    double heightOfDevice = MediaQuery.of(context).size.height;
    final UserDoc? userDoc = Provider.of<UserDoc?>(context);
    final Iterable<OnyaTransactionDoc>? onyaTransactions =
        Provider.of<Iterable<OnyaTransactionDoc>?>(context);

    // Function to get total amount of all transactions
    final num donationSum = onyaTransactions!.fold(0, (sum, transaction) {
      return sum + transaction.amount;
    });

    return GlobalScaffold(
      currentIndex: 1,
      body: SafeArea(
          child: Container(
        color: Color(0x4fF4F1DE),
        child: Column(
          children: [
            // SizedBox(height: heightOfDevice / 70),
            SizedBox(height: heightOfDevice / 50),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'You have donated ',
                      style: TextStyle(fontSize: 30.0, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: '\$' + (donationSum / 100).toString(),
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: heightOfDevice / 40),
            Container(
              height: heightOfDevice / 3,
              width: widthOfDevice - 50,
              decoration: BoxDecoration(
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 1,
                //     blurRadius: 1,
                //     offset: const Offset(1, 1),
                //   ),
                // ],
                color: Colors.transparent,
                // borderRadius: BorderRadius.circular(20),
                // border: Border.all(
                //   color: Color(0xFF003049),
                //   width: 1,
                // ),
              ),
              child: GraphCard(),
            ),
            SizedBox(height: heightOfDevice / 20),
            // onyaTransactions!.length == 0
            //     ? Container()
            //     : Padding(
            //         padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             RichText(
            //               text: TextSpan(
            //                 text: 'Your recent transactions ',
            //                 style: TextStyle(
            //                   fontSize: 30.0,
            //                   color: Colors.black,
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            // SizedBox(height: heightOfDevice / 50),
            // Container(
            //   height: heightOfDevice / 4.5,
            //   width: widthOfDevice - 50,
            //   child: ListView.builder(
            //     itemCount: onyaTransactions!.length,
            //     itemBuilder: (context, index) {
            //       return Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           Container(
            //             height: heightOfDevice / 10,
            //             padding: const EdgeInsets.all(10),
            //             alignment: Alignment.center,
            //             child: RichText(
            //               text: TextSpan(
            //                 children: [
            //                   const TextSpan(
            //                     text: 'You donated \$',
            //                     style: TextStyle(
            //                       fontSize: 20.0,
            //                       fontWeight: FontWeight.bold,
            //                       color: Color(0xFF003049),
            //                     ),
            //                   ),
            //                   TextSpan(
            //                     text: ((onyaTransactions
            //                                 .elementAt(index)
            //                                 .amount) /
            //                             100)
            //                         .toString(),
            //                     style: TextStyle(
            //                       fontSize: 20.0,
            //                       fontWeight: FontWeight.bold,
            //                       color: Color(0xFF003049),
            //                     ),
            //                   ),
            //                   const TextSpan(
            //                     text: ' on ',
            //                     style: TextStyle(
            //                       fontSize: 20.0,
            //                       fontWeight: FontWeight.bold,
            //                       color: Color(0xFF003049),
            //                     ),
            //                   ),
            //                   TextSpan(
            //                     text: DateFormat.yMMMMd().format(
            //                         onyaTransactions
            //                             .elementAt(index)
            //                             .created
            //                             .toDate()),
            //                     style: TextStyle(
            //                       fontSize: 20.0,
            //                       fontWeight: FontWeight.bold,
            //                       color: Color(0xFF003049),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             decoration: BoxDecoration(
            //               boxShadow: [
            //                 BoxShadow(
            //                   color: Colors.grey.withOpacity(0.5),
            //                   spreadRadius: 1,
            //                   blurRadius: 1,
            //                   offset: const Offset(1, 1),
            //                 ),
            //               ],
            //               color: Colors.white,
            //               borderRadius: BorderRadius.circular(20),
            //               border: Border.all(
            //                 color: Color(0xFF003049),
            //                 width: 1,
            //               ),
            //             ),
            //           ),
            //           SizedBox(height: heightOfDevice / 50),
            //         ],
            //       );
            //     },
            //   ),
            // ),
            Container(
              height: heightOfDevice / 4.5,
              width: 370,
              child: ListView.builder(
                itemCount: onyaTransactions!.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TransactionWidget(
                        heightOfDevice: heightOfDevice,
                        transaction: onyaTransactions.elementAt(index),
                      ),
                      SizedBox(height: heightOfDevice / 50),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
