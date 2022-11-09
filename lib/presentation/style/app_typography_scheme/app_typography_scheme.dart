import 'package:flutter/material.dart';

class AppTypographyScheme extends ThemeExtension<AppTypographyScheme> {
  static AppTypographyScheme of(BuildContext context) {
    return Theme.of(context).extension<AppTypographyScheme>()!;
  }

  final TextStyle exoticScreenAppBarStyle;

  const AppTypographyScheme({required this.exoticScreenAppBarStyle});

  @override
  ThemeExtension<AppTypographyScheme> copyWith({TextStyle? veryDifferentScreenTitle}) {
    return AppTypographyScheme(
      exoticScreenAppBarStyle: veryDifferentScreenTitle ?? exoticScreenAppBarStyle,
    );
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
    );
  }
}
