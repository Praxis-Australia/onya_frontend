import 'package:flutter/material.dart';
import 'package:onya_frontend/services/db.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:onya_frontend/models.dart';


class CongratsPage extends StatefulWidget {
  const CongratsPage({Key? key}) : super(key: key);

  @override
  _CongratsPageState createState() => _CongratsPageState();
}

class _CongratsPageState extends State<CongratsPage> {
  String? _selectedCharity;
  String? _selectedMethod;

  @override
  Widget build(BuildContext context) {
    final DatabaseService db = Provider.of<DatabaseService>(context);
    final UserDoc? userDoc = Provider.of<UserDoc?>(context);
    return Scaffold(
      backgroundColor: Color(0x4FF4F1DE),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 500.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    'onya ' + userDoc!.firstName!,
                    style:
                        TextStyle(fontSize: 60.0, color: Color(0xFF3D405B)),
                  ),
                SizedBox(height: 16.0),
                Text(
                    "you're doing your bit!",
                    style:
                        TextStyle(fontSize: 24.0, color: Color(0xFF3D405B)),
                  ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    context.go('/');
                  },
                  child: Text(
                    'Continue to dashboard',
                    style: TextStyle(fontSize: 24.0, color: Colors.white),
                  ),
                  // Increase size of button around the text
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF3D405B),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0), // Increase padding for more space around the text
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}