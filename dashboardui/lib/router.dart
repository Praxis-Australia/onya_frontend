import 'package:firebase_auth/firebase_auth.dart';
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
import 'db.dart';

final GoRouter router = GoRouter(
    redirect: (context, state) async {
      final User? user = Provider.of<User?>(context, listen: false);
      final UserDoc? userDoc = Provider.of<UserDoc?>(context, listen: false);

      if (user == null) {
        return '/login';
      }

      if (userDoc != null && !userDoc.isRegComplete) {
        return '/login/complete-registration';
      }

      return null;
    },
    refreshListenable: UserChangeNotifier(),
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
