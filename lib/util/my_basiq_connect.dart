import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onya_frontend/util/my_account_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class MyBasiqConnect extends StatelessWidget {
  final String id;

  const MyBasiqConnect({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('users').doc(id).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading");
          } else {
            var ids = snapshot.data!['basiq']['connectionIds'];
            print(ids);
            if (ids.length == 0) {
              return Column(children: [
                Text("No connections ID. Use this link "),
                InkWell(
                    child: new Text('Open linkey'),
                    onTap: () => launch(snapshot.data!['basiq']['consentLink']))
              ]);
            } else {
              var accountNames = snapshot.data!['basiq']['availableAccounts'];
              return ListView.builder(
                  // padding: const EdgeInsets.all(25),
                  itemCount: accountNames.length,
                  itemBuilder: (context, int index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                            width: 200,
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: MyAccountCard(
                              id: id,
                              accountName: accountNames[index],
                            )));
                  });
            }
          }
        });
  }
}
