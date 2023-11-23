import 'package:cifraclub/presentation/style/typography/app_typography_scheme.dart';
import 'package:cifraclub/presentation/style/typography/font_families.dart';
import 'package:cosmos/cosmos.dart' show CosmosColorScheme;
import 'package:flutter/material.dart';

AppTypographyScheme getTypographyScheme(CosmosColorScheme cosmosColorScheme) {
  return AppTypographyScheme(
    /// Títulos
    title4: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.bold,
      fontFamily: FontFamilies.montserrat,
      fontSize: 24.0,
      height: 1.333,
      letterSpacing: 0,
    ),
    title5: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.bold,
      fontFamily: FontFamilies.montserrat,
      fontSize: 20.0,
      height: 1.2,
      letterSpacing: 0,
    ),
    title6: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.bold,
      fontFamily: FontFamilies.montserrat,
      fontSize: 16.0,
      height: 1.25,
      letterSpacing: 0,
    ),
    title7: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.bold,
      fontFamily: FontFamilies.montserrat,
      fontSize: 14.0,
      height: 1.4286,
      letterSpacing: 0,
    ),

    /// Subtítulos
    subtitle2: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.bold,
      fontSize: 16.0,
      height: 1.25,
      letterSpacing: 0,
    ),
    subtitle3: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.normal,
      fontSize: 16.0,
      height: 1.25,
      letterSpacing: 0,
    ),
    subtitle4: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.bold,
      fontSize: 14.0,
      height: 1.286,
      letterSpacing: 0,
    ),
    subtitle5: TextStyle(
      color: cosmosColorScheme.textSecondary,
      fontWeight: FontWeight.normal,
      fontSize: 14.0,
      height: 1.286,
      letterSpacing: 0,
    ),
    subtitle6: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.bold,
      fontSize: 12.0,
      height: 1.333,
      letterSpacing: 0,
    ),
    subtitle7: TextStyle(
      color: cosmosColorScheme.textSecondary,
      fontWeight: FontWeight.normal,
      fontSize: 12.0,
      height: 1.333,
      letterSpacing: 0,
    ),

    /// Corpo
    body5: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.bold,
      fontSize: 16.0,
      height: 1.5,
      letterSpacing: 0,
    ),
    body6: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.normal,
      fontSize: 16.0,
      height: 1.5,
      letterSpacing: 0,
    ),
    body7: TextStyle(
      color: cosmosColorScheme.textSecondary,
      fontWeight: FontWeight.bold,
      fontFamily: FontFamilies.robotoMono,
      fontSize: 14.0,
      height: 1.6,
      letterSpacing: 0,
    ),
    body8: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.normal,
      fontFamily: FontFamilies.robotoMono,
      fontSize: 14.0,
      height: 1.6,
      letterSpacing: 0,
    ),
    body9: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.bold,
      fontSize: 14.0,
      height: 1.5714,
      letterSpacing: 0,
    ),
    body10: TextStyle(
      color: cosmosColorScheme.textSecondary,
      fontWeight: FontWeight.normal,
      fontSize: 14.0,
      height: 1.5714,
      letterSpacing: 0,
    ),
    body11: TextStyle(
      color: cosmosColorScheme.textPrimary,
      fontWeight: FontWeight.bold,
      fontSize: 12.0,
      height: 1.5,
      letterSpacing: 0,
    ),
    body12: TextStyle(
      color: cosmosColorScheme.textSecondary,
      fontWeight: FontWeight.normal,
      fontSize: 12.0,
      height: 1.5,
      letterSpacing: 0,
    ),
  );
}
