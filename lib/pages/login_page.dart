import 'package:flutter/material.dart';
import 'package:onya_frontend/util/my_phone_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'login.',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              width: 300.0,
              height: 200.0,
              child: MyPhoneLogin(),
            ),
          ),
          SizedBox(
            height: 00.0,
          )
        ])));
  }
}
