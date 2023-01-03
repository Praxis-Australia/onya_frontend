import 'dart:async';

import 'package:dashboardui/pages/basiq_config_page.dart';
import 'package:dashboardui/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:dashboardui/pages/complete_registration.dart';
import 'package:dashboardui/pages/give_page.dart';
import 'package:dashboardui/pages/methods_page.dart';
import 'package:dashboardui/pages/send_page.dart';
import 'package:dashboardui/pages/settings_page.dart';
import 'package:dashboardui/pages/statistics_page.dart';
import 'package:dashboardui/pages/home_page.dart';
import 'package:dashboardui/pages/payments_page.dart';
import 'package:dashboardui/pages/login_page.dart';

import 'models.dart';

final GoRouter router = GoRouter(
  redirect: (context, state) async {
    final User? user = Provider.of<User?>(context, listen: false);
    final UserDoc? userDoc = Provider.of<UserDoc?>(context, listen: false);

    if (user == null) {
      return '/login';
    }

    if (userDoc != null) {
      if (userDoc.firstName == null || userDoc.lastName == null) {
        return '/onboarding';
      }

      if (userDoc.basiq["configStatus"] == "BASIQ_USER_CREATED") {
        return '/onboarding/basiq-setup';
      }
    }

    return null;
  },
  refreshListenable: UserChangeNotifier(),
  routes: <RouteBase>[
    GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
        routes: <RouteBase>[
          GoRoute(path: 'give', builder: (context, state) => const GivePage()),
          GoRoute(path: 'send', builder: (context, state) => const SendPage()),
          GoRoute(
              path: 'payments',
              builder: ((context, state) => const PaymentsPage())),
          GoRoute(
              path: 'stats',
              builder: (context, state) => const StatisticsPage()),
          GoRoute(
              path: 'methods',
              builder: (context, state) => const MethodsPage()),
          GoRoute(
              path: 'settings',
              builder: (context, state) => const SettingsPage())
        ]),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const CompleteRegistrationPage(),
      routes: <RouteBase>[
        GoRoute(
          path: 'basiq-setup',
          builder: (context, state) => BasiqSetupPage(),
        ),
      ],
    ),
  ],
  initialLocation: '/',
);

class UserChangeNotifier extends ChangeNotifier {
  UserChangeNotifier() {
    _user = _auth.currentUser;

    _authChangesSubscription = _auth.authChanges.listen((user) {
      _user = user;
      notifyListeners();
    });

    // if (_user != null) {
    //   _db = DatabaseService(uid: _user!.uid);
    //   _userChangesSubscription = _db.userStream().listen((user) {
    //     notifyListeners();
    //   });
    // }
  }

  late User? _user;
  final AuthService _auth = AuthService();
  // late final DatabaseService _db;
  late final StreamSubscription<User?> _authChangesSubscription;
  // late final StreamSubscription<UserDoc?> _userChangesSubscription;

  User? get user => _user;

  @override
  void dispose() {
    _authChangesSubscription.cancel();
    // _userChangesSubscription.cancel();
    super.dispose();
  }
}
