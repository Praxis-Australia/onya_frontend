import 'package:flutter/material.dart';
import 'package:onya_frontend/services/db.dart';
import 'package:provider/provider.dart';
import 'package:onya_frontend/models.dart';
import 'package:go_router/go_router.dart';

class RoundupPreference extends StatelessWidget {
  final bool isOnboarding;
  const RoundupPreference({Key? key, this.isOnboarding = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserDoc? userDoc = Provider.of<UserDoc?>(context);
    final DatabaseService db = Provider.of<DatabaseService>(context);

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    if (userDoc == null) {
      return const Text("User must be logged in for this widget");
    }

    String? watchedAccountId =
        userDoc.donationMethods['roundup']['watchedAccountId'];
    String? debitAccountId =
        userDoc.donationMethods['roundup']['debitAccountId'];
    num? roundTo = userDoc.donationMethods['roundup']['roundTo'];
    bool isEnabled =
        (isOnboarding) ? true : userDoc.donationMethods['roundup']['isEnabled'];

    // print(userDoc!.basiq['availableAccounts'][0].runtimeType);
    List<DropdownMenuItem<String>>? accountDropdownItems = userDoc
        .basiq['availableAccounts']
        .map<DropdownMenuItem<String>>((dynamic account) =>
            DropdownMenuItem<String>(
                value: account['id'], child: Text(account['name'] ?? "N/A")))
        .toList();

    double widthOfDevice = MediaQuery.of(context).size.width;
    double heightOfDevice = MediaQuery.of(context).size.height;

    return SizedBox(
        width: widthOfDevice/1.2,
        height: heightOfDevice/3,
        child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Watched account',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xff3D405B),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Select an account to monitor for round-ups',
                    contentPadding: EdgeInsets.only(top:10, bottom: 10),
                      // hide label after chocie
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  value: userDoc.donationMethods['roundup']['watchedAccountId'],
                  onChanged: (String? accountId) =>
                      {watchedAccountId = accountId!},
                  items: accountDropdownItems,
                  validator: (String? value) {
                    if (value == null) {
                      return 'Please select an account';
                    }
                    return null;
                  },
                ),
                SizedBox(height: heightOfDevice/30),
                const Text(
                  'Debit account',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xff3D405B),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText:
                          'Select an account to debit from for donations',
                      contentPadding: EdgeInsets.only(top:10, bottom: 10),
                      // hide label after chocie
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    value: debitAccountId,
                    onChanged: (String? accountId) =>
                        {debitAccountId = accountId},
                    items: accountDropdownItems,
                    validator: (String? value) {
                      if (value == null) {
                        return 'Please select an account';
                      }
                      return null;
                    }),
                SizedBox(height: heightOfDevice/40),
                // Disable button if no FormFields has changed
                Center(child:ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      print("validated");
                      await db.updateRoundupConfig(false, debitAccountId!,
                          watchedAccountId!, 0);
                    }
                    if (isOnboarding) {
                      print("is onboarding");
                      context.go('/onboarding/methods');
                    }
                  },
                  // Style
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff3D405B),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    // add insets
                    padding: EdgeInsets.symmetric(
                        horizontal: widthOfDevice/20, vertical: heightOfDevice/40),
                  ),
                  child: Text(
                        "Save preferences",
                        style: TextStyle(
                          fontSize: 500*20.0/widthOfDevice,
                          color: Colors.white,
                        )),
                        
                ))
              ],
            )));
  }
}
