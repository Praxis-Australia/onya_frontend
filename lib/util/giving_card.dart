import 'package:flutter/material.dart';
import 'package:onya_frontend/services/db.dart';
import 'package:provider/provider.dart';
import 'package:onya_frontend/models.dart';
import 'package:go_router/go_router.dart';

class GivingCard extends StatelessWidget {
  final num index;

  const GivingCard({Key? key, 
    this.index = 0})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    final UserDoc? userDoc = Provider.of<UserDoc?>(context);
    final DatabaseService db = Provider.of<DatabaseService>(context);

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final String charity = userDoc!.donationMethods!['donationPreferences'][index]['charity'];
    final String method = userDoc.donationMethods!['donationPreferences'][index]['method'];

    return SizedBox(
        width: 525.0,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // width: 525,
                decoration: BoxDecoration(
                  color: Color(0xFF003049),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 'Donating ', style: TextStyle(color: Colors.white)),
                            TextSpan(
                              text: '${userDoc!.donationMethods!['donationPreferences'][index]['method']}',
                              style: TextStyle(decoration: TextDecoration.underline, decorationStyle: TextDecorationStyle.dotted, color: Colors.white),
                            ),
                            TextSpan(text: ' to ', style: TextStyle(color: Colors.white)),
                            TextSpan(
                              text: '${userDoc!.donationMethods!['donationPreferences'][index]['charity']}',
                              style: TextStyle(decoration: TextDecoration.underline, decorationStyle: TextDecorationStyle.dotted, color: Colors.white),
                            ),
                          ],
                        ),
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Color(0xFF3D405B),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: (
                        // db remove the index of the donation preference
                      ) {
                        db.removeDonationPreference(charity, method);
                        // Add your remove pledge functionality here
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        );
  }
}