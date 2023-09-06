import 'package:cifraclub/domain/section/models/chord_text.dart';
import 'package:cifraclub/domain/section/models/section_offset.dart';
import 'package:cifraclub/domain/section/models/tag_mark.dart';

class ChordTextFactory {
  final matcher = RegExp(r'<b>(?<CHORD>.*?)</b>');

  List<ChordText> findAll(String text, [int baseOffset = 0]) {
    return matcher.allMatches(text).map((match) {
      return ChordText(
        name: match.namedGroup('CHORD')!,
        offset: SectionOffset(
          start: baseOffset + match.start,
          end: baseOffset + match.end,
        ),
      );
    }).toList(growable: false);
  }

  /// Strips the acorde-tags and updates the acordes section values
  /// @param originalText    The text with tags
  /// @param acordesSections The acordes sections
  /// @param accOffset       An offset to be summed with the section values of all acordes. This
  ///                         is useful when the parameter's text is part of a bigger text and the acorde
  ///                         section should be in accordance with the whole text.
  /// @return The tag-stripped text
  ///
  StrippedTagTextInfo stripTags(String originalText, List<ChordText> chordSections, int accOffset) {
    return stripTagsInBound(originalText, chordSections, accOffset, -1, -1);
  }

  StrippedTagTextInfo stripTagsInBound(
    String originalText,
    List<ChordText> chordSections,
    int accOffset,
    int tabStart,
    int tabEnd,
  ) {
    if (chordSections.isNotEmpty) {
      StringBuffer sb = StringBuffer();

      var tagStrippedOffset = 0;
      var removedChordOffSet = 0;
      var lastOffset = 0;
      var start = 0;
      var end = 0;
      final int leftTag = TagMark.chordStart.mark.length;
      final int rightTag = TagMark.chordEnd.mark.length;

      Iterator<ChordText> it = chordSections.iterator;
      List<ChordText> removals = [];
      while (it.moveNext()) {
        ChordText chordText = it.current;

        // Gets the text within the tags
        start = chordText.offset.start + accOffset;
        end = chordText.offset.end + accOffset;
        chordText.name = originalText.substring(start + leftTag, end - rightTag);

        // Appends the tag-stripped text to the StringBuffer
        sb.write(originalText.substring(lastOffset, start));
        sb.write(chordText.name);
        lastOffset = end;

        // Update the the stripped indexes
        start -= tagStrippedOffset;
        end -= tagStrippedOffset + leftTag + rightTag;
        chordText.offset = SectionOffset(start: start, end: end);

        if (!(chordText.offset.start >= tabStart && chordText.offset.start <= tabEnd) ||
            (tabStart == -1 && tabEnd == -1)) {
          tagStrippedOffset += leftTag + rightTag;
        } else {
          // catch bad formatted cifra that there are /b inside /t2
          removals.add(chordText);
          removedChordOffSet += leftTag + rightTag;
        }
      }
      for (var chord in removals) {
        chordSections.remove(chord);
      }

      // Saves the end of the striped text
      if (lastOffset < originalText.length) {
        sb.write(originalText.substring(lastOffset));
      }

      return StrippedTagTextInfo(sb.toString(), tagStrippedOffset, removedChordOffSet);
    } else {
      return StrippedTagTextInfo(originalText, 0, 0);
    }
  }
}

class StrippedTagTextInfo {
  final String strippedTagText;
  final int numOfCharsStripped;
  final int numOfCharsRemoved;

  StrippedTagTextInfo(this.strippedTagText, this.numOfCharsStripped, this.numOfCharsRemoved);
}
