import 'package:cifraclub/presentation/style/app_color_scheme/app_colors.dart';
import 'package:cifraclub/presentation/style/app_typography_scheme/app_typography_scheme.dart';
import 'package:flutter/material.dart';

const appLightTypographyStyle = AppTypographyScheme(
  exoticScreenAppBarStyle: TextStyle(
    color: Colors.red,
    backgroundColor: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 21.0,
  ),
  genreHeaderItemStyle: TextStyle(color: AppColors.grey60, fontSize: 16),
  listTileTitleStyle: TextStyle(color: AppColors.grey20, fontSize: 16),
  listTileLeadingStyle: TextStyle(color: AppColors.grey60, fontSize: 16, fontWeight: FontWeight.w300),
  filterCapsuleSelectedStyle: TextStyle(
    color: AppColors.white,
    fontSize: 12,
  ),
  filterCapsuleUnselectedStyle: TextStyle(
    color: AppColors.grey40,
    fontSize: 12,
  ),
);
