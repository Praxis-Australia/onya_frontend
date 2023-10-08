import 'package:flutter/material.dart';
import 'package:onya_frontend/services/db.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:onya_frontend/models.dart';

class ConnectBasiq extends StatefulWidget {
  const ConnectBasiq({Key? key}) : super(key: key);

  @override
  _ConnectBasiqState createState() => _ConnectBasiqState();
}

class _ConnectBasiqState extends State<ConnectBasiq> {
  bool _sending_request_connect = false;
  bool _sending_request_continue =
      false; // Added another flag for continue button
  bool _hasFetchedToken = false;
  String? accessToken;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasFetchedToken) {
      _prepareAccessToken();
      _hasFetchedToken = true;
    }
  }

  Future<void> _prepareAccessToken() async {
    final DatabaseService db = Provider.of<DatabaseService>(context);
    setState(() => _sending_request_connect = true);

    try {
      accessToken = await db.getClientToken();
    } catch (e) {
      print("Failed to get token: $e");
    }

    setState(() => _sending_request_connect = false);
  }

  @override
  Widget build(BuildContext context) {
    final UserDoc? userDoc = Provider.of<UserDoc?>(context);
    final DatabaseService db = Provider.of<DatabaseService>(context);

    Future<void> onPressContinue() async {
      setState(() =>
          _sending_request_continue = true); // Set the flag true when pressed
      try {
        await db.checkBasiqConnections();
        context.go('/onboarding/methods');
      } catch (e) {
        print(e);
      }
      setState(() =>
          _sending_request_continue = false); // Reset the flag after operation
    }

    void onPressConnect() {
      // Before pressing the button, prepare the token and the URL
      Uri consentUrl;

      setState(() => _sending_request_connect = true);
      consentUrl = Uri(
        scheme: 'https',
        host: 'consent.basiq.io',
        path: '/home',
        queryParameters: {
          'token': accessToken,
          'action': 'payment',
        },
      );
      launchUrl(consentUrl);
      setState(() => _sending_request_connect = false);
    }

    return SizedBox(
        width: 300.0,
        height: 400.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Open the Button below to connect your bank"),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: _sending_request_connect
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: accessToken != null ? onPressConnect : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF003049),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Connect bank account"),
                    ),
            ),
            const Center(child: Text(// Wrapped text with Center
                "Once you've connected your bank account through the link, click the button below to continue")),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child:
                  _sending_request_continue // Check for the continue button's flag
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: onPressContinue,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF003049),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Continue'),
                        ),
            )
          ],
        ));
  }
}
