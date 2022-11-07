import 'package:cifraclub/presentation/themes/cifraclub_colors.dart';
import 'package:flutter/material.dart';

ThemeData get cifraClubDarkTheme => ThemeData(
  scaffoldBackgroundColor: CifraClubColors.grey12,
  brightness: Brightness.dark,
  sliderTheme: SliderThemeData(
    trackHeight: 2,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6, disabledThumbRadius: 6),
    overlayShape: SliderComponentShape.noOverlay,
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(CifraClubColors.greyE0),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: CifraClubColors.grey12,
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: CifraClubColors.grey21,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: CifraClubColors.grey21,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: CifraClubColors.greyE0,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9.0),
      ),
      minimumSize: const Size.fromHeight(48.0),
    ),
  ),
);
