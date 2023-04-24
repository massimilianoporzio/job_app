import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/app/presentation/cubit/dark_mode/dark_mode_cubit.dart';
import 'package:job_app/core/domain/entities/seniority_enitity.dart';
import 'package:job_app/core/domain/enums/seniority.dart';
import 'package:job_app/core/utils/sound_utils.dart';
import 'package:job_app/features/aziende/domain/entities/aziende_filter.dart';
import 'package:job_app/features/aziende/presentation/cubit/annunci/aziende_cubit.dart';
import 'package:job_app/features/aziende/presentation/widgets/chips.dart';
import 'package:job_app/features/aziende/presentation/widgets/filter_chips.dart';
import 'package:loggy/loggy.dart';

import '../cubit/cubit/aziende_filter_cubit.dart';

class AziendeSearchBar extends StatefulWidget with UiLoggy {
  const AziendeSearchBar({
    super.key,
  });

  @override
  State<AziendeSearchBar> createState() => _AziendeSearchBarState();
}

class _AziendeSearchBarState extends State<AziendeSearchBar> with UiLoggy {
  late TextEditingController _searchController;
  Timer? _debounce;
  AziendeFilter? aziendeFilter;

  Future<void> _resetSearch(BuildContext context) {
    loggy.debug("...Riprendo la lista originaria...");
    return Future.value();
  }

  Future<void> _doSearch(BuildContext context) {
    loggy.debug("...TRIGGER SEARCH on Notion...");
    context.read<AziendeCubit>().fetchAnnunci(_searchController.text);
    return Future.value();
  }

  Future<void> _refresh(BuildContext context) {
    context.read<AziendeCubit>().reset();

    return Future.value();
  }

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0),
      height: orientation == Orientation.landscape ? 54 : 60,
      // color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TextField(
          onSubmitted: (value) {
            setState(() {});
            loggy.debug('utente ha scritto');
            if (_debounce?.isActive ?? false) _debounce?.cancel();
            _debounce = Timer(const Duration(milliseconds: 700), () {
              // do something with query
              loggy.debug('ora chiamo il cubit');

              if (_searchController.text.isEmpty) {
                //dammi lista originaria?
                _resetSearch(context);
              } else {
                _doSearch(context);
              }
            });
          },
          controller: _searchController,
          obscureText: false,
          textAlign: TextAlign.start,
          maxLines: 1,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: orientation == Orientation.landscape ? 12 : 14,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onPrimary,
                width: 1,
              ),
            ),
            hintText: "Ricerca annunci",
            hintStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                fontSize: 14,
                color: Theme.of(context).colorScheme.onBackground),
            filled: false,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            prefixIcon: Container(
              // color: Colors.amber,
              child: Icon(Icons.search,
                  size: orientation == Orientation.landscape ? 20 : 24),
            ),
            suffixIcon: SizedBox(
              width: 150,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: _searchController.text.isEmpty
                          ? null
                          : IconButton(
                              onPressed: () {
                                _searchController.clear();
                                // Call setState to update the UI
                                setState(() {});
                                // chiamo cubit per lista originaria?
                              },
                              icon: Icon(Icons.clear,
                                  size: orientation == Orientation.landscape
                                      ? 20
                                      : 24),
                            ),
                    ),
                    IconButton(
                      onPressed: () {
                        playSound(file: 'refresh.mp3');
                        _refresh(context);
                      },
                      icon: Icon(Icons.refresh,
                          size: orientation == Orientation.landscape ? 20 : 24),
                    ),
                    IconButton(onPressed: () async {
                      //USO quello che torna da bottomSheet
                      final result = await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                              color: Colors.amber,
                              height: MediaQuery.of(context).size.height,
                              child: BlocBuilder<DarkModeCubit, DarkModeState>(
                                builder: (context, themeState) {
                                  return BlocBuilder<AziendeFilterCubit,
                                      AziendeFilterState>(
                                    builder: (context, state) {
                                      return ListView(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              FilterChip(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                backgroundColor: Colors.green,
                                                selectedColor: Colors.green,
                                                selected:
                                                    state.juniorSeniorityFilter,
                                                label: Text(
                                                  "${Seniority.junior}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black),
                                                ),
                                                onSelected: (value) {
                                                  context
                                                      .read<
                                                          AziendeFilterCubit>()
                                                      .setJuniorSeniorityFilter(
                                                          value);
                                                },
                                              ),
                                            ],
                                          ),
                                          Center(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(state);
                                                },
                                                child: Text("submit")),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                              ));
                        },
                      );
                      // ).whenComplete(
                      //   () {},
                      // );
                      loggy.info("result is $result");
                    }, icon:
                        BlocBuilder<AziendeFilterCubit, AziendeFilterState>(
                      builder: (context, state) {
                        return Icon(
                            state.isEmpty
                                ? Icons.filter_alt_outlined
                                : Icons.filter_alt,
                            // color: Theme.of(context).colorScheme.error,
                            size:
                                orientation == Orientation.landscape ? 20 : 24);
                      },
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
