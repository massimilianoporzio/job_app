import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../app/resources/color_manager.dart';
import '../../../../core/domain/entities/seniority_enitity.dart';
import '../../../../core/domain/enums/seniority.dart';

class FilterSeniorityChip extends StatefulWidget {
  const FilterSeniorityChip({
    Key? key,
    required this.seniority,
    required this.mode,
    required this.isActiveFromCubit,
  }) : super(key: key);

  final Seniority seniority;
  final ThemeMode mode;
  final bool isActiveFromCubit;

  @override
  State<FilterSeniorityChip> createState() => _FilterSeniorityChipState();
}

class _FilterSeniorityChipState extends State<FilterSeniorityChip> {
  late bool _isActive;
  @override
  void initState() {
    super.initState();
    _isActive = widget.isActiveFromCubit;
  }

  @override
  Widget build(BuildContext context) {
    late final Color cardColor;
    late final Color textColor;

    switch (widget.seniority) {
      case Seniority.junior:
        cardColor = widget.mode == ThemeMode.dark
            ? ColorManager.notionDarkGreen
            : ColorManager.notionLightGreen;
        textColor = widget.mode == ThemeMode.dark
            ? ColorManager.onNotionDark
            : ColorManager.onNotionLightGreen;
        break;
      case Seniority.mid:
        cardColor = widget.mode == ThemeMode.dark
            ? ColorManager.notionDarkYellow
            : ColorManager.notionLightYellow;
        textColor = widget.mode == ThemeMode.dark
            ? ColorManager.onNotionDark
            : ColorManager.onNotionLightYellow;
        break;
      case Seniority.senior:
        cardColor = widget.mode == ThemeMode.dark
            ? ColorManager.notionDarkRed
            : ColorManager.notionLightRed;
        textColor = widget.mode == ThemeMode.dark
            ? ColorManager.onNotionDark
            : ColorManager.onNotionLightRed;
        break;

      default:
        cardColor = Theme.of(context).colorScheme.primaryContainer;
        textColor = Theme.of(context).colorScheme.onPrimaryContainer;
    }
    return InkWell(
      onTap: () {
        setState(() {
          _isActive = !_isActive; //toogle state
        });
      },
      child: Card(
        color: _isActive ? cardColor : Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AutoSizeText(
            '${widget.seniority}',
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: _isActive ? textColor : Colors.black),
          ),
        ),
      ),
    );
  }
}
