import 'package:flutter/material.dart';

import '../color_manager.dart';
import '../string_constants.dart';

enum Team {
  inSede(value: 0),
  ibrido(value: 1),
  fullRemote(value: 2);

  const Team({required this.value});

  final int value;

  Color getBackgroundColor(ThemeMode mode, String notionColor) {
    bool isDark = mode == ThemeMode.dark;
    ColorScheme colorScheme = isDark
        ? ColorManager.defaultDarkColorScheme
        : ColorManager.defaultLightColorScheme;
    switch (notionColor) {
      case StringConsts.notionBlue:
        return isDark
            ? ColorManager.notionDarkBlue
            : ColorManager.notionLightBlue;
      case StringConsts.notionYellow:
        return isDark
            ? ColorManager.notionDarkYellow
            : ColorManager.notionLightYellow;
      case StringConsts.notionRed:
        return isDark
            ? ColorManager.notionDarkRed
            : ColorManager.notionLightRed;
      case StringConsts.notionGreen:
        return isDark
            ? ColorManager.notionDarkGreen
            : ColorManager.notionLightGreen;
      case StringConsts.notionGrey:
        return isDark
            ? ColorManager.notionDarkGrey
            : ColorManager.notionLightGrey;
      case StringConsts.notionPurple:
        return isDark
            ? ColorManager.notionDarkPurple
            : ColorManager.notionLightPurple;
      default:
        return colorScheme.primary;
    }
  }

  Color getForegroundColor(ThemeMode mode, String notionColor) {
    bool isDark = mode == ThemeMode.dark;
    ColorScheme colorScheme = isDark
        ? ColorManager.defaultDarkColorScheme
        : ColorManager.defaultLightColorScheme;
    switch (notionColor) {
      case StringConsts.notionBlue:
        return isDark
            ? ColorManager.onNotionDark
            : ColorManager.onNotionLightBlue;
      case StringConsts.notionYellow:
        return isDark
            ? ColorManager.onNotionDark
            : ColorManager.onNotionLightYellow;
      case StringConsts.notionRed:
        return isDark
            ? ColorManager.onNotionDark
            : ColorManager.onNotionLightRed;
      case StringConsts.notionGreen:
        return isDark
            ? ColorManager.onNotionDark
            : ColorManager.onNotionLightGreen;
      case StringConsts.notionGrey:
        return isDark
            ? ColorManager.onNotionDark
            : ColorManager.onNotionLightGrey;
      case StringConsts.notionPurple:
        return isDark
            ? ColorManager.onNotionDark
            : ColorManager.onNotionLightPurple;
      default:
        return colorScheme.onPrimary;
    }
  }

  @override
  String toString() {
    super.toString();
    switch (this) {
      case Team.inSede:
        return StringConsts.teamInSede;
      case Team.ibrido:
        return StringConsts.teamIbrido;
      case Team.fullRemote:
        return StringConsts.teamFullRemote;
      default:
        return StringConsts.teamFullRemote;
    }
  }
}
