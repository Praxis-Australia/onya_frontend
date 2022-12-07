import 'package:flutter/material.dart';
import 'package:dashboardui/util/my_firebase_figure.dart';

class MyCard extends StatelessWidget {
    final MyFirebaseFigure amount;
    final String date;
    final String titleText;
    final color;

    const MyCard(
        {Key? key, 
        required this.titleText,
        required this.amount, 
        required this.date, 
        required this.color
    }
    ): super(key: key);

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal:25),
            child: Container(
                width: 300,
                padding: EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    SizedBox(height: 5),
                    Text(
                    titleText,
                    style: TextStyle(
                        color: Colors.white,
                    )
                    ),
                    SizedBox(height: 5),
                    amount,
                    SizedBox(height: 10),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Text(
                        'Date',
                        style: TextStyle(
                            color: Colors.white,
                        )
                        ),
                        Text(
                        date.toString(),
                        style: TextStyle(
                            color: Colors.white,
                        )
                        ),
                    ],
                    ),
                ]
                )
            )
        );
  }
}