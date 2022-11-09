import 'package:flutter/material.dart';

class AppColorScheme extends ThemeExtension<AppColorScheme> {
  static AppColorScheme of(BuildContext context) {
    return Theme.of(context).extension<AppColorScheme>()!;
  }

  final Color screenCenterMessageColor;

  const AppColorScheme({required this.screenCenterMessageColor});

  @override
  ThemeExtension<AppColorScheme> copyWith({Color? screenCenterMessageColor}) {
    return AppColorScheme(screenCenterMessageColor: screenCenterMessageColor ?? this.screenCenterMessageColor);
  }

  @override
  ThemeExtension<AppColorScheme> lerp(ThemeExtension<AppColorScheme>? other, double t) {
    if (other is! AppColorScheme) {
      return this;
    }
    return AppColorScheme(
      screenCenterMessageColor: Color.lerp(screenCenterMessageColor, other.screenCenterMessageColor, t) ?? screenCenterMessageColor,
    );
  }
}
