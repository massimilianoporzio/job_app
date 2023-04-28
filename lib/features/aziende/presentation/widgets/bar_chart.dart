/// Chart import
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/app/resources/color_manager.dart';
import 'package:job_app/core/domain/enums/seniority.dart';
import 'package:job_app/features/aziende/presentation/cubit/annunci/aziende_cubit.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../app/presentation/cubit/dark_mode/dark_mode_cubit.dart';
import '../../../../core/domain/enums/contratto.dart';
import '../../../../core/domain/enums/team.dart';

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
          Map<String, int> conteggiSeniority = {
            "junior": 0,
            "mid": 0,
            "senior": 0
          };
          Map<String, int> conteggiTeam = {
            "inSede": 0,
            "ibrido": 0,
            "fullRemote": 0
          };
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
            } //fine conteggi su tipo contratto
            if (annuncio.seniority != null) {
              switch (annuncio.seniority!.seniority) {
                case Seniority.junior:
                  conteggiSeniority["junior"] =
                      conteggiSeniority["junior"]! + 1;
                  break;
                case Seniority.mid:
                  conteggiSeniority["mid"] = conteggiSeniority["mid"]! + 1;
                  break;
                case Seniority.senior:
                  conteggiSeniority["senior"] =
                      conteggiSeniority["senior"]! + 1;
                  break;
                default:
              }
            } //fine conteggio tipo seniority
            if (annuncio.team != null) {
              switch (annuncio.team!.team) {
                case Team.inSede:
                  conteggiTeam["inSede"] = conteggiTeam["inSede"]! + 1;
                  break;
                case Team.ibrido:
                  conteggiTeam["ibrido"] = conteggiTeam["ibrido"]! + 1;
                  break;
                case Team.fullRemote:
                  conteggiTeam["fullRemote"] = conteggiTeam["fullRemote"]! + 1;
                  break;
                default:
              }
            } //fine conteggio tipo Team
          }
          var dataFullTime = [
            _ChartData('Full Time', conteggiContratto["full time"]!.toDouble()),
          ];
          var dataPartTime = [
            _ChartData('Part Time', conteggiContratto["part time"]!.toDouble()),
          ];

          var dataJunior = [
            _ChartData('Junior', conteggiSeniority["junior"]!.toDouble()),
          ];
          var dataMid = [
            _ChartData('Mid', conteggiSeniority["mid"]!.toDouble()),
          ];

          var dataSenior = [
            _ChartData('Senior', conteggiSeniority["senior"]!.toDouble()),
          ];

          return BlocBuilder<DarkModeCubit, DarkModeState>(
            builder: (context, themeState) {
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
                      color: ColorManager.getBackgroundColorFromContratto(
                          Contratto.fullTime,
                          mode: themeState.mode,
                          context: context),
                      xValueMapper: (_ChartData data, _) => data.x,
                      yValueMapper: (_ChartData data, _) => data.y,
                    ),
                    BarSeries<_ChartData, String>(
                      // width: 1,
                      dataSource: dataPartTime,
                      color: ColorManager.getBackgroundColorFromContratto(
                          Contratto.partTime,
                          mode: themeState.mode,
                          context: context),
                      xValueMapper: (_ChartData data, _) => data.x,
                      yValueMapper: (_ChartData data, _) => data.y,
                    )
                  ]);
            },
          );
        }
      },
    );
  }
}
