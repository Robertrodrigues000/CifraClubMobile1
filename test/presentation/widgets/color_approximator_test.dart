import 'package:cifraclub/presentation/widgets/color_approximator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_models/flutter_color_models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When request nearestColors should return nearest color of the palette", (tester) async {
    final colorApproximator = ColorApproximator.getDefaultImplementation();
    const color = Color(0xFFE53936);

    await tester.pumpWidget(
      TestWrapper(
        colorApproximator: colorApproximator,
        child: Container(),
      ),
    );
    final BuildContext context = tester.element(find.byType(Container));

    final approximateColor = colorApproximator.getNearestColor(context, color);

    expect(approximateColor, equals(const Color(0xFFE95855)));
  });

  testWidgets("When getNearestColor called, check if color is cached", (tester) async {
    final cache = <Color, Color>{};
    final colorApproximator = ColorApproximator.getDefaultImplementation(cache: cache);
    const color = Color(0xFFE53936);
    await tester.pumpWidget(
      TestWrapper(
        colorApproximator: colorApproximator,
        child: Container(),
      ),
    );
    final BuildContext context = tester.element(find.byType(Container));

    final approximateColor = colorApproximator.getNearestColor(context, color);

    expect(cache[color], equals(approximateColor));
  });

  testWidgets("Checks if any color can be normalized", (tester) async {
    final colorApproximator = ColorApproximator.getDefaultImplementation();

    await tester.pumpWidget(
      TestWrapper(
        colorApproximator: colorApproximator,
        child: Container(),
      ),
    );
    final BuildContext context = tester.element(find.byType(Container));

    Color color;
    Color colorRandom;

    const approximateColorPalette = ColorApproximator.approximatorPalette;
    for (int i = 0; i < 100; i++) {
      colorRandom =
          RgbColor.random(minBlue: 0, minGreen: 0, minRed: 0, maxBlue: 100, maxGreen: 100, maxRed: 100).toColor();
      color = colorApproximator.getNearestColor(context, colorRandom);
      expect(approximateColorPalette.contains(color), true);
    }
  });
}
