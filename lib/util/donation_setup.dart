import 'package:flutter/material.dart';
import 'package:onya_frontend/services/db.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:onya_frontend/models.dart';

class DonationSetup extends StatefulWidget {
  final void Function()? onDonationSetupComplete;
  const DonationSetup({Key? key, this.onDonationSetupComplete})
      : super(key: key);

  @override
  _DonationSetupState createState() => _DonationSetupState();
}

class _DonationSetupState extends State<DonationSetup> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCharity;
  String? _selectedMethod;
  int? _selectedRoundupAmount;
  String? _selectedWatchedAccount;
  // final UserDoc? userDoc = Provider.of<UserDoc?>(context);

  final Map<String, String> _methods = {
    // '10% of my income',
    // '1% of my income',
    'round-up': 'a round-up of my purchases'
  };

  final Map<int, String> _roundupAmounts = {
    100: '\$1',
    200: '\$2',
    500: '\$5',
  };

  @override
  Widget build(BuildContext context) {
    final DatabaseService db = Provider.of<DatabaseService>(context);
    final UserDoc? userDoc = Provider.of<UserDoc?>(context);
    final Map<String, Charity> _charities =
        Provider.of<Map<String, Charity>>(context);
    final double width = MediaQuery.of(context).size.width;

    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  // create an outline around the container
                  border: Border.all(
                    color: Color(0xFF3D405B),
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Add title text referencing the user's firstName
                      Text(
                        userDoc!.firstName! + "'s Pledge",
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Color(0xFF3D405B),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'I want to donate to ',
                            style: TextStyle(
                                fontSize: 18.0, color: Color(0xFF3D405B)),
                          ),
                          SizedBox(width: 8.0),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: width/2.5),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE07A5F),
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 5.0),
                              ),
                              value: _selectedCharity,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedCharity = value;
                                });
                              },
                              items: _charities.entries
                                  .map((entry) => DropdownMenuItem(
                                        value: entry.key,
                                        child: Text(entry.value.shortName),
                                      ))
                                  .toList(),
                              hint: Text('charity'),
                              validator: (value) => value == null
                                  ? 'Please select a charity'
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'with ',
                            style: TextStyle(
                                fontSize: 18.0, color: Color(0xFF3D405B)),
                          ),
                          SizedBox(width: 8.0),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: width/2),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE07A5F),
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 5.0),
                              ),
                              value: _selectedMethod,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedMethod = value;
                                });
                              },
                              items: _methods.entries
                                  .map((entry) => DropdownMenuItem(
                                        value: entry.key,
                                        child: Text(entry.value),
                                      ))
                                  .toList(),
                              hint: Text('method'),
                              validator: (value) => value == null
                                  ? 'Please select a donation method'
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      Column(
                          children: _selectedMethod != 'round-up'
                              ? []
                              : [
                                  SizedBox(height: 16.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'from ',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Color(0xFF3D405B)),
                                      ),
                                      SizedBox(width: 8.0),
                                      ConstrainedBox(
                                        constraints:
                                            BoxConstraints(maxWidth: width/1.5),
                                        child: DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFE07A5F),
                                                width: 1.0,
                                                style: BorderStyle.solid,
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 5.0),
                                          ),
                                          value: _selectedWatchedAccount,
                                          onChanged: (String? value) {
                                            setState(() {
                                              _selectedWatchedAccount = value;
                                            });
                                          },
                                          items: userDoc
                                              .basiq['availableAccounts']
                                              .map<DropdownMenuItem<String>>(
                                                  (dynamic account) =>
                                                      DropdownMenuItem<String>(
                                                          value: account['id'],
                                                          child: Text(
                                                              account['name'] ??
                                                                  "N/A")))
                                              .toList(),
                                          hint: Text(
                                              'connected account'),
                                          validator: (value) => value == null
                                              ? 'Please select a bank account you want to monitor for transactions'
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'to the nearest ',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Color(0xFF3D405B)),
                                      ),
                                      SizedBox(width: 8.0),
                                      ConstrainedBox(
                                        constraints:
                                            BoxConstraints(maxWidth: width/2.5),
                                        child: DropdownButtonFormField<int>(
                                      decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFE07A5F),
                                                width: 1.0,
                                                style: BorderStyle.solid,
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 5.0),
                                          ),
                                          value: _selectedRoundupAmount,
                                          onChanged: (int? value) {
                                            setState(() {
                                              _selectedRoundupAmount = value;
                                            });
                                          },
                                          items: _roundupAmounts.entries
                                              .map((entry) => DropdownMenuItem(
                                                    value: entry.key,
                                                    child: Text(entry.value),
                                                  ))
                                              .toList(),
                                          hint: Text('round-up amount'),
                                          validator: (value) => value == null
                                              ? 'Please select a round-up amount'
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ])
                    ])),
            SizedBox(height: 10.0),
            // This should be a container which updates depending on the
            // user's selection of cahrity choosing to display the charity's
            // information depending on the user's selection
            SizedBox(height: 10.0),
          
            SizedBox(height: 20.0),
            Row(
                // Add alignment to right hand side
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF3D405B),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      await db.updateCharitySelection({_selectedCharity!: 100});

                      if (_selectedMethod == "round-up") {
                        await db.updateRoundupConfig(
                            isEnabled: true, roundTo: _selectedRoundupAmount, watchedAccountId: _selectedWatchedAccount);
                      }

                      if (widget.onDonationSetupComplete != null) {
                        widget.onDonationSetupComplete!();
                      }
                      // context.go('/');
                    },
                    child: Text('Finish',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        )),
                  ),
                ]),
          ],
        ));
  }
}
