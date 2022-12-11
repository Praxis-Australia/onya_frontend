import 'package:flutter/material.dart';
import 'package:dashboardui/util/my_transaction_card.dart';
import 'package:dashboardui/pages/home_page.dart';
import 'package:dashboardui/functions/firebase_user_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({Key? key}) : super(key: key);

  @override
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {

    String id = "h";
    int index = 0;
    late User user;
    
    void initState() {
      super.initState();
      user = FirebaseAuth.instance.currentUser!;
      id = user.uid;
      print(id);
    }

    DateTime fromTimestampToDateTime(Timestamp timestamp) {
        print(timestamp);
        return DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);
    }

    Future<List<MyTransactionCard>> _createTransactionList(transactions) async {
        List<String> amounts = [];
        List<String> postDates = [];

        List<MyTransactionCard> cards = [];

        for (var transaction in transactions) {
            await FirebaseFunction.read('transactions', transaction).then(
                (value) => {
                    if ((value!['post_date']) is String) {
                        value!['post_date'] = Timestamp.fromDate(DateFormat("dd/mm/yyyy hh:mm:ss").parse(value!['post_date']))
                    },
                    amounts.add(value!['amount'].toString()),
                    cards.add(MyTransactionCard(
                        amount: value!['amount'].toString(),
                        date: DateFormat('yyyy-MM-dd').format(fromTimestampToDateTime(value!['post_date'])),
                        charityPref: 'ello',
                    )),
                }
            );
        }
        
        // var amount = (await transaction)!['amount'];
        // var post_date = (await transaction)!['post_date'];
        return cards;
    }

    Future<List<MyTransactionCard>> _getTransactions(id) async {
        Future<Map<String, dynamic>?> transactionList = FirebaseFunction.read('users', id);
        var transactions = (await transactionList)!['transactions'];
        print(transactions);
        var detailedTransactionList = await _createTransactionList(await transactions);
        return detailedTransactionList;
    }

    Widget _list() {
        return FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            //show progress bar if no data
            print(snapshot);
            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData) {
                return new Padding(
                    padding: const EdgeInsets.only(top: 300.0),
                    child:CircularProgressIndicator(),
                );
            }
            return new Container(height:750, child:ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                return snapshot.data[index];
                },
            ));
        },
        future: _getTransactions(id),
        initialData: [],
        );
    }   

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[300],
            body: SafeArea(
                child: Column(
                    children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 25.0, right:25.0, top: 15.0),
                            child: Container(
                                        child: Row(
                                            children:[
                                                RotatedBox(
                                                    quarterTurns: 2,
                                                    child:Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.black,
                                                    ),
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                        Navigator.pop(context);
                                                    },
                                                    child:Text(
                                                        'home',
                                                        style: TextStyle(
                                                            fontSize: 30.0,
                                                            fontWeight: FontWeight.bold,
                                                        ),
                                                    ), // InkWell Text
                                                )
                                                
                                            ]
                                        )
                            ) 
                        ),
                        _list()
                    ]
                ), // Row
            ),
        );
    }
}