import 'package:onya_frontend/util/connect_basiq.dart';
import 'package:flutter/material.dart';

class BasiqSetupPage extends StatefulWidget {
  const BasiqSetupPage({Key? key}) : super(key: key);

  @override
  BasiqSetupPageState createState() => BasiqSetupPageState();
}

class BasiqSetupPageState extends State<BasiqSetupPage> {
  @override
  Widget build(BuildContext context) {
    double heightOfPageContainer = MediaQuery.of(context).size.height;
    double widthOfPageContainer = MediaQuery.of(context).size.width;

    if (heightOfPageContainer > 900) {
      heightOfPageContainer = 900;
    }

    if (widthOfPageContainer > 450) {
      widthOfPageContainer = 450;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 226, 226),
      body: Center(
        child: Container(
          width: widthOfPageContainer,
          height: heightOfPageContainer,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              color: Color(0x4fF4F1DE),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Connect your bank',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff3D405B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Center(child: ConnectBasiq()),
                  const SizedBox(
                    height: 100.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
