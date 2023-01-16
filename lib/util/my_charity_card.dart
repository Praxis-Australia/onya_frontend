import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onya_frontend/util/my_card.dart';

class MyCharityCard extends StatefulWidget {
  final String id;
  final String charityId;

  MyCharityCard({
    Key? key,
    required this.id,
    required this.charityId,
  }) : super(key: key);

  _MyCharityCardState createState() => _MyCharityCardState(id, charityId);
}

class _MyCharityCardState extends State<MyCharityCard> {
  String charityId;
  String id;
  double _currentSliderValue = -1;

  _MyCharityCardState(this.id, this.charityId) : super();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('users').doc(id).snapshots(),
        builder: (context, userSnapshot) {
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('charities')
                  .doc(charityId)
                  .snapshots(),
              builder: (context, charitySnapshot) {
                if (userSnapshot.hasData && charitySnapshot.hasData) {
                  if (_currentSliderValue == -1) {
                    if (userSnapshot.data!['charitySelection'][charityId] ==
                        null) {
                      _currentSliderValue = 0;
                    } else {
                      _currentSliderValue = userSnapshot
                          .data!['charitySelection'][charityId]
                          .toDouble();
                    }
                  }
                  return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: Container(
                          padding: EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 5),
                                  Text(charitySnapshot.data!['name'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(width: 5),
                                  Slider(
                                    value: _currentSliderValue,
                                    max: 100,
                                    divisions: 20,
                                    label:
                                        _currentSliderValue.round().toString(),
                                    onChanged: (double value) {
                                      setState(() {
                                        _currentSliderValue = value;
                                      });
                                    },
                                  ),
                                ]),
                            SizedBox(height: 5),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Spacer(),
                                  ElevatedButton(
                                    onPressed: () {
                                      var charityDict = userSnapshot
                                          .data!['charitySelection'];
                                      charityDict[charityId] =
                                          _currentSliderValue;
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(id)
                                          .update({
                                        'charitySelection': charityDict
                                      });
                                    },
                                    child: Text('Save'),
                                  )
                                ])
                          ])));
                } else {
                  return MyCard(
                    titleText: 'Loading',
                    amount: 'Loading',
                    color: Colors.white,
                  );
                }
              });
        });
  }
}
