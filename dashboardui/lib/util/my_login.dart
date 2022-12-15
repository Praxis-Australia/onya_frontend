import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dashboardui/pages/home_page.dart';
//import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _mobileController = TextEditingController();
    final TextEditingController _otpController = TextEditingController();
    bool _success = false;
    bool _otpSent = false;
    Exception? _errorMessage;
    ConfirmationResult? confirmationResult;

    final FirebaseAuth _auth = FirebaseAuth.instance;

    void _login() async {
        _success = true;
        
        ConfirmationResult? confirmationResult = await _auth.signInWithPhoneNumber(_mobileController.text);
        } on Exception catch (e) {
            setState(() {
            _errorMessage = e;
            print(e);
            print("there was an exception");
            });
        }

    }

    void _validate() async {
        try {
            if (confirmationResult != null) {
                await confirmationResult.confirm(_otpController.text);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                );
            }
        } on Exception catch (e) {
            setState(() {
            _errorMessage = e;
            print(e);
            print("there was an exception");
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        return Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Visibility(
                        visible: !_otpSent,
                        child: [
                            TextFormField(
                                controller: _mobileController,
                                decoration: const InputDecoration(labelText: 'Mobile Number'),
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
                                    child: const Text('Login'),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blue, // background
                                        onPrimary: Colors.white, // foreground
                                    ),
                                    
                                ),
                            )
                        ]
                    ),
                    Visibility(
                        visible: _otpSent,
                        child: [
                            TextFormField(
                                controller: _otpController,
                                decoration: const InputDecoration(labelText: 'One-Time Password'),
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
                                    child: const Text('Validate'),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blue, // background
                                        onPrimary: Colors.white, // foreground
                                    ),
                                    
                                ),
                            )
                        ]
                    ),
                ]
            )
        );
    }
}