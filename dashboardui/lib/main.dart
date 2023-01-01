import 'package:cloud_functions/cloud_functions.dart';
import 'package:dashboardui/services/auth.dart';
import 'package:dashboardui/services/db.dart';
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

  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
        value: auth.authChanges,
        initialData: auth.currentUser,
        child: Consumer<User?>(builder: (context, User? user, child) {
          if (user == null) {
            return MaterialApp.router(
              routerConfig: router,
            );
          } else {
            final DatabaseService db = DatabaseService(uid: user.uid);

            return FutureBuilder(
                future: db.getUser(),
                builder: (context, AsyncSnapshot<UserDoc> asyncSnapshot) {
                  if (asyncSnapshot.hasData) {
                    final UserDoc snapshot = asyncSnapshot.data!;
                    return MultiProvider(
                        providers: [
                          StreamProvider<UserDoc?>.value(
                            value: db.userStream(),
                            initialData: snapshot,
                          ),
                          Provider<DatabaseService>.value(value: db),
                        ],
                        child: MaterialApp.router(
                          routerConfig: router,
                        ));
                  } else if (asyncSnapshot.hasError) {
                    return Text(asyncSnapshot.error.toString());
                  } else {
                    return const CircularProgressIndicator();
                  }
                });
          }
        }));
  }
}
