import 'package:flutter/material.dart';
import 'package:dashboardui/util/my_signup.dart';
// import 'package:dashboardui/pages/signupPage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
                                'signup.',
                                style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                ),
                            ), // Text
                            ],
                        ), // Row
                    ),
                    SizedBox(
                        height: 20.0,
                    ),
                    Center(
                        child: Container(
                            width: 300.0,
                            height: 400.0,
                            child: MySignup(),
                        ),
                    ),
                    SizedBox(
                        height:00.0,
                    ),
                ]
            )
        )
    );
  }
}