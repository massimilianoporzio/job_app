import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../app/resources/color_manager.dart';
import '../../../../core/domain/enums/seniority.dart';

class FilterSeniorityChip extends StatelessWidget {
  const FilterSeniorityChip({
    Key? key,
    required this.seniority,
    required this.mode,
  }) : super(key: key);

  final Seniority seniority;
  final ThemeMode mode;

  @override
  Widget build(BuildContext context) {
    late final Color cardColor;
    late final Color textColor;

    switch (seniority) {
      case Seniority.junior:
        cardColor = mode == ThemeMode.dark
            ? ColorManager.notionDarkGreen
            : ColorManager.notionLightGreen;
        textColor = mode == ThemeMode.dark
            ? ColorManager.onNotionDark
            : ColorManager.onNotionLightGreen;
        break;
      case Seniority.mid:
        cardColor = mode == ThemeMode.dark
            ? ColorManager.notionDarkYellow
            : ColorManager.notionLightYellow;
        textColor = mode == ThemeMode.dark
            ? ColorManager.onNotionDark
            : ColorManager.onNotionLightYellow;
        break;
      case Seniority.senior:
        cardColor = mode == ThemeMode.dark
            ? ColorManager.notionDarkRed
            : ColorManager.notionLightRed;
        textColor = mode == ThemeMode.dark
            ? ColorManager.onNotionDark
            : ColorManager.onNotionLightRed;
        break;

      default:
        cardColor = Theme.of(context).colorScheme.primaryContainer;
        textColor = Theme.of(context).colorScheme.onPrimaryContainer;
    }
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: AutoSizeText(
          '$seniority',
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(fontWeight: FontWeight.w600, color: textColor),
        ),
      ),
    );
  }
}
