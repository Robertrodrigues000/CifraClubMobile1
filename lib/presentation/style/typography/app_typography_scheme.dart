// coverage:ignore-file
import 'package:flutter/material.dart';

class AppTypographyScheme extends ThemeExtension<AppTypographyScheme> {
  static AppTypographyScheme of(BuildContext context) => Theme.of(context).extension<AppTypographyScheme>()!;

  final TextStyle title4;
  final TextStyle title5;
  final TextStyle title6;
  final TextStyle title7;
  final TextStyle subtitle2;
  final TextStyle subtitle3;
  final TextStyle subtitle4;
  final TextStyle subtitle5;
  final TextStyle subtitle6;
  final TextStyle subtitle7;
  final TextStyle body5;
  final TextStyle body6;
  final TextStyle body7;
  final TextStyle body8;
  final TextStyle body9;
  final TextStyle body10;
  final TextStyle body11;
  final TextStyle body12;

  const AppTypographyScheme({
    required this.title4,
    required this.title5,
    required this.title6,
    required this.title7,
    required this.subtitle2,
    required this.subtitle3,
    required this.subtitle4,
    required this.subtitle5,
    required this.subtitle6,
    required this.subtitle7,
    required this.body5,
    required this.body6,
    required this.body7,
    required this.body8,
    required this.body9,
    required this.body10,
    required this.body11,
    required this.body12,
  });

  @override
  ThemeExtension<AppTypographyScheme> copyWith({
    TextStyle? title4,
    TextStyle? title5,
    TextStyle? title6,
    TextStyle? title7,
    TextStyle? subtitle2,
    TextStyle? subtitle3,
    TextStyle? subtitle4,
    TextStyle? subtitle5,
    TextStyle? subtitle6,
    TextStyle? subtitle7,
    TextStyle? body5,
    TextStyle? body6,
    TextStyle? body7,
    TextStyle? body8,
    TextStyle? body9,
    TextStyle? body10,
    TextStyle? body11,
    TextStyle? body12,
  }) {
    return AppTypographyScheme(
      title4: title4 ?? this.title4,
      title5: title5 ?? this.title5,
      title6: title6 ?? this.title6,
      title7: title7 ?? this.title7,
      subtitle2: subtitle2 ?? this.subtitle2,
      subtitle3: subtitle3 ?? this.subtitle3,
      subtitle4: subtitle4 ?? this.subtitle4,
      subtitle5: subtitle5 ?? this.subtitle5,
      subtitle6: subtitle6 ?? this.subtitle6,
      subtitle7: subtitle7 ?? this.subtitle7,
      body5: body5 ?? this.body5,
      body6: body6 ?? this.body6,
      body7: body7 ?? this.body7,
      body8: body8 ?? this.body8,
      body9: body9 ?? this.body9,
      body10: body10 ?? this.body10,
      body11: body11 ?? this.body11,
      body12: body12 ?? this.body12,
    );
  }

  @override
  ThemeExtension<AppTypographyScheme> lerp(ThemeExtension<AppTypographyScheme>? other, double t) {
    if (other is! AppTypographyScheme) {
      return this;
    }
    return AppTypographyScheme(
      title4: title4.copyWith(color: Color.lerp(title4.color, other.title4.color, t)),
      title5: title5.copyWith(color: Color.lerp(title5.color, other.title5.color, t)),
      title6: title6.copyWith(color: Color.lerp(title6.color, other.title6.color, t)),
      title7: title7.copyWith(color: Color.lerp(title7.color, other.title7.color, t)),
      subtitle2: subtitle2.copyWith(color: Color.lerp(subtitle2.color, other.subtitle2.color, t)),
      subtitle3: subtitle3.copyWith(color: Color.lerp(subtitle3.color, other.subtitle3.color, t)),
      subtitle4: subtitle4.copyWith(color: Color.lerp(subtitle4.color, other.subtitle4.color, t)),
      subtitle5: subtitle5.copyWith(color: Color.lerp(subtitle5.color, other.subtitle5.color, t)),
      subtitle6: subtitle6.copyWith(color: Color.lerp(subtitle6.color, other.subtitle6.color, t)),
      subtitle7: subtitle7.copyWith(color: Color.lerp(subtitle7.color, other.subtitle7.color, t)),
      body5: body5.copyWith(color: Color.lerp(body5.color, other.body5.color, t)),
      body6: body6.copyWith(color: Color.lerp(body6.color, other.body6.color, t)),
      body7: body7.copyWith(color: Color.lerp(body7.color, other.body7.color, t)),
      body8: body8.copyWith(color: Color.lerp(body8.color, other.body8.color, t)),
      body9: body9.copyWith(color: Color.lerp(body9.color, other.body9.color, t)),
      body10: body10.copyWith(color: Color.lerp(body10.color, other.body10.color, t)),
      body11: body11.copyWith(color: Color.lerp(body11.color, other.body11.color, t)),
      body12: body12.copyWith(color: Color.lerp(body12.color, other.body12.color, t)),
    );
  }
}
