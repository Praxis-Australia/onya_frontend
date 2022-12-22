import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboardui/pages/complete_registration.dart';
import 'package:dashboardui/pages/give_page.dart';
import 'package:dashboardui/pages/methods_page.dart';
import 'package:dashboardui/pages/send_page.dart';
import 'package:dashboardui/pages/settings_page.dart';
import 'package:dashboardui/pages/statistics_page.dart';
import 'package:flutter/material.dart';

import 'package:dashboardui/pages/home_page.dart';
import 'package:dashboardui/pages/payments_page.dart';
import 'package:dashboardui/pages/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';

final GoRouter router = GoRouter(
    redirect: (context, state) async {
      // Redirect when logged out using FirebaseAuth.instance.authStateChanges()
      User? user = FirebaseAuth.instance.currentUser;
      // Get Firestore document for user
      if (user == null) {
        return '/login';
      }

      DocumentSnapshot _userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (_userDoc.exists) {
        final data = _userDoc.data() as Map<String, dynamic>;
        final bool isRegComplete = data['isRegComplete'];
        if (isRegComplete != true) {
          return '/login/complete-registration';
        }
      }

      return null;
    },
    routes: <RouteBase>[
      GoRoute(path: '/', builder: (context, state) => HomePage(), routes: <
          RouteBase>[
        GoRoute(
          path: 'login',
          builder: (context, state) => const LoginPage(),
          routes: <RouteBase>[
            GoRoute(
              path: 'complete-registration',
              builder: (context, state) => CompleteRegistrationPage(),
            ),
          ],
        ),
        GoRoute(path: 'give', builder: (context, state) => const GivePage()),
        GoRoute(path: 'send', builder: (context, state) => const SendPage()),
        GoRoute(
            path: 'payments',
            builder: ((context, state) => const PaymentsPage())),
        GoRoute(
            path: 'stats', builder: (context, state) => const StatisticsPage()),
        GoRoute(
            path: 'methods', builder: (context, state) => const MethodsPage()),
        GoRoute(
            path: 'settings', builder: (context, state) => const SettingsPage())
      ])
    ]);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Initialised app");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}

// Create a BLoC to handle the state of the app with Firebase User