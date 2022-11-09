import 'package:cifraclub/presentation/style/app_color_scheme/app_color_scheme_dark.dart';
import 'package:cifraclub/presentation/style/app_color_scheme/app_colors.dart';
import 'package:cifraclub/presentation/style/app_typography_scheme/app_dark_typography_style.dart';
import 'package:flutter/material.dart';

ThemeData get appDarkTheme => ThemeData(
  scaffoldBackgroundColor: AppColors.grey12,
  typography: Typography.material2018(), // [https://github.com/flutter/flutter/issues/89947#issuecomment-920508415]
  brightness: Brightness.dark,
  sliderTheme: SliderThemeData(
    trackHeight: 2,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6, disabledThumbRadius: 6),
    overlayShape: SliderComponentShape.noOverlay,
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(AppColors.greyE0),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.grey12,
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: AppColors.grey21,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.grey21,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.greyE0,
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
  extensions: const [appColorDarkScheme, appDarkTypographyStyle],
);
