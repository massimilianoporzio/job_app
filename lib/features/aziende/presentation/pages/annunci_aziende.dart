import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/app/presentation/pages/widgets/error_dialog.dart';
import 'package:job_app/app/presentation/pages/widgets/no_connection.dart';
import 'package:job_app/app/presentation/pages/widgets/search_bar.dart';
import 'package:job_app/core/domain/entities/typedefs.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../cubit/aziende_cubit.dart';
import '../widgets/horizontal_list_aziende.dart';
import '../widgets/horizontal_stats.dart';
import '../widgets/vertical_list_aziende.dart';
import '../widgets/vertical_stats.dart';

class AnnunciAziende extends StatelessWidget {
  const AnnunciAziende({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //ottengo le dimensioni del dispositivo:
    var mSize = MediaQuery.of(context).size;
    //salvo larghezza e altezza
    var mWidth = mSize.width; //Larghezza
    var mHeight = mSize.height; //Altezza
    return BlocConsumer<AziendeCubit, AziendeState>(
      listener: (context, state) {
        if (state is AziendeStateError) {
          showSnackbar(context: context, message: "Errore di connessione.");
        }
      },
      builder: (context, state) {
        return BlocBuilder<AziendeCubit, AziendeState>(
          builder: (context, state) {
            if (state is AziendeStateInitial) {
              return const SizedBox.shrink();
            } else if (state is AziendeStateError) {
              return Center(
                child: Text("OOPS!"),
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
              return OrientationBuilder(
                builder: (context, orientation) => SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      // color: Colors.lime,
                      height: double.infinity,
                      width: mWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        // mainAxisSize: MainAxisSize.max,

                        children: [
                          const MySearchBar(),
                          SizedBox(
                            height:
                                orientation == Orientation.landscape ? 8 : 0,
                          ),
                          SizedBox(
                            // color: Colors.red,
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  )
                              ],
                            ),
                          ),
                          if (orientation == Orientation.portrait)
                            VerticalList(
                              mHeigth: mHeight,
                              listaAnnunci: listaAnnunci,
                            )
                        ],
                      ),
                    ),
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
