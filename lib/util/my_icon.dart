import 'package:flutter/material.dart';
import 'package:onya_frontend/pages/payments_page.dart';
import 'package:onya_frontend/pages/home_page.dart';

class MyIcon extends StatelessWidget {
  final String icon;
  final Color color;
  final double size;
  final String textDescription;
  final VoidCallback onPress;

  const MyIcon({
    Key? key,
    required this.icon,
    required this.color,
    required this.size,
    required this.textDescription,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(
          onTap: onPress,
          child: Container(
              height: size,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400.withOpacity(0.5),
                    spreadRadius: 10,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Center(
                child: Image.asset(icon),
              ))),
      SizedBox(height: 10),
      Text(textDescription,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          )),
    ]);
  }
}
