import 'package:flutter/material.dart';
import 'package:onya_frontend/util/my_phone_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
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
                      children: [
                        Text(
                          'onya.',
                          style: TextStyle(
                            fontSize: 70.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff3D405B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  Center(
                    child: Container(
                      width: 300.0,
                      height: 200.0,
                      child: MyPhoneLogin(),
                    ),
                  ),
                  SizedBox(
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
