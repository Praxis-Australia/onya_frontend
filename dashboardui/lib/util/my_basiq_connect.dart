import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dashboardui/util/my_account_card.dart';

class MyBasiqConnect extends StatelessWidget {
    final String id;

    const MyBasiqConnect({
        Key? key,
        required this.id,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').doc(id).snapshots(),
            builder: (context, snapshot) {
                if (!snapshot.hasData) {
                return Text("Loading");
                } else {
                  var uid = snapshot.data!['basiq']['uid'];
                  if (uid == null) {
                    return Text("No Basiq ID. Please contact us for a link.");
                  } else {
                    var accountNames = snapshot.data!['basiq']['availableAccounts'];
                    return ListView.builder(
                      // padding: const EdgeInsets.all(25),
                      itemCount : accountNames.length,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical:5),
                          child:Container(
                          width: 200,
                          padding: EdgeInsets.symmetric(horizontal:10.0),
                          child: MyAccountCard(
                            id: id,
                            accountName: accountNames[index],
                          )));
                      }
                    );
                  }
                }
            }
        );
    }
}