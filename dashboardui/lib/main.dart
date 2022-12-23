import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboardui/db.dart';
import 'package:dashboardui/models.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Initialised app");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
        value: FirebaseAuth.instance.authStateChanges(),
        initialData: FirebaseAuth.instance.currentUser,
        child: Consumer<User?>(builder: (context, User? user, child) {
          // TODO: Clean up the conditional to remove repetition and prevent router from reading null UserDoc
          if (user == null) {
            return MaterialApp.router(
              routerConfig: router,
            );
          } else {
            return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .get(),
                builder:
                    (context, AsyncSnapshot<DocumentSnapshot> asyncSnapshot) {
                  if (asyncSnapshot.hasData) {
                    final DocumentSnapshot snapshot = asyncSnapshot.data!;

                    return StreamProvider<UserDoc?>.value(
                        value: _db.userStream(user.uid),
                        initialData: UserDoc.fromDocSnapshot(snapshot),
                        child: MaterialApp.router(
                          routerConfig: router,
                        ));
                  } else {
                    return const CircularProgressIndicator();
                  }
                });
          }
        }));
  }
}
