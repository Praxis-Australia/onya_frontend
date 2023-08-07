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
  bool _sending_request = false;

  @override
  Widget build(BuildContext context) {
    final UserDoc? userDoc = Provider.of<UserDoc?>(context);
    final DatabaseService db = Provider.of<DatabaseService>(context);

    Future<void> onPressContinue() async {
      try {
        await db.checkBasiqConnections();
        context.go('/onboarding/roundups');
      } catch (e) {
        print(e);
      }
    }

    Future<void> onPressConnect() async {
      setState(() => _sending_request = true);
      try {
        String accessToken = await db.getClientToken();
        Uri consentUrl = Uri(
            scheme: 'https',
            host: 'consent.basiq.io',
            path: '/home',
            queryParameters: {
              'token': accessToken,
              'action': 'payment',
            });
        await launchUrl(consentUrl);
      } catch (e) {
        print(e);
      }
      setState(() => _sending_request = false);
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
              child: _sending_request
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: onPressConnect,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff3D405B),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Connect bank account"),
                    ),
            ),
            const Text(
                "Once you've connected your bank account through the link, click the button below to continue"),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: onPressContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff3D405B),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Continue'),
              ),
            )
          ],
        ));
  }
}
