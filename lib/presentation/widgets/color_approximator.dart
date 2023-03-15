import 'dart:math';

import 'package:cifraclub/di/inherited_widget_dependencies.dart';
import 'package:flutter_color_models/flutter_color_models.dart';
import 'package:flutter/material.dart';
import 'package:quiver/collection.dart';

abstract class ColorApproximator {
  static const cacheSize = 4 * 1024; // 4K colors

  static ColorApproximator getDefaultImplementation({Map<Color, Color>? cache}) {
    return _ColorApproximator(cache: cache ?? LruMap<Color, Color>(maximumSize: cacheSize));
  }

  static ColorApproximator of(BuildContext context) {
    return InheritedDependenciesWidget.of(context).colorApproximator;
  }

  Color getNearestColor(BuildContext context, Color color);

  static const approximatorPalette = [
    Color(0xFFE95855),
    Color(0xFFDE3F79),
    Color(0xFF9F46B7),
    Color(0xFF7755BD),
    Color(0xFF5865B8),
    Color(0xFF429BE9),
    Color(0xFF2989CA),
    Color(0xFF29A69B),
    Color(0xFF68BB6C),
    Color(0xFF68BB6C),
    Color(0xFF71A43C),
    Color(0xFFADB448),
    Color(0xFFC2B54C),
    Color(0xFFF3B31B),
    Color(0xFFFB9E29),
    Color(0xFFF46D43),
    Color(0xFF8E7065),
    Color(0xFFAF9A93),
    Color(0xFF79919D),
    Color(0xFF6B769A),
  ];
}

class _ColorApproximator implements ColorApproximator {
  final Map<Color, Color> cache;
  List<LabColor> baseLabColor = [];
  Brightness? lastBrightness;

  _ColorApproximator({required this.cache});

  // Convert RGB color to L*a*b color
  LabColor getLabColor(Color color) {
    LabColor labColor = color.toLabColor();
    return labColor;
  }

  // A setup that converts a set of RGB colors to L*a*b and stores it for later use
  // Add the colors allowed in the cache
  void setupColors(List<Color> colors, Map<Color, Color> cache) {
    // In case user changes the brightness/themeMode, we need to clear the cache
    cache.clear();
    baseLabColor.clear();
    for (final color in colors) {
      baseLabColor.add(getLabColor(color));
      cache[color] = color;
    }
  }

  // Euclidean distance between two LAB colors
  double euclideanDistance(LabColor labColor, LabColor baseColor) {
    return sqrt(pow(labColor.lightness - baseColor.lightness, 2) +
        pow(labColor.a - baseColor.a, 2) +
        pow(labColor.b - baseColor.b, 2));
  }

  /*
  * Returns the closest color in the base set.
  * Comparisons are made of Euclidean distance in the L*a*b color space
  */

  @override
  Color getNearestColor(BuildContext context, Color color) {
    const allowedColors = ColorApproximator.approximatorPalette;

    if (baseLabColor.isEmpty) {
      setupColors(
        allowedColors,
        cache,
      );
    }

    final colorCache = cache[color];

    if (colorCache != null) {
      return colorCache;
    }

    // Convert color to lab
    LabColor labColor = getLabColor(color);

    // Get minimum distance
    LabColor minDistanceColor = baseLabColor[0];
    double minDistance = euclideanDistance(labColor, baseLabColor[0]);

    for (int i = 1; i < baseLabColor.length; i++) {
      LabColor allowedLabColor = baseLabColor[i];
      double distance = euclideanDistance(labColor, allowedLabColor);
      if (distance < minDistance) {
        minDistance = distance;
        minDistanceColor = allowedLabColor;
      }
    }

    final nearestColor = minDistanceColor.toColor();

    cache[color] = nearestColor;

    return nearestColor;
  }
}
