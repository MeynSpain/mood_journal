import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 2.0,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 0),
                    FlSpot(1, 1),
                    FlSpot(2, 1),
                    FlSpot(3, 2),
                    FlSpot(4, 4),
                  ],
                  color: Colors.red,
                  isCurved: true,
                  preventCurveOverShooting: true,
                ),
                LineChartBarData(
                  spots: [
                    FlSpot(0, 0),
                    FlSpot(1, 2),
                    FlSpot(2, 3),
                    FlSpot(2, 2),
                    FlSpot(4, 4),
                  ],
                  color: Colors.green,
                  isCurved: true,
                  preventCurveOverShooting: true,
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
