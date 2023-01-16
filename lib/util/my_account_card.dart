import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onya_frontend/util/my_card.dart';

class MyAccountCard extends StatelessWidget {
  final String id;
  final String accountName;

  const MyAccountCard({
    Key? key,
    required this.id,
    required this.accountName,
  }) : super(key: key);

  bool isChecked(accountName, activatedAccounts) {
    return activatedAccounts.contains(accountName);
  }

  void changeAccountStatus(accountName, basiqDict, id) async {
    print("here");
    if (!isChecked(accountName, basiqDict['accountNames'])) {
      basiqDict['accountNames'].add(accountName);
      FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update({'basiq': basiqDict});
    } else {
      basiqDict['accountNames'].remove(accountName);
      FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update({'basiq': basiqDict});
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('users').doc(id).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return MyCard(
              titleText: accountName,
              amount: 'Loading',
              color: Colors.white,
            );
          } else {
            return Container(
                width: 300,
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 5),
                      Text(accountName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(width: 5),
                      Checkbox(
                        checkColor: Colors.white,
                        value: isChecked(accountName,
                            snapshot.data!['basiq']['accountNames']),
                        onChanged: (bool? value) {
                          changeAccountStatus(
                              accountName, snapshot.data!['basiq'], id);
                        },
                      )
                    ]));
          }
        });
  }
}
