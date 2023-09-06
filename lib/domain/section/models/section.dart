import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/section/models/chord_text.dart';
import 'package:cifraclub/domain/section/models/section_offset.dart';
import 'package:flutter/material.dart';

abstract class Section {
  String text;
  String displayText;
  List<TextSpan> _spans = [];
  int numberOfLines = 0;

  // Offset inside the whole text in which this section is inserted
  int outerOffset = 0;

  // Current offset inside this section
  int innerOffset = 0;

  Section(this.text) : displayText = text;

  /// Creates the display text from the max char allowed in a line
  void consume(int maxChar);

  List<ChordText> get chords;

  List<ChordText> get displayChords;

  void processLineBreak(int maxChar) {
    _spans = [];
    consume(maxChar);
    numberOfLines = '\n'.allMatches(displayText).length;
  }

  void updateOffset(int offset) {
    outerOffset = offset;
    innerOffset = 0;
    displayText = text;
  }

  List<TextSpan> getSpans() {
    if (_spans.isEmpty) {
      _spans.addAll(_buildSpans(displayText, displayChords));
      assert(_spans.isNotEmpty);
    }
    return _spans;
  }

  int getClosestPossibleTextBreak(String line, int upperLimit, int lowerLimit) {
    return _getClosestPossibleBreak(
      line,
      [' ', ',', '\n'],
      upperLimit,
      lowerLimit,
    );
  }

  int getClosestPossibleTabBreak(String line, int upperLimit, int lowerLimit) {
    return _getClosestPossibleBreak(
      line,
      ['-', '~', '~', '|', '!', ' ', '\n'],
      upperLimit,
      lowerLimit,
    );
  }

  int _getClosestPossibleBreak(
    String line,
    List<String> allowedBreakChars,
    int upperLimit,
    int lowerLimit,
  ) {
    if (line.length <= upperLimit) {
      return line.length - 1;
    }
    if (upperLimit < 0 || lowerLimit < 0) {
      logger?.sendNonFatalCrash(
          exception: Exception("TablatureSection: Index out of bounds [$lowerLimit-$upperLimit]"));
      return -1;
    }

    for (int i = upperLimit; i >= lowerLimit; i--) {
      if (allowedBreakChars.contains(line[i])) {
        return i;
      }
    }

    // Impossible to break gracefully...
    return -1;
  }

  void moveSections(List<ChordText> chordSections, int threshold, int deltaOffset) {
    for (var chordSection in chordSections) {
      SectionOffset section = chordSection.offset;
      if (section.start > threshold) {
        int diff = section.end - section.start;
        chordSection.offset = SectionOffset(
          start: section.start + deltaOffset,
          end: section.start + deltaOffset + diff,
        );
      }
    }
  }

  List<TextSpan> _buildSpans(String text, List<ChordText> chords) {
    final spans = <TextSpan>[];
    final validChords = chords.where((e) {
      return e.offset.start < text.length && e.offset.end <= text.length && e.offset.start < e.offset.end;
    });
    var currentPosition = 0;

    for (ChordText chordText in validChords) {
      if (currentPosition < chordText.offset.start) {
        spans.add(TextSpan(text: text.substring(currentPosition, chordText.offset.start)));
        currentPosition = chordText.offset.start;
      }

      /// TODO: Verificação temporária enquanto o parser de tablatura está calculando errado o offset dos acordes após realizar quebra de linha
      if (chordText.name.matchAsPrefix(text, currentPosition) != null) {
        spans.add(
          TextSpan(
            text: chordText.name,
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
        );
      } else {
        spans.add(TextSpan(text: text.substring(currentPosition, chordText.offset.end)));
      }
      currentPosition = chordText.offset.end;
    }
    if (currentPosition < text.length) {
      spans.add(TextSpan(text: text.substring(currentPosition)));
    }
    return spans;
  }
}
