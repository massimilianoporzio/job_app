/// Chart import
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

var dataFullTime = [
  _ChartData('Full Time', 75),
];
var dataPartTime = [
  _ChartData('Part Time', 25),
];

class StatBarChart extends StatelessWidget {
  const StatBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        margin: const EdgeInsets.all(0),
        enableSideBySideSeriesPlacement: false,
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
          labelAlignment: LabelAlignment.center,
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Theme.of(context).colorScheme.onPrimary),
          axisLine: const AxisLine(width: 0),
          tickPosition: TickPosition.inside,
          majorTickLines: const MajorTickLines(width: 0),
          majorGridLines: const MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(isVisible: false),
        series: <ChartSeries<_ChartData, String>>[
          BarSeries<_ChartData, String>(
            // width: 1,
            dataSource: dataFullTime,
            color: Colors.red.shade700
                .harmonizeWith(Theme.of(context).colorScheme.primary),
            xValueMapper: (_ChartData data, _) => data.x,
            yValueMapper: (_ChartData data, _) => data.y,
          ),
          BarSeries<_ChartData, String>(
            // width: 1,
            dataSource: dataPartTime,
            color: Colors.amber
                .harmonizeWith(Theme.of(context).colorScheme.primary),
            xValueMapper: (_ChartData data, _) => data.x,
            yValueMapper: (_ChartData data, _) => data.y,
          )
        ]);
  }
}
