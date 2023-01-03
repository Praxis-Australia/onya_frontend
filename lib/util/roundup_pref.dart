import 'package:flutter/material.dart';
import 'package:dashboardui/services/db.dart';
import 'package:provider/provider.dart';
import 'package:dashboardui/models.dart';

class RoundupPreference extends StatelessWidget {
  const RoundupPreference({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserDoc? userDoc = Provider.of<UserDoc?>(context);
    final DatabaseService db = Provider.of<DatabaseService>(context);

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    if (userDoc == null) {
      return const Text("User must be logged in for this widget");
    }

    String? watchedAccountId = userDoc.roundup['config']['watchedAccountId'];
    String? debitAccountId = userDoc.roundup['config']['debitAccountId'];
    num? roundTo = userDoc.roundup['config']['roundTo'];
    bool isEnabled = userDoc.roundup['config']['isEnabled'];

    // print(userDoc!.basiq['availableAccounts'][0].runtimeType);
    List<DropdownMenuItem<String>>? accountDropdownItems = userDoc
        .basiq['availableAccounts']
        .map<DropdownMenuItem<String>>((dynamic account) =>
            DropdownMenuItem<String>(
                value: account['id'], child: Text(account['name'] ?? "N/A")))
        .toList();

    return SizedBox(
        width: 400.0,
        height: 550.0,
        child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enable round-ups',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                FormField(
                  initialValue: isEnabled,
                  builder: (FormFieldState<bool> field) {
                    return Switch(
                      value: field.value!,
                      onChanged: (val) {
                        field.didChange(val);
                        isEnabled = val;
                      },
                    );
                  },
                ),
                const Text(
                  'Watched account',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Select an account to monitor for round-ups',
                  ),
                  value: userDoc.roundup['config']['watchedAccountId'],
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
                const Text(
                  'Round-up amount',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                DropdownButtonFormField<num>(
                  decoration: const InputDecoration(
                    labelText: 'Round to nearest',
                  ),
                  value: userDoc.roundup['config']['roundTo'],
                  onChanged: (num? newAmount) => {roundTo = newAmount!},
                  items: const [
                    DropdownMenuItem(value: 1, child: Text('\$1')),
                    DropdownMenuItem(value: 2, child: Text('\$2')),
                    DropdownMenuItem(value: 5, child: Text('\$5')),
                  ],
                  validator: (num? value) {
                    if (value == null) {
                      return 'Please select an amount';
                    }
                    return null;
                  },
                ),
                const Text(
                  'Debit account',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText:
                          'Select an account to debit from for donations',
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
                const SizedBox(height: 20.0),
                // Disable button if no FormFields has changed
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await db.updateRoundupConfig(isEnabled, watchedAccountId!,
                          debitAccountId!, roundTo!);
                    }
                  },
                  child: const Text("Save preferences"),
                )
              ],
            )));
  }
}
