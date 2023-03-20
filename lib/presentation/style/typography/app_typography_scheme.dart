// coverage:ignore-file
import 'package:flutter/material.dart';

class AppTypographyScheme extends ThemeExtension<AppTypographyScheme> {
  static AppTypographyScheme of(BuildContext context) => Theme.of(context).extension<AppTypographyScheme>()!;

  final TextStyle title2;
  final TextStyle title3;
  final TextStyle title4;
  final TextStyle title5;
  final TextStyle subtitle2;
  final TextStyle subtitle3;
  final TextStyle subtitle4;
  final TextStyle subtitle5;
  final TextStyle subtitle6;
  final TextStyle subtitle7;
  final TextStyle body2;
  final TextStyle body3;
  final TextStyle body6;
  final TextStyle body9;
  final TextStyle body10;

  const AppTypographyScheme({
    required this.title2,
    required this.title3,
    required this.title4,
    required this.title5,
    required this.subtitle2,
    required this.subtitle3,
    required this.subtitle4,
    required this.subtitle5,
    required this.subtitle6,
    required this.subtitle7,
    required this.body2,
    required this.body3,
    required this.body6,
    required this.body9,
    required this.body10,
  });

  @override
  ThemeExtension<AppTypographyScheme> copyWith({
    TextStyle? title1,
    TextStyle? title2,
    TextStyle? title3,
    TextStyle? title4,
    TextStyle? title5,
    TextStyle? subtitle2,
    TextStyle? subtitle3,
    TextStyle? subtitle4,
    TextStyle? subtitle5,
    TextStyle? subtitle6,
    TextStyle? subtitle7,
    TextStyle? body2,
    TextStyle? body3,
    TextStyle? body6,
    TextStyle? body9,
    TextStyle? body10,
  }) {
    return AppTypographyScheme(
      title2: title2 ?? this.title2,
      title3: title3 ?? this.title3,
      title4: title4 ?? this.title4,
      title5: title5 ?? this.title5,
      subtitle2: subtitle2 ?? this.subtitle2,
      subtitle3: subtitle3 ?? this.subtitle3,
      subtitle4: subtitle4 ?? this.subtitle4,
      subtitle5: subtitle5 ?? this.subtitle5,
      subtitle6: subtitle6 ?? this.subtitle6,
      subtitle7: subtitle7 ?? this.subtitle7,
      body2: body2 ?? this.body2,
      body3: body3 ?? this.body3,
      body6: body6 ?? this.body6,
      body9: body9 ?? this.body9,
      body10: body10 ?? this.body10,
    );
  }

  @override
  ThemeExtension<AppTypographyScheme> lerp(ThemeExtension<AppTypographyScheme>? other, double t) {
    if (other is! AppTypographyScheme) {
      return this;
    }
    return AppTypographyScheme(
      title2: title2.copyWith(color: Color.lerp(title2.color, other.title2.color, t)),
      title3: title3.copyWith(color: Color.lerp(title3.color, other.title3.color, t)),
      title4: title4.copyWith(color: Color.lerp(title4.color, other.title4.color, t)),
      title5: title5.copyWith(color: Color.lerp(title5.color, other.title5.color, t)),
      subtitle2: subtitle2.copyWith(color: Color.lerp(subtitle2.color, other.subtitle2.color, t)),
      subtitle3: subtitle3.copyWith(color: Color.lerp(subtitle3.color, other.subtitle3.color, t)),
      subtitle4: subtitle4.copyWith(color: Color.lerp(subtitle4.color, other.subtitle4.color, t)),
      subtitle5: subtitle5.copyWith(color: Color.lerp(subtitle5.color, other.subtitle5.color, t)),
      subtitle6: subtitle6.copyWith(color: Color.lerp(subtitle6.color, other.subtitle6.color, t)),
      subtitle7: subtitle7.copyWith(color: Color.lerp(subtitle7.color, other.subtitle7.color, t)),
      body2: body2.copyWith(color: Color.lerp(body2.color, other.body2.color, t)),
      body3: body3.copyWith(color: Color.lerp(body3.color, other.body3.color, t)),
      body6: body6.copyWith(color: Color.lerp(body6.color, other.body6.color, t)),
      body9: body9.copyWith(color: Color.lerp(body9.color, other.body9.color, t)),
      body10: body10.copyWith(color: Color.lerp(body10.color, other.body10.color, t)),
    );
  }
}
