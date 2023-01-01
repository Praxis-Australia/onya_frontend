import 'package:dashboardui/services/db.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

//import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class CompleteRegistrationPage extends StatefulWidget {
  const CompleteRegistrationPage({super.key});

  @override
  CompleteRegistrationPageState createState() =>
      CompleteRegistrationPageState();
}

class CompleteRegistrationPageState extends State<CompleteRegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final DatabaseService db = Provider.of<DatabaseService>(context);

    Future<void> onPress() async {
      try {
        await db.completeRegistration(
            _firstNameController.text, _lastNameController.text);
        context.go('/onboarding/basiq-setup');
      } catch (e) {
        print(e);
      }
    }

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
                              onPressed: onPress,
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
