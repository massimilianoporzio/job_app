/// Chart import
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/features/aziende/presentation/cubit/annunci/aziende_cubit.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/domain/enums/contratto.dart';

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

class StatBarChart extends StatelessWidget {
  const StatBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AziendeCubit, AziendeState>(
      builder: (context, state) {
        if (state.status != AziendeStateStatus.loaded) {
          return const SizedBox.shrink();
        } else {
          Map<String, int> conteggiContratto = {"part time": 0, "full time": 0};
          for (var annuncio in state.listaAnnunci) {
            if (annuncio.contratto != null) {
              if (annuncio.contratto!.contratto == Contratto.partTime) {
                conteggiContratto["part time"] =
                    conteggiContratto["part time"]! + 1;
              }
              if (annuncio.contratto!.contratto == Contratto.fullTime) {
                conteggiContratto["full time"] =
                    conteggiContratto["full time"]! + 1;
              }
            }
          }
          var dataFullTime = [
            _ChartData('Full Time', conteggiContratto["full time"]!.toDouble()),
          ];
          var dataPartTime = [
            _ChartData('Part Time', conteggiContratto["part time"]!.toDouble()),
          ];

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
      },
    );
  }
}
