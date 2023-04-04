import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/app/presentation/cubit/dark_mode_cubit.dart';
import 'package:job_app/app/presentation/pages/widgets/bar_chart.dart';
import 'package:job_app/app/presentation/pages/widgets/card_clipper.dart';
import 'package:job_app/app/presentation/pages/widgets/card_painter.dart';
import 'package:job_app/app/resources/string_constants.dart';
import 'package:job_app/app/resources/styles_manager.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //ottengo le dimensioni del dispositivo:
    var mSize = MediaQuery.of(context).size;
    //salvo larghezza e altezza
    var mWidth = mSize.width; //Larghezza
    var mHeight = mSize.height; //Altezza

    var themeMode = context.watch<DarkModeCubit>().state.mode;

    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConsts.appbarTitle,
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () {
                context.read<DarkModeCubit>().toggleDarkMode();
              },
              icon: Icon(themeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.corporate_fare),
            label: StringConsts.bottomNavAziende,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: StringConsts.bottomNavBookmarked,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: StringConsts.bottomNavFreelancers,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  height: 0.08 * mHeight,
                  // color: Colors.amber,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: TextEditingController(),
                      obscureText: false,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onPrimary,
                            width: 1,
                          ),
                        ),
                        hintText: "Enter Text",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                        ),
                        filled: false,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        prefixIcon: const Icon(Icons.search, size: 24),
                        suffixIcon:
                            const Icon(Icons.filter_alt_outlined, size: 24),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 0.2 * mHeight,
                  // color: Colors.deepOrange,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          // height: 0.15 * mHeight,
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            // color: Theme.of(context).colorScheme.primary,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                      colors: [
                                        Theme.of(context).colorScheme.tertiary,
                                        Theme.of(context).colorScheme.primary,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight)),
                              child: Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 2, left: 10),
                                      child: Text(
                                        "Stats",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("10",
                                            style: StyleManager.getBoldStyle(
                                                fontSize: 48,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary)),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "annunci",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary),
                                            ),
                                            Text(
                                              "di assunzioni",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                        // color: Colors.green,
                                        height: 40,
                                        padding: const EdgeInsets.only(left: 8),
                                        child: const StatBarChart())
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          // color: Colors.yellow,
                          // height: 0.2 * mHeight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                height: 0.075 * mHeight,
                                width: 0.9 * mWidth,
                                child: Card(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer
                                        .harmonizeWith(Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("9",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                )),
                                        Text(
                                          "aziende",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                // height: 0.075 * mHeight,
                                width: 0.9 * mWidth,
                                child: Card(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer
                                      .withOpacity(0.75),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("4",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                )),
                                        Text(
                                          "annunci\nrecenti",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                        // color: Colors.deepPurple,
                        )),
              ],
            )),
      ),
    );
  }
}
