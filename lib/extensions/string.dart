import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

extension RemovePrefix on String {
  String removePrefix(String prefix) {
    if (startsWith(prefix)) {
      return replaceFirst(prefix, "");
    }
    return this;
  }

  /// Makes a split using new line separator.
  /// This extension removes an empty string if the text ends with the new line.
  List<String> splitLines() {
    // Dart split makes an empty string if text ends with new line
    final lines = split("\n");
    if (lines.lastOrNull == "") {
      lines.removeLast();
    }
    return lines;
  }
}

extension IsExceedingLines on String {
  bool isExceedingLines({required BoxConstraints boxConstraints, required int maxLine, required TextStyle style}) {
    final span = TextSpan(text: this, style: style);
    final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout(maxWidth: boxConstraints.maxWidth);
    final numLines = tp.computeLineMetrics().length;
    return numLines > maxLine;
  }
}

extension FormatStringDate on String {
  String dateTodMMMyFormat(BuildContext context) {
    final date = DateTime.parse(this);

    var formattedString = DateFormat(context.text.dateFormat, context.text.localeName).format(date).replaceAll('.', "");
    return formattedString;
  }
}

extension FormatString on String {
  String formatString() {
    String str = substring(0, 1).toUpperCase() + substring(1);
    str = str.replaceAll(RegExp(r'[_-]'), ' ');

    return str;
  }
}
