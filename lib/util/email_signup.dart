import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:onya_frontend/services/db.dart';
import 'package:provider/provider.dart';

class EmailSignup extends StatefulWidget {
  @override
  _EmailSignupState createState() => _EmailSignupState();
}

class _EmailSignupState extends State<EmailSignup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  bool _isSignUp = false;
  bool _sending_request = false;
  Exception? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final DatabaseService db = Provider.of<DatabaseService>(context);

    Future<void> _submitForm() async {
      setState(() => _sending_request = true);
      try {
        if (_formKey.currentState!.validate()) {
          String email = _emailController.text.trim();
          await db.addEmail(email);
          GoRouter.of(context).go('/');
        }
      } on Exception catch (e) {
        setState(() {
          _errorMessage = e;
          print(_errorMessage);
          print("there was an exception");
        });
      }
      setState(() => _sending_request = false);
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.center,
                    child: _sending_request
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff3D405B),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Submit'),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
