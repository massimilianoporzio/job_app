import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../../app/presentation/widgets/annunci_not_found.dart';
import '../../../../app/presentation/widgets/certain_error.dart';
import '../../../../app/presentation/widgets/no_connection.dart';
import '../../../../app/presentation/widgets/search_bar.dart';
import '../../../../core/domain/entities/typedefs.dart';
import '../cubit/aziende_cubit.dart';
import '../widgets/horizontal_list_aziende.dart';
import '../widgets/horizontal_stats.dart';
import '../widgets/vertical_list_aziende.dart';
import '../widgets/vertical_stats.dart';

class AnnunciAziende extends StatelessWidget {
  AnnunciAziende({
    super.key,
  }) {
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    //ottengo le dimensioni del dispositivo:
    var mSize = MediaQuery.of(context).size;
    //salvo larghezza e altezza
    var mWidth = mSize.width; //Larghezza
    var mHeight = mSize.height; //Altezza
    return BlocBuilder<AziendeCubit, AziendeState>(
      builder: (context, state) {
        return BlocBuilder<AziendeCubit, AziendeState>(
          builder: (context, state) {
            if (state is AziendeStateInitial) {
              return const SizedBox.shrink();
            } else if (state is AziendeStateError) {
              return CertainError(
                message: state.message,
              );
            } else if (state is AziendeStateNoConnection) {
              return const NoConnection();
            } else if (state is AziendeStateLoading) {
              return Center(
                  child: SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  spinnerMode: true,
                  customColors: CustomSliderColors(
                      dotColor: Colors.transparent,
                      trackColor: Colors.transparent,
                      dynamicGradient: true,
                      progressBarColors: [
                        Colors.black,
                        Colors.blueGrey.harmonizeWith(
                            Theme.of(context).colorScheme.background),
                      ]),
                ),
              ));
            } else {
              final AnnuncioList listaAnnunci =
                  (state as AziendeStateLoaded).listaAnnunci;

              if (listaAnnunci.isEmpty) {
                return const AnnunciNotFound();
              }
              return OrientationBuilder(
                builder: (context, orientation) => Container(
                  // color: Colors.lime,
                  child: Column(
                    children: [
                      const MySearchBar(),
                      SizedBox(
                        height: orientation == Orientation.landscape ? 8 : 0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (orientation == Orientation.portrait)
                            VerticalStats(
                              mWidth: mWidth,
                              mHeight: mHeight,
                            )
                          else
                            HorizontalStats(
                              mWidth: mWidth,
                              mHeigth: mHeight,
                            ),
                          if (orientation == Orientation.landscape)
                            HorizontalList(
                              mHeigth: mHeight,
                              listaAnnunci: listaAnnunci,
                            )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      if (orientation == Orientation.portrait)
                        VerticalList(
                          mHeigth: mHeight,
                          listaAnnunci: listaAnnunci,
                        )
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
