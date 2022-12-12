import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dashboardui/pages/home_page.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

//import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class MySignup extends StatefulWidget {
  @override
  _MySignupState createState() => _MySignupState();
}

class _MySignupState extends State<MySignup> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _firstNameController = TextEditingController();
    final TextEditingController _lastNameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    bool _success = false;
    String? _userEmail;
    String? _userID;
    Exception? _errorMessage;
    User? user;
    PhoneNumber? _number;
    User? _user;

    final FirebaseAuth _auth = FirebaseAuth.instance;

    String generateRandomString(int len) {
        var r = Random();
        return String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
    }

    Future<bool> _signup() async {
        _success = true;
        try {
            final User? user = (await 
            _auth.createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text,
            )
        ).user;
        } on Exception catch (e) {
            setState(() {
            _success = false;
            _errorMessage = e;
            print(e);
            user = null;
            print("there was an exception");
            });
        }

        // final User? user = (await _auth.createUserWithEmailAndPassword(
        //         email: _emailController.text,
        //         password: _passwordController.text,
        // )).user;
        return _success;
    }

    Future<User?> _login() async {
        _success = true;
        await
        _auth.signInWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
        );
        _auth.authStateChanges().listen((User? user) {
            if (user == null) {
                print('User is currently signed out!');
            } else {
                print('User is signed in!');
                _user = user;
                _writeUser();
            }
        });
    }

    void _writeUser() async {
        var id = _user!.uid;
        CollectionReference userRef = FirebaseFirestore.instance.collection('users');
        await userRef.doc(id).set({
            "firstName":_firstNameController.text,
            "lastName":_lastNameController.text,
            "email":_emailController.text,
            "mobile": _number!.phoneNumber,
            "basiq":{
                "accountNames":[],
                "availableAccounts":[],
                "connectionIds":[]
            },
            "charitySelection":{},
            "roundup":{
                "config":{
                    "debitAt":10,
                    "debitConnectionId":null,
                    "enabled":false,
                    "roundTo":1,
                    "transactionConnectionId":null
                },
                "nextDebit":{
                    "accAmount":0,
                    "lastChecked":DateTime.now(),
                },
                "statistics":{
                    "total":0
                },
                "transactions":[],
                "uid":id,
                "userCreated":DateTime.now()
            }
        });
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
        );
    }

    @override
    Widget build(BuildContext context) {
        return Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    TextFormField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(labelText: 'First Name'),
                        validator: (String? value) {
                            if (value!.isEmpty) {
                                return 'Please enter some text';
                            }
                            return null;
                        },
                    ),
                    TextFormField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(labelText: 'Last Name'),
                        validator: (String? value) {
                            if (value!.isEmpty) {
                                return 'Please enter some text';
                            }
                            return null;
                        },
                    ),
                    TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (String? value) {
                            if (value!.isEmpty) {
                                return 'Please enter some text';
                            }
                            return null;
                        },
                    ),
                    InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                            setState( () {
                                _number = number;
                            });
                        },
                        onInputValidated: (bool value) {
                            print(value);
                        },
                        selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: TextStyle(
                            color: Colors.black
                        ),
                        initialValue: PhoneNumber(isoCode: 'AU', phoneNumber: ''),
                        autoFocus: true,
                        textFieldController: _phoneController,
                        formatInput: false,
                        keyboardType:
                            TextInputType.numberWithOptions(signed: true, decimal: true),
                        onSaved: (PhoneNumber numb) {
                            setState( () {
                                _number = numb;
                            });
                        },
                    ),
                    TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(labelText: 
                            'Password'),
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
                                await _signup();
                                if (_success) {
                                    await _login();
                                };
                            },
                            child: const Text('Sign Up'),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue, // background
                                onPrimary: Colors.white, // foreground
                            ),
                            
                        ),
                    )
                ]
            )
        );
    }
}