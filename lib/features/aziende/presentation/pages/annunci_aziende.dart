import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/app/presentation/pages/widgets/search_bar.dart';
import 'package:job_app/core/presentation/widgets/error_dialog.dart';

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
          errorDialog(context, errorMsg: "ERRORE");
        }
      },
      builder: (context, state) {
        return BlocBuilder<AziendeCubit, AziendeState>(
          builder: (context, state) {
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
                          height: orientation == Orientation.landscape ? 8 : 0,
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
                          )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
