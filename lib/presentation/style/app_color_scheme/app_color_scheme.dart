// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppColorScheme extends ThemeExtension<AppColorScheme> {
  static AppColorScheme of(BuildContext context) {
    return Theme.of(context).extension<AppColorScheme>()!;
  }

  final Color screenCenterMessageColor;
  final Color genreHeaderDividerColor;
  const AppColorScheme({
    required this.screenCenterMessageColor,
    required this.genreHeaderDividerColor,
  });

  @override
  ThemeExtension<AppColorScheme> copyWith({Color? screenCenterMessageColor, Color? genreHeaderDividerColor}) {
    return AppColorScheme(screenCenterMessageColor: screenCenterMessageColor ?? this.screenCenterMessageColor, genreHeaderDividerColor: genreHeaderDividerColor ?? this.genreHeaderDividerColor);
  }

  @override
  ThemeExtension<AppColorScheme> lerp(ThemeExtension<AppColorScheme>? other, double t) {
    if (other is! AppColorScheme) {
      return this;
    }
    return AppColorScheme(
        screenCenterMessageColor: Color.lerp(screenCenterMessageColor, other.screenCenterMessageColor, t) ?? screenCenterMessageColor,
        genreHeaderDividerColor: Color.lerp(genreHeaderDividerColor, other.genreHeaderDividerColor, t) ?? genreHeaderDividerColor);
  }
}
