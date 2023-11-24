import 'dart:io';

import 'package:cifraclub/domain/section/use_cases/characters_per_line.dart';
import 'package:cifraclub/presentation/style/typography/font_families.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  bool isSetupDone = false;

  Future<void> loadFont() async {
    final fontData = File('assets/fonts/robotomono/RobotoMono-Regular.ttf')
        .readAsBytes()
        .then((bytes) => ByteData.view(Uint8List.fromList(bytes).buffer));

    final fontLoader = FontLoader(FontFamilies.robotoMono)..addFont(fontData);
    await fontLoader.load();
  }

  setUpAll(() async {
    if (!isSetupDone) {
      await loadFont();
      isSetupDone = true;
    }
  });

  test("When use case is called, should return numbers of characters possibles in 1 line", () async {
    // O resultado da largura de cada caracter é de aproximadamente 8.4
    final useCase = CharactersPerLine()(screenPadding: 0, screenWidth: 500, fontSize: 14);

    const expectedResult = 59; // 500 / 8.4 = 59.52
    expect(useCase, expectedResult);
  });

  test("When use case is called and have padding, should return numbers of characters possibles in 1 line", () async {
    // O resultado da largura de cada caracter é de aproximadamente 8.4
    final useCase = CharactersPerLine()(screenPadding: 20, screenWidth: 500, fontSize: 14);

    const expectedResult = 54; // (500 - 20 * 2) / 8.4 = 54.76
    expect(useCase, expectedResult);
  });
}
