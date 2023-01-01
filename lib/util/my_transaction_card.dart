import 'package:flutter/material.dart';
import 'package:dashboardui/util/my_firebase_figure.dart';

class MyTransactionCard extends StatelessWidget {
    final String date;
    final String amount;
    final String charityPref;

    const MyTransactionCard(
        {Key? key, 
        required this.date,
        required this.amount,
        required this.charityPref,
    }
    ): super(key: key);

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal:25, vertical:5),
            child: Container(
                width: 300,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    SizedBox(height: 15),
                    Text(
                    date,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                    )
                    ),
                    SizedBox(height: 10),
                    Text("\$" + amount),
                ]
                )
            )
        );
  }
}