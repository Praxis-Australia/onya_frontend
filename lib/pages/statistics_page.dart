import 'package:flutter/material.dart';
import 'package:dashboardui/util/my_detailed_card.dart';
import 'package:dashboardui/pages/home_page.dart';
import 'package:go_router/go_router.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
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
          Text('This is the statistics page.')
        ]), // Row
      ),
    );
  }
}
