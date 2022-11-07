import 'package:flutter/material.dart';

class CifraClubTextStyle extends ThemeExtension<CifraClubTextStyle> {
  static CifraClubTextStyle of(BuildContext context) {
    return Theme.of(context).extension<CifraClubTextStyle>()!;
  }

  final TextStyle veryDifferentScreenTitleStyle;

  const CifraClubTextStyle({required this.veryDifferentScreenTitleStyle});

  @override
  ThemeExtension<CifraClubTextStyle> copyWith({TextStyle? veryDifferentScreenTitle}) {
    return CifraClubTextStyle(
      veryDifferentScreenTitleStyle: veryDifferentScreenTitle ?? this.veryDifferentScreenTitleStyle,
    );
  }

  @override
  ThemeExtension<CifraClubTextStyle> lerp(ThemeExtension<CifraClubTextStyle>? other, double t) {
    if (other is! CifraClubTextStyle) {
      return this;
    }
    return CifraClubTextStyle(
      veryDifferentScreenTitleStyle: veryDifferentScreenTitleStyle.copyWith(color: Color.lerp(veryDifferentScreenTitleStyle.color, other.veryDifferentScreenTitleStyle.color, t)),
    );
  }
}
