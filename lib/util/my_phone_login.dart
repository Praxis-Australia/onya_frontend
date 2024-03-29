import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onya_frontend/pages/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
//import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class MyPhoneLogin extends StatefulWidget {
  @override
  _MyPhoneLoginState createState() => _MyPhoneLoginState();
}

class _MyPhoneLoginState extends State<MyPhoneLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String phoneNumber = '';
  bool _otpSent = false;
  bool _sending_request = false;
  Exception? _errorMessage;
  late ConfirmationResult confirmationResult;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _login() async {
    // TODO: Add state change to show loading indicator
    setState(() => _sending_request = true);
    try {
      confirmationResult = await _auth.signInWithPhoneNumber(phoneNumber);
      setState(() {
        _otpSent = true;
      });
    } on FirebaseException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
    setState(() => _sending_request = false);
  }

  void _validate() async {
    setState(() => _sending_request = true);
    try {
      await confirmationResult.confirm(_otpController.text);
      context.go('/');
    } on Exception catch (e) {
      setState(() {
        _errorMessage = e;
        print(_errorMessage);
        print("there was an exception");
      });
    }
    setState(() => _sending_request = false);
  }

  @override
  Widget build(BuildContext context) {
    void onInputChanged(PhoneNumber number) {
      phoneNumber = number.phoneNumber!;
    }

    return Form(
        key: _formKey,
        child: Column(children: [
          Visibility(
              visible: !_otpSent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: const Text(
                          "Sign in or sign up with your phone number")),
                  InternationalPhoneNumberInput(
                    onInputChanged: onInputChanged,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                    initialValue: PhoneNumber(isoCode: 'AU'),
                    countries: const ["AU"],
                    // textFieldController: _mobileController,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.center,
                    child: _sending_request
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () async {
                              if (true) {
                                _login();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF003049),
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
                      child: _sending_request
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () async {
                                if (true) {
                                  _validate();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF003049),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Validate'),
                            ),
                    )
                  ])),
        ]));
  }
}
