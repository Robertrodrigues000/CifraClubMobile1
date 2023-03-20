import 'package:cifraclub/presentation/style/typography/app_typography_scheme.dart';
import 'package:cifraclub/presentation/style/typography/font_families.dart';
import 'package:cosmos/cosmos.dart' show CosmosColorScheme;
import 'package:flutter/material.dart';

AppTypographyScheme getTypographyScheme(CosmosColorScheme cosmosColorScheme) {
  return AppTypographyScheme(
    /// Títulos
    title2: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.bold,
      fontFamily: FontFamilies.montserrat,
      fontSize: 24.0,
      height: 1.333,
    ),
    title3: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.bold,
      fontFamily: FontFamilies.montserrat,
      fontSize: 20.0,
      height: 1.2,
    ),
    title4: TextStyle(
      color: cosmosColorScheme.primary,
      fontWeight: FontWeight.bold,
      fontFamily: FontFamilies.montserrat,
      fontSize: 16.0,
      height: 1.25,
    ),
    title5: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.bold,
      fontFamily: FontFamilies.montserrat,
      fontSize: 18.0,
      height: 1.5,
    ),

    /// Subtítulos
    subtitle2: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.bold,
      fontSize: 16.0,
      height: 1.25,
    ),
    subtitle3: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.normal,
      fontSize: 16.0,
      height: 1.25,
    ),
    subtitle4: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.bold,
      fontSize: 14.0,
      height: 1.286,
    ),
    subtitle5: TextStyle(
      color: cosmosColorScheme.textSecondary,
      fontWeight: FontWeight.normal,
      fontSize: 14.0,
      height: 1.285,
    ),
    subtitle6: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.bold,
      fontSize: 12.0,
      height: 1.333,
    ),
    subtitle7: TextStyle(
      color: cosmosColorScheme.textSecondary,
      fontWeight: FontWeight.normal,
      fontSize: 12.0,
      height: 1.333,
    ),

    /// Corpo
    body2: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.normal,
      fontSize: 16.0,
      height: 1.5,
    ),
    body3: TextStyle(
      color: cosmosColorScheme.textSecondary,
      fontWeight: FontWeight.bold,
      fontSize: 14.0,
      height: 1.57,
    ),
    body6: TextStyle(
      color: cosmosColorScheme.textSecondary,
      fontWeight: FontWeight.normal,
      fontSize: 12.0,
      height: 1.5,
    ),
    body9: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.bold,
      fontSize: 14.0,
      height: 1.57,
    ),
    body10: TextStyle(
      color: cosmosColorScheme.textSecondary,
      fontWeight: FontWeight.normal,
      fontSize: 14.0,
      height: 1.57,
    ),
  );
}
