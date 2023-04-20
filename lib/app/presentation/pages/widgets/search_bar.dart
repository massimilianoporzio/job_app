import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loggy/loggy.dart';

import '../../../../features/aziende/presentation/cubit/aziende_cubit.dart';

class MySearchBar extends StatelessWidget with UiLoggy {
  const MySearchBar({
    super.key,
  });

  Future<void> _refresh(BuildContext context) {
    context.read<AziendeCubit>().fetchAllAnnunci();
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0),

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
            hintText: "Ricerca annunci",
            hintStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 14,
            ),
            filled: false,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            prefixIcon: const Icon(Icons.search, size: 24),
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      loggy.debug("REFRESH!");
                      _refresh(context);
                    },
                    icon: const Icon(Icons.refresh, size: 24),
                  ),
                  const Icon(Icons.filter_alt_outlined, size: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
