import 'package:flutter/material.dart';
import 'package:onya_frontend/services/db.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:onya_frontend/models.dart';


class DonationPage extends StatefulWidget {
  const DonationPage({Key? key}) : super(key: key);

  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  String? _selectedCharity;
  String? _selectedMethod;
  // final UserDoc? userDoc = Provider.of<UserDoc?>(context);


  final List<String> _charities = ['Against Malaria', 'Future Fund'];
  final List<String> _methods = [
    '10% of my income',
    '1% of my income',
    'a round-up to the nearest dollar'
  ];

  @override
  Widget build(BuildContext context) {
    final DatabaseService db = Provider.of<DatabaseService>(context);
    final UserDoc? userDoc = Provider.of<UserDoc?>(context);
    return Scaffold(
      backgroundColor: Color(0x4FF4F1DE),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 500.0,
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
                  child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    // Add title text referencing the user's firstName
                    Text(
                      userDoc!.firstName! + "'s Pledge",
                      style:
                          TextStyle(fontSize: 25.0, color: Color(0xFF3D405B), fontWeight: FontWeight.bold),
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
                            items: _charities
                                .map((charity) => DropdownMenuItem(
                                      value: charity,
                                      child: Text(charity),
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
                            items: _methods
                                .map((method) => DropdownMenuItem(
                                      value: method,
                                      child: Text(method),
                                    ))
                                .toList(),
                            hint: Text('method'),
                          ),
                        ),
                      ],
                    ),
                  ]
                )),
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
                  :_selectedCharity == 'Against Malaria'
                      ? Column(
                          children: [
                            Text(
                              'Against Malaria Foundation',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3D405B),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'The Against Malaria Foundation (AMF) is one of the most effective charities in the world, according to GiveWell, an independent charity evaluator. AMF distributes insecticidal bed nets to protect people from malaria, a disease that kills over 400,000 people every year, mostly children under five years old. The organization has been consistently rated as one of the most cost-effective health charities, with each bed net distributed costing around 3.50. Donate to AMF and help save lives today!',
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
                              'Future Fund',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3D405B),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Future Fund is a charity that focuses on climate change and environmental conservation. They work to protect the planet by supporting initiatives that reduce greenhouse gas emissions, promote renewable energy, and protect natural habitats. Future Fund is considered one of the most effective climate charities, with a proven track record of success. By donating to Future Fund, you can help to protect the planet and ensure a sustainable future for generations to come.',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFF3D405B),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                ),
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
                  :_selectedMethod == '10% of my income'
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
                      children:[
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
                            await db.updateFromDonationCard(_selectedCharity!, _selectedMethod!);
                            context.go('/');
                          },
                          child: Text('Finish',
                              style: TextStyle(color: Colors.white,
                              fontSize: 20.0,
                              )),
                        ),
                      ]
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}