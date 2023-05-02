// coverage:ignore-file
import 'package:flutter/material.dart';

extension TextSize on TextStyle {
  Size getTextSize(
      {required BuildContext context,
      String text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
      int maxLines = 1,
      double maxWidth = double.infinity}) {
    final TextPainter textPainter = (TextPainter(
        text: TextSpan(text: text, style: this),
        maxLines: maxLines,
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: maxWidth));

    return textPainter.size;
  }
}
