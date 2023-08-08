import 'package:flutter/material.dart';
import 'package:onya_frontend/services/db.dart';
import 'package:provider/provider.dart';
import 'package:onya_frontend/models.dart';
import 'package:go_router/go_router.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GraphCard extends StatelessWidget {
  const GraphCard(
      {Key? key, typeOfGraph: 'totalDonations' // other option is byCharity
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

        num earliestCreated =
            sortedTransactions.first.created.millisecondsSinceEpoch / 86400000;

        num cumulativeAmount = 0;

        sortedTransactions.forEach((transaction) {
          cumulativeAmount += transaction.amount;
          num daysSinceEpoch =
              transaction.created.millisecondsSinceEpoch / 86400000;
          daysSinceEpoch -= earliestCreated;
          points.add(Point(daysSinceEpoch.toInt(),
              cumulativeAmount.toInt().toDouble() / 100));
        });

        seriesList.add(charts.Series<Point, int>(
          id: 'Transactions',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFF003049)),
          domainFn: (Point point, _) => point.x,
          measureFn: (Point point, _) => point.y,
          data: points,
        ));
      }

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: charts.LineChart(
            seriesList,
            animate: true,
            defaultRenderer: charts.LineRendererConfig(strokeWidthPx: 3),
            domainAxis: charts.NumericAxisSpec(
              renderSpec: charts.SmallTickRendererSpec(
                labelStyle: charts.TextStyleSpec(
                  fontSize: 16,
                  color: charts.ColorUtil.fromDartColor(Color(0xFF003049)),
                  fontWeight: 'bold',
                ),
                lineStyle: charts.LineStyleSpec(
                  color: charts.ColorUtil.fromDartColor(Color(0xFF003049)),
                  thickness: 2,
                ),
                tickLengthPx: 0, // to hide tick marks
              ),
            ),
            primaryMeasureAxis: charts.NumericAxisSpec(
              renderSpec: charts.SmallTickRendererSpec(
                labelStyle: charts.TextStyleSpec(
                  fontSize: 16,
                  color: charts.ColorUtil.fromDartColor(Color(0xFF003049)),
                  fontWeight: 'bold',
                ),
                lineStyle: charts.LineStyleSpec(
                  color: charts.ColorUtil.fromDartColor(Color(0xFF003049)),
                  thickness: 2,
                ),
                tickLengthPx: 0, // to hide tick marks
              ),
            ),
            behaviors: [
              charts.ChartTitle(
                'Days',
                behaviorPosition: charts.BehaviorPosition.bottom,
                titleStyleSpec: charts.TextStyleSpec(
                  fontSize: 18,
                  color: charts.ColorUtil.fromDartColor(Color(0xFF003049)),
                  fontWeight: 'bold',
                ),
                titleOutsideJustification:
                    charts.OutsideJustification.middleDrawArea,
              ),
            ],
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
  final double y;

  Point(this.x, this.y);
}
