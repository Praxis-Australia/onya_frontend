import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dashboardui/pages/home_page.dart';
//import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class MyPhoneLogin extends StatefulWidget {
  @override
  _MyPhoneLoginState createState() => _MyPhoneLoginState();
}

class _MyPhoneLoginState extends State<MyPhoneLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _otpSent = false;
  Exception? _errorMessage;
  late ConfirmationResult confirmationResult;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _login() async {
    try {
      confirmationResult =
          await _auth.signInWithPhoneNumber(_mobileController.text);
      setState(() {
        _otpSent = true;
      });
    } on Exception catch (e) {
      setState(() {
        _errorMessage = e;
        print(_errorMessage);
        print("there was an exception");
      });
    }
  }

  void _validate() async {
    try {
      await confirmationResult.confirm(_otpController.text);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on Exception catch (e) {
      setState(() {
        _errorMessage = e;
        print(_errorMessage);
        print("there was an exception");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          Visibility(
              visible: !_otpSent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _mobileController,
                    decoration:
                        const InputDecoration(labelText: 'Mobile Number'),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (true) {
                          _login();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Login'),
                    ),
                  )
                ],
              )),
          Visibility(
              visible: _otpSent,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _otpController,
                      decoration:
                          const InputDecoration(labelText: 'One-Time Password'),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter the OTP';
                        }
                        return null;
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (true) {
                            _validate();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Validate'),
                      ),
                    )
                  ])),
        ]));
  }
}
