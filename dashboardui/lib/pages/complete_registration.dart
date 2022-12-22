import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dashboardui/pages/home_page.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';

//import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class CompleteRegistrationPage extends StatefulWidget {
  @override
  CompleteRegistrationPageState createState() =>
      CompleteRegistrationPageState();
}

class CompleteRegistrationPageState extends State<CompleteRegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  bool _success = false;
  Exception? _errorMessage;
  User? user;

  final User? _user = FirebaseAuth.instance.currentUser;

  void _updateUser() async {
    var id = _user!.uid;
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(id);

    await userRef.update({
      "firstName": _firstNameController.text,
      "lastName": _lastNameController.text,
      "isRegComplete": true,
    });

    context.go('/');
  }

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
                  'complete signup.',
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
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _firstNameController,
                            decoration:
                                const InputDecoration(labelText: 'First Name'),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _lastNameController,
                            decoration:
                                const InputDecoration(labelText: 'Last Name'),
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
                                _updateUser();
                              },
                              child: const Text('Continue'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue, // background
                                onPrimary: Colors.white, // foreground
                              ),
                            ),
                          )
                        ]))),
          ),
          SizedBox(
            height: 00.0,
          ),
        ])));
  }
}
