import 'package:flutter/material.dart';
import 'package:onya_frontend/services/db.dart';
import 'package:provider/provider.dart';
import 'package:onya_frontend/models.dart';
import 'package:go_router/go_router.dart';
import 'package:onya_frontend/functions/font_sizing_functions.dart';

// class GivingCard extends StatelessWidget {
//   final num index;

//   const GivingCard({Key? key,
//     this.index = 0})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final UserDoc? userDoc = Provider.of<UserDoc?>(context);
//     final DatabaseService db = Provider.of<DatabaseService>(context);

//     final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//     final String charity = userDoc!.donationMethods!['donationPreferences'][index]['charity'];
//     final String method = userDoc.donationMethods!['donationPreferences'][index]['method'];

//     return SizedBox(
//         width: 525.0,
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 // width: 525,
//                 decoration: BoxDecoration(
//                   color: Color(0xFF003049),
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 padding: EdgeInsets.all(16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: Text.rich(
//                         TextSpan(
//                           children: [
//                             TextSpan(text: 'Donating ', style: TextStyle(color: Colors.white)),
//                             TextSpan(
//                               text: '${userDoc!.donationMethods!['donationPreferences'][index]['method']}',
//                               style: TextStyle(decoration: TextDecoration.underline, decorationStyle: TextDecorationStyle.dotted, color: Colors.white),
//                             ),
//                             TextSpan(text: ' to ', style: TextStyle(color: Colors.white)),
//                             TextSpan(
//                               text: '${userDoc!.donationMethods!['donationPreferences'][index]['charity']}',
//                               style: TextStyle(decoration: TextDecoration.underline, decorationStyle: TextDecorationStyle.dotted, color: Colors.white),
//                             ),
//                           ],
//                         ),
//                         style: TextStyle(
//                           fontSize: 24.0,
//                           color: Color(0xFF3D405B),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: (
//                         // db remove the index of the donation preference
//                       ) {
//                         db.removeDonationPreference(charity, method);
//                         // Add your remove pledge functionality here
//                       },
//                       icon: Icon(
//                         Icons.close,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 10.0),
//             ],
//           ),
//         );
//   }
// }

class RoundupCard extends StatelessWidget {
  const RoundupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserDoc? userDoc = Provider.of<UserDoc?>(context);
    final DatabaseService db = Provider.of<DatabaseService>(context);
    final Map<String, Charity> charities =
        Provider.of<Map<String, Charity>>(context);

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final String charityId = userDoc!.charitySelection!.entries.first.key;
    final double roundToAmount = userDoc.donationMethods!['roundup']['roundTo'];
    final String method =
        "purchases rounded to the nearest \$${roundToAmount / 100}";

    double widthOfDevice = MediaQuery.of(context).size.width;
    double heightOfDevice = MediaQuery.of(context).size.height;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // width: 525,
            decoration: BoxDecoration(
              color: Color(0xFF003049),
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Donating ',
                            style: TextStyle(color: Colors.white)),
                        TextSpan(
                          text: '$method',
                          style: TextStyle(
                              // decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.dotted,
                              color: Colors.white),
                        ),
                        TextSpan(
                            text: ' to ',
                            style: TextStyle(color: Colors.white)),
                        TextSpan(
                          text: charities[charityId]?.displayName ?? '',
                          style: TextStyle(
                              // decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.dotted,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF3D405B),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await db.updateRoundupConfig(isEnabled: false);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

class GivingCardsList extends StatelessWidget {
  final double width;

  const GivingCardsList({Key? key, required this.width}) : super(key: key);

  double getHeight(num length, num heightOfDevice) {
    if (length == 0) {
      return 0;
    } else {
      return 200;
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserDoc? userDoc = Provider.of<UserDoc?>(context);
    double heightOfDevice = MediaQuery.of(context).size.height;

    List<Widget> givingCards = [];

    if (userDoc!.donationMethods!['roundup']['isEnabled']) {
      givingCards.add(const RoundupCard());
    }

    return Container(
        width: width,
        height: getHeight(givingCards.length, heightOfDevice),
        child: ListView.builder(
          itemCount: givingCards.length,
          itemBuilder: (context, index) {
            return givingCards[index];
          },
        ));
  }
}
