import 'package:onya_frontend/services/db.dart';
import 'package:onya_frontend/util/connect_basiq.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final DatabaseService db = Provider.of<DatabaseService>(context);

    Future<void> onPress() async {
      try {
        await db.completeRegistration(_firstNameController.text,
            _lastNameController.text, _emailController.text);
        context.go('/onboarding/basiq-setup');
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
        backgroundColor: Color(0x4fF4F1DE),
        body: SafeArea(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'onya.',
                  style: TextStyle(
                    fontSize: 70.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3D405B),
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
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
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
                                primary: Color(0xff3D405B), // background
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
