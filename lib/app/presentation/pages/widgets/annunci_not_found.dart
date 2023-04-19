import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/app/presentation/pages/widgets/reusable_primary_button.dart';
import 'package:job_app/app/resources/string_constants.dart';

import '../../../../features/aziende/presentation/cubit/aziende_cubit.dart';
import '../../../resources/app_consts.dart';
import '../../cubit/navbar/navigation_cubit.dart';

class AnnunciNotFound extends StatelessWidget {
  const AnnunciNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              orientation == Orientation.landscape
                  ? 'assets/images/sfondi/article_not_found-hor.png'
                  : 'assets/images/sfondi/article_not_found.png',
              fit: BoxFit.fitWidth,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      orientation == Orientation.landscape
                          ? StringConsts.notHor
                          : StringConsts.not,
                      style: kTitleTextStyle,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 40),
                      child: Text(
                        StringConsts.found,
                        style: kTitleTextStyle,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Oops! Non sono stati trovati\nannunci.',
                  style: kSubtitleTextStyle.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                BlocBuilder<NavigationCubit, NavigationState>(
                  builder: (context, state) {
                    return ReusablePrimaryButton(
                      childText: StringConsts.tryAgain,
                      buttonColor: Colors.green.harmonizeWith(
                          Theme.of(context).colorScheme.background),
                      childTextColor:
                          Theme.of(context).colorScheme.onBackground,
                      onPressed: () {
                        int pageIndex = state.selectedIndex;
                        switch (pageIndex) {
                          case 0:
                            context.read<AziendeCubit>().fetchAllAnnunci();
                            break;
                          default:
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
