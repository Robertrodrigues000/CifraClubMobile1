import 'dart:ui';

import 'package:cifraclub/presentation/style/typography/font_families.dart';
import 'package:injectable/injectable.dart';

@injectable
class CharactersPerLine {
  int call({required double screenWidth, required double screenPadding, required double fontSize}) {
    const text = 'a';

    final ParagraphBuilder paragraphBuilder = ParagraphBuilder(
      ParagraphStyle(
        fontFamily: FontFamilies.robotoMono,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      ),
    )..addText(text);

    final Paragraph paragraph = paragraphBuilder.build()..layout(const ParagraphConstraints(width: double.infinity));
    return ((screenWidth - screenPadding * 2) / paragraph.minIntrinsicWidth).floor();
  }
}
