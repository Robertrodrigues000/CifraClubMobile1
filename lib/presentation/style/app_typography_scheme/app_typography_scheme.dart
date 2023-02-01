// coverage:ignore-file
import 'package:flutter/material.dart';

class AppTypographyScheme extends ThemeExtension<AppTypographyScheme> {
  static AppTypographyScheme of(BuildContext context) {
    return Theme.of(context).extension<AppTypographyScheme>()!;
  }

  final TextStyle exoticScreenAppBarStyle;
  final TextStyle genreHeaderItemStyle;
  final TextStyle listTileTitleStyle;
  final TextStyle listTileLeadingStyle;
  final TextStyle filterCapsuleSelectedStyle;
  final TextStyle filterCapsuleUnselectedStyle;

  const AppTypographyScheme({
    required this.exoticScreenAppBarStyle,
    required this.genreHeaderItemStyle,
    required this.listTileTitleStyle,
    required this.listTileLeadingStyle,
    required this.filterCapsuleSelectedStyle,
    required this.filterCapsuleUnselectedStyle,
  });

  @override
  ThemeExtension<AppTypographyScheme> copyWith({
    TextStyle? exoticScreenAppBarStyle,
    TextStyle? genreHeaderItemStyle,
    TextStyle? listTileTitleStyle,
    TextStyle? listTileLeadingStyle,
    TextStyle? filterCapsuleSelectedStyle,
    TextStyle? filterCapsuleUnselectedStyle,
  }) {
    return AppTypographyScheme(
        exoticScreenAppBarStyle: exoticScreenAppBarStyle ?? this.exoticScreenAppBarStyle,
        genreHeaderItemStyle: genreHeaderItemStyle ?? this.genreHeaderItemStyle,
        listTileLeadingStyle: listTileLeadingStyle ?? this.listTileLeadingStyle,
        listTileTitleStyle: listTileTitleStyle ?? this.listTileTitleStyle,
        filterCapsuleSelectedStyle: filterCapsuleSelectedStyle ?? this.filterCapsuleSelectedStyle,
        filterCapsuleUnselectedStyle: filterCapsuleUnselectedStyle ?? this.filterCapsuleUnselectedStyle);
  }

  @override
  ThemeExtension<AppTypographyScheme> lerp(ThemeExtension<AppTypographyScheme>? other, double t) {
    if (other is! AppTypographyScheme) {
      return this;
    }
    return AppTypographyScheme(
        exoticScreenAppBarStyle: exoticScreenAppBarStyle.copyWith(
          color: Color.lerp(exoticScreenAppBarStyle.color, other.exoticScreenAppBarStyle.color, t),
        ),
        genreHeaderItemStyle: genreHeaderItemStyle.copyWith(color: Color.lerp(genreHeaderItemStyle.color, other.genreHeaderItemStyle.color, t)),
        listTileTitleStyle: listTileTitleStyle.copyWith(color: Color.lerp(listTileTitleStyle.color, other.listTileTitleStyle.color, t)),
        listTileLeadingStyle: listTileLeadingStyle.copyWith(
          color: Color.lerp(listTileLeadingStyle.color, other.listTileLeadingStyle.color, t),
        ),
        filterCapsuleSelectedStyle: filterCapsuleSelectedStyle.copyWith(
          color: Color.lerp(filterCapsuleSelectedStyle.color, other.filterCapsuleSelectedStyle.color, t),
        ),
        filterCapsuleUnselectedStyle: filterCapsuleUnselectedStyle.copyWith(color: Color.lerp(filterCapsuleUnselectedStyle.color, other.filterCapsuleUnselectedStyle.color, t)));
  }
}
