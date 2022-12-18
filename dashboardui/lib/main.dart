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

final GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
      redirect: (context, state) async {
        // Boolean async function to redirect to login page if user is not logged in
        final bool isUserLoggedIn = await FirebaseAuth.instance
            .authStateChanges()
            .map((User? user) => user != null)
            .first;
        if (!isUserLoggedIn) {
          return '/login';
        } else {
          return null;
        }
      },
      routes: <RouteBase>[
        GoRoute(path: 'login', builder: (context, state) => const LoginPage()),
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
