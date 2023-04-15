import 'dart:async';

import 'package:onya_frontend/pages/basiq_setup_page.dart';
import 'package:onya_frontend/pages/roundup_onboarding.dart';
import 'package:onya_frontend/pages/roundup_page.dart';
import 'package:onya_frontend/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:onya_frontend/pages/complete_registration.dart';
import 'package:onya_frontend/pages/give_page.dart';
import 'package:onya_frontend/pages/methods_page.dart';
import 'package:onya_frontend/pages/send_page.dart';
import 'package:onya_frontend/pages/settings_page.dart';
import 'package:onya_frontend/pages/statistics_page.dart';
import 'package:onya_frontend/pages/home_page.dart';
import 'package:onya_frontend/pages/payments_page.dart';
import 'package:onya_frontend/pages/login_page.dart';
import 'package:onya_frontend/pages/giving_page.dart';
import 'package:onya_frontend/pages/congrats_page.dart';
import 'package:onya_frontend/pages/pledges_page.dart';
import 'package:onya_frontend/pages/data_page.dart';


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
          GoRoute(
              path: 'payments',
              builder: ((context, state) => const PaymentsPage()),
              routes: <RouteBase>[
                GoRoute(
                    path: 'payments/:id',
                    builder: (context, state) => const PaymentsPage())
              ]),
          GoRoute(
              path: 'roundup',
              builder: (context, state) => const RoundupPage()),
          GoRoute(
              path: 'data',
              builder: (context, state) => const DataPage()),
          GoRoute(
              path: 'settings',
              builder: (context, state) => const SettingsPage()),
          GoRoute(
              path: 'pledges',
              builder: (context, state) => const PledgePage()),
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
          builder: (context, state) => const BasiqSetupPage(),
        ),
        GoRoute(
          path: 'roundups',
          builder: (context, state) => const RoundupOnboardingPage(),
        ),
        GoRoute(
          path: 'method',
          builder: (context, state) => const DonationPage(),
        ),
        GoRoute(
          path: 'congrats',
          builder: (context, state) => const CongratsPage(),
        )
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
