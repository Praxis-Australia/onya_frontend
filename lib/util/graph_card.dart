import 'package:flutter/material.dart';
import 'package:onya_frontend/services/db.dart';
import 'package:provider/provider.dart';
import 'package:onya_frontend/models.dart';
import 'package:go_router/go_router.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GraphCard extends StatelessWidget {
  const GraphCard({
    Key? key,
    typeOfGraph: 'totalDonations' // other option is byCharity
  
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserDoc? userDoc = Provider.of<UserDoc?>(context);
    final DatabaseService db = Provider.of<DatabaseService>(context);
    final Iterable<OnyaTransactionDoc>? onyaTransactions =
        Provider.of<Iterable<OnyaTransactionDoc>?>(context);
    
    String typeOfGraph = 'totalDonations';

    if (userDoc == null) {
      return const Text("User must be logged in for this widget");
    }

    if (typeOfGraph == 'totalDonations') {
      List<charts.Series<Point, int>> seriesList = [];

      if (onyaTransactions != null && onyaTransactions.isNotEmpty) {
        List<Point> points = [];
        List sortedTransactions = onyaTransactions.toList()
          ..sort((a, b) => a.created.compareTo(b.created));
        
        num earliestCreated = sortedTransactions.first.created.millisecondsSinceEpoch / 86400000;

        num cumulativeAmount = 0;

        sortedTransactions.forEach((transaction) {
          print(transaction.amount);
          cumulativeAmount += transaction.amount;
          print("Cumm amount" + cumulativeAmount.toString());
          // Convert transaction to days since epoch and round to nearest day making it an integer
          num daysSinceEpoch = transaction.created.millisecondsSinceEpoch / 86400000;
          daysSinceEpoch -= earliestCreated;
          points.add(Point(daysSinceEpoch.toInt(), cumulativeAmount.toInt()));
        });

        seriesList.add(charts.Series<Point, int>(
          id: 'Transactions',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFF003049)),
          domainFn: (Point point, _) => point.x,
          measureFn: (Point point, _) => point.y,
          data: points,
        ));
      }

      return SizedBox(
        width: 550.0,
        height: 350.0,
        child: Center(
          child: charts.LineChart(
            seriesList,
            animate: true,
            defaultRenderer: charts.LineRendererConfig(strokeWidthPx: 3),
            domainAxis: charts.NumericAxisSpec(
              tickProviderSpec: charts.BasicNumericTickProviderSpec(
                zeroBound: false,
                dataIsInWholeNumbers: true,
                
                // Make the axis thicker
              ),
            ),
            primaryMeasureAxis: charts.NumericAxisSpec(
              tickProviderSpec: charts.BasicNumericTickProviderSpec(
                zeroBound: false,
                dataIsInWholeNumbers: true,
              ),
            ),
            // add axis labels
            defaultInteractions: false,
            behaviors: [
              charts.ChartTitle(
                'Days since first transaction',
                behaviorPosition: charts.BehaviorPosition.bottom,
                titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
              ),
              charts.ChartTitle(
                'Total amount donated',
                behaviorPosition: charts.BehaviorPosition.start,
                titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                // Improve the style 
                titleStyleSpec: charts.TextStyleSpec(
                  fontSize: 18,
                  // Make the color consistent with 0xFF003049 and 0x4fF4F1DE
                  color: charts.ColorUtil.fromDartColor(Color(0xFF003049)),
                ),
              ),
            ]
          ),
        ),
      );
    } else {
      return const Text("No graph to display");
    }
  }
}

class Point {
  final int x;
  final int y;

  Point(this.x, this.y);
}