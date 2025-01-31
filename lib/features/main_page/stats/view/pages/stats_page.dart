import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_journal/core/constants/stats_status.dart';
import 'package:mood_journal/features/main_page/stats/bloc/stats_bloc.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  final Color _stressColor = Colors.red;
  final Color _selfAssessmentColor = Colors.orange;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: BlocBuilder<StatsBloc, StatsState>(
          builder: (context, state) {
            return state.status == StatsStatus.success
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: 2.0,
                        child: LineChart(
                          LineChartData(
                              minY: 0,
                              maxY: 10,
                              titlesData: FlTitlesData(
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: false,
                                  ),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: false,
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 35,
                                    getTitlesWidget: (value, meta) {
                                      return Text('$value', style: theme.textTheme.bodyMedium,);
                                    }
                                  )
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Text('${value.toInt()}:00',
                                          style: theme.textTheme.bodyMedium);
                                    },
                                  ),
                                ),
                              ),
                              borderData: FlBorderData(
                                border: Border.all(color: theme.primaryColor),
                              ),
                              lineBarsData: [
                                LineChartBarData(
                                  spots:
                                      _getFlSpotsFromMap(state.stressLevelMap),
                                  color: _stressColor,
                                  isCurved: true,
                                  preventCurveOverShooting: true,
                                ),
                                LineChartBarData(
                                  spots: _getFlSpotsFromMap(
                                      state.selfAssessmentMap),
                                  color: _selfAssessmentColor,
                                  isCurved: true,
                                  preventCurveOverShooting: true,
                                ),
                              ]),
                        ),
                      ),

                      // Легенда
                      Padding(
                        padding: const EdgeInsets.only(left: 30, top: 20),
                        child: Row(
                          children: [
                            Container(
                              height: 10,
                              width: 20,
                              color: _stressColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Уровень стресса',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],

                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 30, top: 20),
                        child: Row(
                          children: [
                            Container(
                              height: 10,
                              width: 20,
                              color: _selfAssessmentColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Самооценка',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],

                        ),
                      ),
                    ],
                  )
                : Text('Данных для статистики не найдено');
          },
        ),
      ),
    );
  }

  List<FlSpot> _getFlSpotsFromMap(Map<int, double> map) {
    List<FlSpot> spots = [];
    map.forEach((key, value) {
      spots.add(FlSpot(key.toDouble(), value));
    });
    return spots;
  }
}
