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
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    bool _success = false;
    String? _userEmail;
    String? _userID;
    Exception? _errorMessage;
    User? user;

    final FirebaseAuth _auth = FirebaseAuth.instance;

    void _login() async {
        _success = true;
        try {
            final User? user = (await 
            _auth.signInWithEmailAndPassword(
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

        if (_success) {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
            );
        } else {
            _success = false;
        }

        // await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
    }

    @override
    Widget build(BuildContext context) {
        return Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                if (true) {
                                    _login();
                                }
                            },
                            child: const Text('Submit'),
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