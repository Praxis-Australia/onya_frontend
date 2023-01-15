import 'package:onya_frontend/services/auth.dart';
import 'package:onya_frontend/services/db.dart';
import 'package:onya_frontend/models.dart';
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
                    return MaterialApp(
                      home: Scaffold(
                        body: Center(
                          child: Text("Error: ${asyncSnapshot.error}"),
                        ),
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                });
          }
        }));
  }
}
