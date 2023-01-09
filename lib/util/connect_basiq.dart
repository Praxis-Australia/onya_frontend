import 'package:flutter/material.dart';
import 'package:onya_frontend/services/db.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:onya_frontend/models.dart';

class ConnectBasiq extends StatelessWidget {
  const ConnectBasiq({Key? key}) : super(key: key);

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
      try {
        String accessToken = await db.getClientToken();
        String consentUrl = 'https://consent.basiq.io/home?token=$accessToken';
        String stateParam = '&state=Test';
        launchUrl(Uri.parse(consentUrl + stateParam));
      } catch (e) {
        print(e);
      }
    }

    return SizedBox(
        width: 300.0,
        height: 400.0,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Open the Button below to connect your bank"),
            ElevatedButton(
                onPressed: onPressConnect,
                child: const Text("Connect bank account")),
            const Text(
                "Once you've connected your bank account through the link, click the button below to continue"),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: onPressContinue,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue, // foreground
                ),
                child: const Text('Continue'),
              ),
            )
          ],
        ));
  }
}
