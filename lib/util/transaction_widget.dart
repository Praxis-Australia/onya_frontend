import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onya_frontend/models.dart';

class TransactionWidget extends StatelessWidget {
  final double heightOfDevice;
  final OnyaTransactionDoc transaction;

  TransactionWidget({
    required this.heightOfDevice,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightOfDevice / 10,
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: 'You donated \$',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003049),
              ),
            ),
            TextSpan(
              text: (transaction.amount / 100).toString(),
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003049),
              ),
            ),
            const TextSpan(
              text: ' on ',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003049),
              ),
            ),
            TextSpan(
              text: DateFormat.yMMMMd().format(transaction.created.toDate()),
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003049),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(1, 1),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xFF003049),
          width: 1,
        ),
      ),
    );
  }
}
