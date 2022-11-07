import 'package:cifraclub/presentation/themes/cifraclub_colors.dart';
import 'package:flutter/material.dart';

ThemeData get cifraClubLightTheme => ThemeData(
  scaffoldBackgroundColor: CifraClubColors.white,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: CifraClubColors.orange42,
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(CifraClubColors.grey42),
  ),
  sliderTheme: SliderThemeData(
    trackHeight: 2,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6, disabledThumbRadius: 6),
    overlayShape: SliderComponentShape.noOverlay,
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: CifraClubColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: CifraClubColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9.0),
      ),
      minimumSize: const Size.fromHeight(48.0),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      foregroundColor: CifraClubColors.grey75,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all<TextStyle?>(
        const TextStyle(
          color: CifraClubColors.white,
          fontSize: 14,
          height: 16.41 / 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      minimumSize: MaterialStateProperty.all<Size?>(const Size(0, 48)),
      backgroundColor: MaterialStateProperty.all<Color?>(CifraClubColors.green66),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
    ),
  ),
);
