import 'package:cifraclub/domain/section/models/single_line_chords_section.dart';
import 'package:cifraclub/extensions/string.dart';

class MultiLineChordsSection extends SingleLineChordsSection {
  static const int minLineBreakAllowed = 5;

  MultiLineChordsSection(super.text, super.chordSections);

  @override
  void consume(int maxChar) {
    resetDisplaySections();
    final lines = text.splitLines();
    displayText = _synchronizeLineBreak(0, lines, maxChar - 1);
  }

  String _synchronizeLineBreak(
    int innerDisplayOffset,
    List<String> lines,
    int maxLineLength,
  ) {
    if (lines.isNotEmpty) {
      // One line
      if (lines.length == 1) {
        return '${lines[0]}\n';
      }
      // Many lines
      else if (lines.length > 2) {
        // Breaks the line array in two
        final part1 = lines.take(2).toList(growable: false);
        final part2 = lines.sublist(2).toList(growable: false);

        // The second part offset consists in all the characters from the first part.
        // Since the first part has 2 lines with one stripped '\n' each, the offset falls to
        // part1[0].length() + part1[1].length() + 2
        return _synchronizeLineBreak(
              0,
              part1,
              maxLineLength,
            ) +
            _synchronizeLineBreak(
              part1[0].length + part1[1].length + 2,
              part2,
              maxLineLength,
            );
      }
      // Two lines
      else {
        return _synchronizeTwoLines(innerDisplayOffset, lines[0], lines[1], maxLineLength);
      }
    } else {
      return "";
    }
  }

  String _synchronizeTwoLines(
    int innerDisplayOffset,
    String line1Str,
    String line2Str,
    int maxLineLength,
  ) {
    StringBuffer sb = StringBuffer();

    if (line1Str.length <= maxLineLength) {
      /// Example ('|' is where a line break occurs):
      ///
      /// <b>E<b/>|
      /// Very long second| line
      ///
      sb.writeln(line1Str);
      sb.writeln(line2Str);
    } else if (line2Str.length <= maxLineLength) {
      ///
      /// Example ('|' is where a line break occurs):
      ///
      /// <b>E<b/>      |<b>Am<b/>   <b>B<b/>
      /// Short one|
      int lineBreak1 = getClosestPossibleTextBreak(line1Str, maxLineLength, minLineBreakAllowed);

      if (lineBreak1 < 0) {
        lineBreak1 = maxLineLength;
      }

      // +1 for the line break on line one and another
      // +1 for the second line break on line two
      moveSections(displayChords, innerDisplayOffset + lineBreak1, line2Str.length + 2);

      // Check if it was impossible to break... if so, force the break
      lineBreak1 = lineBreak1 < 0 ? maxLineLength : lineBreak1;
      sb.writeln(line1Str.substring(0, lineBreak1));
      sb.writeln(line2Str);

      if (lineBreak1 < line1Str.length) {
        sb.writeln(line1Str.substring(lineBreak1));
      }
    } else {
      /// Example ('|' is where a line break occurs):
      ///
      /// <b>E<b/>      |<b>Am<b/>   <b>B<b/>
      /// Very long second| line
      ///
      int lineBreak1 = maxLineLength;
      int lineBreak2 = maxLineLength;

      while (lineBreak1 > 0 && lineBreak2 > 0) {
        lineBreak1 = getClosestPossibleTextBreak(line1Str, lineBreak1, minLineBreakAllowed);
        lineBreak2 = getClosestPossibleTextBreak(line2Str, lineBreak2, minLineBreakAllowed);

        // Impossible to break both lines... force the break on them!
        if (lineBreak1 < 0 && lineBreak2 < 0) {
          // Every acorde after the line break will have to be affected
          innerDisplayOffset += maxLineLength;

          // +1 for the line break on line one and another +1 for the second line break on line two
          moveSections(displayChords, innerDisplayOffset, maxLineLength + 2);

          // And the new offset will include the acorde line and the '\n's
          innerDisplayOffset += maxLineLength + 2;

          sb.writeln(line1Str.substring(0, maxLineLength));
          sb.writeln(line2Str.substring(0, maxLineLength));
          sb.write(_synchronizeTwoLines(
              innerDisplayOffset, line1Str.substring(maxLineLength), line2Str.substring(maxLineLength), maxLineLength));
          return sb.toString();
        }
        // Impossible to break line 1, but line 2 has a point of break
        // OR both line breaks are equal, so picking one of them makes no difference
        else if (lineBreak1 < 0 || lineBreak1 == lineBreak2) {
          // Every acorde after the line break will have to be affected
          innerDisplayOffset += lineBreak2;

          // +1 for the line break on line one and another +1 for the second line break on line two
          moveSections(displayChords, innerDisplayOffset, lineBreak2 + 2);

          // And the new offset will include the acorde line and the '\n's
          innerDisplayOffset += lineBreak2 + 2;

          sb.writeln(line1Str.substring(0, lineBreak2));
          sb.writeln(line2Str.substring(0, lineBreak2));
          sb.write(
            _synchronizeTwoLines(
                innerDisplayOffset, line1Str.substring(lineBreak2), line2Str.substring(lineBreak2), maxLineLength),
          );
          return sb.toString();
        }
        // Impossible to break line 2, but line 1 has a point of break
        else if (lineBreak2 < 0) {
          // Every acorde after the line break will have to be affected
          innerDisplayOffset += lineBreak1;

          // +1 for the line break on line one and another +1 for the second line break on line two
          moveSections(displayChords, innerDisplayOffset, lineBreak1 + 2);

          // And the new offset will include the acorde line and the '\n's
          innerDisplayOffset += lineBreak1 + 2;

          sb.writeln(line1Str.substring(0, lineBreak1));
          sb.writeln(line2Str.substring(0, lineBreak1));
          sb.write(
            _synchronizeTwoLines(
                innerDisplayOffset, line1Str.substring(lineBreak1), line2Str.substring(lineBreak1), maxLineLength),
          );
          return sb.toString();
        }
        // Both lines have a line break, but they don't match. Pick the smaller one
        else {
          if (lineBreak1 < lineBreak2) {
            lineBreak2 = lineBreak1;
          } else {
            lineBreak1 = lineBreak2;
          }
        }
      }
    }

    return sb.toString();
  }
}
