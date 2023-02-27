import 'package:cifraclub/presentation/style/app_color_scheme/app_color_scheme_light.dart';
import 'package:cifraclub/presentation/style/app_color_scheme/app_colors.dart';
import 'package:cifraclub/presentation/style/app_typography_scheme/app_light_typography_style.dart';
import 'package:flutter/material.dart';

final appLightTheme = ThemeData(
  typography: Typography.material2018(), // [https://github.com/flutter/flutter/issues/89947#issuecomment-920508415]
  scaffoldBackgroundColor: AppColors.white,
  brightness: Brightness.light,
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.lightNeutralPrimary,
    surfaceTintColor: AppColors.lightNeutralSecondary,
    foregroundColor: AppColors.grey20,
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(AppColors.grey10),
  ),
  sliderTheme: SliderThemeData(
    trackHeight: 2,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6, disabledThumbRadius: 6),
    overlayShape: SliderComponentShape.noOverlay,
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: AppColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.white,
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
      foregroundColor: AppColors.grey10,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all<TextStyle?>(
        const TextStyle(
          color: AppColors.white,
          fontSize: 14,
          height: 16.41 / 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      minimumSize: MaterialStateProperty.all<Size?>(const Size(0, 48)),
      backgroundColor: MaterialStateProperty.all<Color?>(AppColors.grey10),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
    ),
  ),

  extensions: const [appColorLightScheme, appLightTypographyStyle],
);
