import 'package:cifraclub/presentation/style/app_color_scheme/app_colors.dart';
import 'package:cifraclub/presentation/style/app_typography_scheme/app_typography_scheme.dart';
import 'package:flutter/material.dart';

const appDarkTypographyStyle = AppTypographyScheme(
    exoticScreenAppBarStyle: TextStyle(
      color: Colors.red,
      backgroundColor: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 21.0,
    ),
    genreHeaderItemStyle: TextStyle(color: AppColors.grey50, fontSize: 16),
    listTileTitleStyle: TextStyle(color: AppColors.grey90, fontSize: 16),
    listTileLeadingStyle: TextStyle(color: AppColors.grey50, fontSize: 16, fontWeight: FontWeight.w300));
