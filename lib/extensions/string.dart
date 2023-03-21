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
