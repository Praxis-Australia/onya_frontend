import 'package:flutter/material.dart';
import 'package:dashboardui/util/my_icon.dart';

class MyDetailedCard extends StatelessWidget {
    final String titleText;
    final String description;
    final color;
    final String iconPath;
    final double width;
    final VoidCallback onPress;

    const MyDetailedCard(
        {Key? key, 
        required this.titleText,
        required this.description, 
        required this.color,
        required this.iconPath,
        required this.width,
        required this.onPress,
    }
    ): super(key: key);

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal:25),
            child: InkWell(
                onTap: onPress,
                child:Container(
                    width: width,
                    padding: EdgeInsets.all(15.0),
                    // decoration: BoxDecoration(
                    //     color: color,
                    //     borderRadius: BorderRadius.circular(10),
                    // ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(40),
                                ),
                                height: 80,
                                width: 80,
                                padding: EdgeInsets.all(5),
                                child:Center(
                                child: Image.asset(iconPath),
                                )
                            ),
                            
                            SizedBox(width: 10,),

                            Column(
                                children: [
                                    Text(
                                        titleText,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.bold,
                                        )
                                    ),
                                    Text(
                                        description,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                        )
                                    ),
                                ]
                            ),

                            SizedBox(width: 20,),

                            Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,)
                        ]
                    )
                )
            )
        );
  }
}