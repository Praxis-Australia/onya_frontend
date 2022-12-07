import 'package:flutter/material.dart';
import 'package:dashboardui/util/my_transaction_card.dart';
import 'package:dashboardui/pages/home_page.dart';
import 'package:dashboardui/functions/firebase_user_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

    Future<List<MyTransactionCard>> _getTransactions(id) async {
        Future<Map<String, dynamic>?> transactionList = FirebaseFunction.read('users', id);
        // transactions = (await transactionList)!['transaction'];
        return [MyTransactionCard(
            amount: '123.35',
            date:'11/12/2023',
            charityPref:'no')];
    }

    Widget _list() {
        return FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            //show progress bar if no data
            if (snapshot.connectionState == ConnectionState.none &&
                !snapshot.hasData) {
            return Text('None');
            }
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                return ListTile(
                    title: Card(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                children: [
                                    Text(snapshot.data[index].amount),
                                    Text(snapshot.data[index].date),
                                    Text(snapshot.data[index].charityPref),
                                ],
                            ),
                        )
                    )
                );
                },
            );
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
                        Container(
                            height:600,
                            child: _list(),
                        ),
                    ]
                ), // Row
            ),
        );
    }
}