import 'package:auto_size_text/auto_size_text.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:job_app/core/domain/entities/typedefs.dart';
import 'package:job_app/features/freelancers/data/repositories/freelancers_repo_impl.dart';
import 'package:job_app/features/freelancers/domain/entities/annuncio_freelancer.dart';
import 'package:job_app/features/freelancers/domain/usecases/annunci_freelancer_params.dart';

import 'package:job_app/features/freelancers/presentation/cubit/annunci/freelancers_cubit.dart';
import 'package:job_app/features/freelancers/presentation/widgets/job_posted_freelancers.dart';

import 'package:loggy/loggy.dart';

import '../../../../app/presentation/cubit/dark_mode/dark_mode_cubit.dart';
import '../../../../app/presentation/widgets/right_loader.dart';
import '../../../../app/resources/color_manager.dart';

import '../../../../core/services/service_locator.dart';

import '../../domain/repositories/freelancers_repo.dart';
import 'annuncio_actions.dart';
import 'chips_freelancers.dart';

class HorizontalListFreelancers extends StatefulWidget {
  const HorizontalListFreelancers(
      {super.key,
      required this.mHeigth,
      required this.listaAnnunci,
      required this.params});
  final double mHeigth;
  final AnnuncioFreelancerList listaAnnunci;
  final AnnunciFreelancersParams params;

  @override
  State<HorizontalListFreelancers> createState() =>
      _HorizontalListFreelancersState();
}

class _HorizontalListFreelancersState extends State<HorizontalListFreelancers> {
  final ScrollController _scrollController = ScrollController();

  bool get _isRight {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll);
  }

  void _onScroll() {
    if (_isRight) {
      context
          .read<FreelancersCubit>()
          .refreshAnnunci(widget.params); //carico altri annunci
    }
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool hasMore =
        (sl<FreelancersRepository>() as FreelancersRepositoryImpl).hasMore;
    return Expanded(
        child: SizedBox(
      height: 0.45 * widget.mHeigth,
      // color: Colors.purple,
      child: ListView.builder(
        controller: _scrollController,
        // key: const PageStorageKey<String>("Aziende hor"),

        itemCount: hasMore
            ? widget.listaAnnunci.length + 1
            : widget.listaAnnunci.length, //+ 1 per il bottomLoader

        itemBuilder: (context, index) => SizedBox(
          // height: 140,
          child: Padding(
            padding: const EdgeInsets.only(left: 3, right: 3),
            child: SizedBox(
              width: 350,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                child: index >= widget.listaAnnunci.length
                    ? const RightLoader()
                    : CardFreelancersHor(
                        annuncio: widget.listaAnnunci[index],
                      ),
              ),
            ),
          ),
        ),
        scrollDirection: Axis.horizontal,
      ),
    ));
  }
}

class CardFreelancersHor extends StatelessWidget with UiLoggy {
  final AnnuncioFreelancers annuncio;
  const CardFreelancersHor({
    super.key,
    required this.annuncio,
  });

  @override
  Widget build(BuildContext context) {
    var serverParser = EmojiParser(init: true);
    var emoji = serverParser.get(annuncio.emoji);
    return InkWell(
      onTap: () {
        loggy.debug('tapped on annuncio: ${annuncio.id}');
        // Navigator.of(context).pushNamed(DettaglioAnnunciAziende.routeName,
        //     arguments: AnnuncioAziendeArguments(index.toString()));
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                ColorManager.notionLightPrimary
                    .harmonizeWith(
                        Theme.of(context).colorScheme.primaryContainer)
                    .withOpacity(0.2),
                Theme.of(context).colorScheme.errorContainer.withOpacity(0.2),
              ],
              begin: Alignment.topRight,
              end: Alignment.centerLeft,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        emoji.code,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Expanded(
                        child: AutoSizeText(annuncio.titolo,
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    fontSize: 12, fontWeight: FontWeight.w600)),
                      )
                    ],
                  ),
                ),

                AnnuncioActions(loggy: loggy, annuncio: annuncio),
                BlocBuilder<DarkModeCubit, DarkModeState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (annuncio.nda != null)
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: NDAChip(
                              ndaEntity: annuncio.nda!,
                              mode: state.mode,
                            ),
                          ),
                        if (annuncio.relazione != null)
                          RelazioneChip(
                            relazioneEntity: annuncio.relazione!,
                            mode: state.mode,
                          ),
                      ],
                    );
                  },
                ), //fine riga dei tag
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Text("job posted"), Text(annuncio.localita ?? "...")
                    JobPostedFreelancers(annuncio: annuncio),
                    // Text("prova")
                  ],
                ), //riga data e località
              ],
            ),
          ),
        ),
      ),
    );
  }
}
