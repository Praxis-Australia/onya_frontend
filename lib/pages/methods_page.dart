import 'package:flutter/material.dart';
import 'package:onya_frontend/util/my_detailed_card.dart';
import 'package:onya_frontend/pages/home_page.dart';
import 'package:onya_frontend/util/my_charity_card.dart';
import 'package:onya_frontend/functions/firebase_user_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class MethodsPage extends StatefulWidget {
  const MethodsPage({Key? key}) : super(key: key);

  @override
  _MethodsPageState createState() => _MethodsPageState();
}

class _MethodsPageState extends State<MethodsPage> {
  String id = "h";
  int index = 0;
  late User user;

  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    id = user.uid;
    print("id " + id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(children: [
          Padding(
              padding:
                  const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
              child: Container(
                  child: Row(children: [
                RotatedBox(
                  quarterTurns: 2,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: Text(
                    'home',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ), // InkWell Text
                )
              ]))),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('charities')
                  .snapshots(),
              builder: (context, snapshot) {
                print(snapshot);
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        DocumentSnapshot charity = snapshot.data!.docs[index];
                        return MyCharityCard(
                          charityId: charity.id,
                          id: id,
                        );
                      });
                }
                return MyCharityCard(
                  charityId: 'GRYsjKanNhabgHSSx65V',
                  id: id,
                );
              })
        ]), // Row
      ),
    );
  }
}
