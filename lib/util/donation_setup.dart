import 'package:flutter/material.dart';
import 'package:onya_frontend/services/db.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:onya_frontend/models.dart';

class DonationSetup extends StatefulWidget {
  final void Function()? onDonationSetupComplete;
  const DonationSetup({Key? key, this.onDonationSetupComplete}) : super(key: key);

  @override
  _DonationSetupState createState() => _DonationSetupState();
}

class _DonationSetupState extends State<DonationSetup> {
  String? _selectedCharity;
  String? _selectedMethod;
  int? _selectedRoundupAmount;
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
        
    return Column(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'I want to donate to ',
                        style:
                            TextStyle(fontSize: 18.0, color: Color(0xFF3D405B)),
                      ),
                      SizedBox(width: 8.0),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 250.0),
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
                                    child: Text(entry.value.displayName),
                                  ))
                              .toList(),
                          hint: Text('charity'),
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
                        style:
                            TextStyle(fontSize: 18.0, color: Color(0xFF3D405B)),
                      ),
                      SizedBox(width: 8.0),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 350.0),
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
                                    'to the nearest ',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Color(0xFF3D405B)),
                                  ),
                                  SizedBox(width: 8.0),
                                  ConstrainedBox(
                                    constraints:
                                        BoxConstraints(maxWidth: 250.0),
                                    child: DropdownButtonFormField<int>(
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFE07A5F),
                                            width: 1.0,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
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
        Container(
            // decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(20.0),
            // color: Colors.white,
            // border: Border.all(
            //   color: Color(0xFF3D405B),
            //   width: 1.0,
            //   style: BorderStyle.solid,
            // ),
            // ),
            padding: EdgeInsets.all(5.0),
            child: _selectedCharity == null
                ? Container()
                : Column(
                    children: [
                      Text(
                        _charities[_selectedCharity]?.displayName ?? '',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3D405B),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        _charities[_selectedCharity]?.description ?? '',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFF3D405B),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
        SizedBox(height: 10.0),
        Container(
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: BorderRadius.circular(20.0),
          //   border: Border.all(
          //     color: Color(0xFF3D405B),
          //     width: 1.0,
          //     style: BorderStyle.solid,
          //   ),
          // ),
          padding: EdgeInsets.all(5.0),
          child: _selectedMethod == null
              ? Container()
              : _selectedMethod == '10% of my income'
                  ? Column(
                      children: [
                        Text(
                          '10% of my income',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3D405B),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'By selecting this method, you will donate 10% of your income to the chosen charity on a regular basis. This is a great way to ensure a consistent and meaningful contribution to the cause. Please ensure you have the necessary funds available to cover your donation commitment.',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF3D405B),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : _selectedMethod == '1% of my income'
                      ? Column(
                          children: [
                            Text(
                              '1% of my income',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3D405B),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'By selecting this method, you will donate 1% of your income to the chosen charity on a regular basis. This is a great way to ensure a consistent and meaningful contribution to the cause. Please ensure you have the necessary funds available to cover your donation commitment.',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFF3D405B),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Text(
                              'Round-up to nearest dollar',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3D405B),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'By selecting this method, your purchases will be rounded up to the nearest dollar and the difference will be donated to the chosen charity on a regular basis. This is a great way to donate without even noticing. Please ensure you have the necessary funds available to cover your donation commitment.',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFF3D405B),
                              ),
                            ),
                          ],
                        ),
        ),
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
                  await db.updateCharitySelection({_selectedCharity!: 100});

                  if (_selectedMethod == "round-up") {
                    await db.updateRoundupConfig(
                        isEnabled: true, roundTo: _selectedRoundupAmount);
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
    );
  }
}
