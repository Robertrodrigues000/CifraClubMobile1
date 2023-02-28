// coverage:ignore-file
import 'package:flutter/material.dart';

class AppColorScheme extends ThemeExtension<AppColorScheme> {
  static AppColorScheme of(BuildContext context) {
    return Theme.of(context).extension<AppColorScheme>()!;
  }

  final Color screenCenterMessageColor;
  final Color genreHeaderDividerColor;
  final Color filterCapsuleSelectedColor;
  final Color filterCapsuleUnselectedColor;
  final Color filterCapsuleSelectedBorderColor;
  final Color filterCapsuleUnselectedBorderColor;
  final Color bottomNavigationIndicatorColor;
  final Color bottomNavigationTopBorderColor;
  final Color homeLogInColor;
  const AppColorScheme({
    required this.screenCenterMessageColor,
    required this.genreHeaderDividerColor,
    required this.filterCapsuleSelectedColor,
    required this.filterCapsuleUnselectedColor,
    required this.filterCapsuleSelectedBorderColor,
    required this.filterCapsuleUnselectedBorderColor,
    required this.bottomNavigationIndicatorColor,
    required this.bottomNavigationTopBorderColor,
    required this.homeLogInColor,
  });

  @override
  ThemeExtension<AppColorScheme> copyWith({
    Color? screenCenterMessageColor,
    Color? genreHeaderDividerColor,
    Color? filterCapsuleSelectedColor,
    Color? filterCapsuleSelectedTextColor,
    Color? filterCapsuleUnselectedColor,
    Color? filterCapsuleSelectedBorderColor,
    Color? filterCapsuleUnselectedBorderColor,
    Color? bottomNavigationIndicatorColor,
    Color? bottomNavigationTopBorderColor,
    Color? homeLogInColor,
  }) {
    return AppColorScheme(
      screenCenterMessageColor: screenCenterMessageColor ?? this.screenCenterMessageColor,
      genreHeaderDividerColor: genreHeaderDividerColor ?? this.genreHeaderDividerColor,
      filterCapsuleSelectedColor: filterCapsuleSelectedColor ?? this.filterCapsuleSelectedColor,
      filterCapsuleUnselectedColor: filterCapsuleUnselectedColor ?? this.filterCapsuleUnselectedColor,
      filterCapsuleSelectedBorderColor: filterCapsuleSelectedBorderColor ?? this.filterCapsuleSelectedBorderColor,
      filterCapsuleUnselectedBorderColor: filterCapsuleUnselectedBorderColor ?? this.filterCapsuleUnselectedBorderColor,
      bottomNavigationIndicatorColor: bottomNavigationIndicatorColor ?? this.bottomNavigationIndicatorColor,
      bottomNavigationTopBorderColor: bottomNavigationTopBorderColor ?? this.bottomNavigationTopBorderColor,
      homeLogInColor: homeLogInColor ?? this.homeLogInColor,
    );
  }

  @override
  ThemeExtension<AppColorScheme> lerp(ThemeExtension<AppColorScheme>? other, double t) {
    if (other is! AppColorScheme) {
      return this;
    }
    return AppColorScheme(
      screenCenterMessageColor:
          Color.lerp(screenCenterMessageColor, other.screenCenterMessageColor, t) ?? screenCenterMessageColor,
      genreHeaderDividerColor:
          Color.lerp(genreHeaderDividerColor, other.genreHeaderDividerColor, t) ?? genreHeaderDividerColor,
      filterCapsuleSelectedColor:
          Color.lerp(filterCapsuleSelectedColor, other.filterCapsuleSelectedColor, t) ?? filterCapsuleSelectedColor,
      filterCapsuleUnselectedColor: Color.lerp(filterCapsuleUnselectedColor, other.filterCapsuleUnselectedColor, t) ??
          filterCapsuleUnselectedColor,
      filterCapsuleSelectedBorderColor:
          Color.lerp(filterCapsuleSelectedBorderColor, other.filterCapsuleSelectedBorderColor, t) ??
              filterCapsuleSelectedBorderColor,
      filterCapsuleUnselectedBorderColor:
          Color.lerp(filterCapsuleUnselectedBorderColor, other.filterCapsuleUnselectedBorderColor, t) ??
              filterCapsuleUnselectedBorderColor,
      bottomNavigationIndicatorColor:
          Color.lerp(bottomNavigationIndicatorColor, other.bottomNavigationIndicatorColor, t) ??
              bottomNavigationIndicatorColor,
      bottomNavigationTopBorderColor:
          Color.lerp(bottomNavigationTopBorderColor, other.bottomNavigationTopBorderColor, t) ??
              bottomNavigationTopBorderColor,
      homeLogInColor: Color.lerp(homeLogInColor, homeLogInColor, t) ?? homeLogInColor,
    );
  }
}
