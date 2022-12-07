import 'package:flutter/material.dart';
import 'package:dashboardui/util/my_detailed_card.dart';
import 'package:dashboardui/pages/home_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
     @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[300],
            body: SafeArea(
                child: Column(
                    children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 25.0, right:25.0, top: 15.0),
                            child: Container(
                                        child: Row(
                                            children:[
                                                RotatedBox(
                                                    quarterTurns: 2,
                                                    child:Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.black,
                                                    ),
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                        Navigator.pop(context);
                                                    },
                                                    child:Text(
                                                        'home',
                                                        style: TextStyle(
                                                            fontSize: 30.0,
                                                            fontWeight: FontWeight.bold,
                                                        ),
                                                    ), // InkWell Text
                                                )
                                                
                                            ]
                                        )
                            ) 
                        ),
                        Text(
                            'This is the settings page.'
                        )
                    ]
                ), // Row
            ),
        );
    }
}