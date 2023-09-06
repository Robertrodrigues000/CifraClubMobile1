// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/extensions/string.dart';

import 'package:cifraclub/domain/section/factories/chord_text_factory.dart';
import 'package:cifraclub/domain/section/models/chord_text.dart';
import 'package:cifraclub/domain/section/models/section_offset.dart';
import 'package:cifraclub/domain/section/models/tag_mark.dart';
import 'package:cifraclub/domain/section/models/section.dart';

class TabSection extends Section {
  // Constant defines the maximum difference allowed from a potential synchronized line break and
  // the maximum number of characters that fit on the screen.
  // Example: if the screen width comports 50 chars, the minimum allowed line break would be at
  // (50 - MAX_DEPTH_COMPARATION)
  static const int maxDepthComparation = 10;

  ChordTextFactory chordsFactory = ChordTextFactory();

  SectionOffset innerTabSection;
  final List<ChordText> _chordSections;
  List<ChordText> _displayChordSections = [];
  List<String> preTabsTextLines = [];

  /// Tab line heads are the marking that happens before each tab line
  List<String> tabLineHeads = [];
  List<String> tabLines = [];

  TabSection(super.text, this._chordSections, this.innerTabSection);

  @override
  List<ChordText> get displayChords => _displayChordSections;

  @override
  List<ChordText> get chords => _chordSections;

  @override
  void consume(int maxChar) {
    updateDisplayText(maxChar - 1);
  }

  void updateDisplayText(int maxCharPerLine) {
    resetDisplaySections();
    updateDisplayTextWithLineBreaks(maxCharPerLine);
  }

  /// Resets the display sections.
  /// This is useful when a new computation for the section location
  /// is needed and so it should be done over the original sections' location.
  void resetDisplaySections() {
    _displayChordSections = _chordSections.map((e) => e.clone()).toList(growable: false);
  }

  // Handles tag removal, sections update, tab-head extraction and line splitting
  void preprocess() {
    // Strips the TAB_EXT_BEGIN tag
    int tagBeginOffset = TagMark.tabExternalStart.mark.length + text.indexOf(TagMark.tabExternalStart.mark);
    text = text.substring(tagBeginOffset);

    // Strips the tags from the acordes, if any
    StrippedTagTextInfo strippedTagTextInfo = chordsFactory.stripTagsInBound(
      text,
      _chordSections,
      -tagBeginOffset,
      innerTabSection.start,
      innerTabSection.end,
    );
    text = strippedTagTextInfo.strippedTagText;
    int charsStrippedInChords = strippedTagTextInfo.numOfCharsStripped;
    int charsRemovedInTab = strippedTagTextInfo.numOfCharsRemoved;

    // Gets the text within the tags TAB_INT_BEGIN and TAB_INT_END
    int tagIntLeft = TagMark.tabInternalStart.mark.length;
    int tagIntRight = TagMark.tabInternalEnd.mark.length;
    int start = innerTabSection.start - tagBeginOffset - charsStrippedInChords;
    int end = innerTabSection.end - tagBeginOffset - charsStrippedInChords - charsRemovedInTab;
    String tabContent = text.substring(start + tagIntLeft, end - tagIntRight);

    // Updates the original text with the tag-stripped content.
    // Any text between TAB_INT_END and TAB_EXT_END is *** IGNORED ***
    text = text.substring(0, start) + tabContent;
    preTabsTextLines = text.substring(0, start).splitLines();

    extractTabLines(tabContent);

    // Updates the tab section values
    innerTabSection = SectionOffset(start: start, end: text.length);
  }

  /// Extracts the tab-heads and the tab-contents
  void extractTabLines(String tabContent) {
    tabLines = tabContent.splitLines();
    tabLineHeads = List.filled(tabLines.length, "");
    for (int i = 0; i < tabLines.length; i++) {
      tabLineHeads[i] = extractLineHead(tabLines[i]);
      if (tabLineHeads[i].isNotEmpty) {
        tabLines[i] = tabLines[i].substring(tabLineHeads[i].length);
      }
    }
  }

  /// Tries to extract a tab-head from a tab-line
  /// Returns the tab-head extract (an empty String if nothing was found)
  String extractLineHead(String line) {
    const int maxCharsToCheck = 10;
    int size = line.length < maxCharsToCheck ? line.length : maxCharsToCheck;
    int indexToBreak = 0;
    bool toneFound = false;

    while (indexToBreak < size && line[indexToBreak] == ' ') {
      indexToBreak++;
    }

    // The line should have at least two characters to have a line head
    if (size < 3 || indexToBreak >= size) {
      return "";
    }

    // First character possibility
    switch (line[indexToBreak].toUpperCase()) {
      // Possible tones (H is B in german)
      case 'C':
      case 'D':
      case 'F':
      case 'G':
      case 'A':
      case 'E':
      case 'B':
      case 'H':
        toneFound = true;
        indexToBreak++;
      case '|':
      case '!':
      case ':':
        indexToBreak++;
    }

    // Check for sharp or flat (bemol)
    if (toneFound && indexToBreak < size) {
      switch (line[indexToBreak]) {
        case 'b':
        case '#':
          indexToBreak++;
      }
    }

    if (indexToBreak > 0) {
      // Fetch the characters until an unallowed character is found
      bool stop = false;
      for (int i = indexToBreak; i < size; i++) {
        switch (line[i]) {
          // Allowed characters
          case '|':
          case ':':
          case '!':
          case ' ':
            indexToBreak = i + 1;
          default:
            stop = true;
        }
        if (stop) {
          break;
        }
      }

      return line.substring(0, indexToBreak);
    } else {
      return "";
    }
  }

  /// Updates the display text with a String containing a correctly line broken text
  void updateDisplayTextWithLineBreaks(int maxCharPerLine) {
    try {
      displayText = breakLines(
        0,
        List.from(preTabsTextLines),
        List.from(tabLines),
        maxCharPerLine,
        maxCharPerLine,
      );
    } catch (e, s) {
      logger?.sendNonFatalCrash(exception: e, stack: s);
    }
  }

  /// Breaks both the pre-tab text and the tab text at a synchronized point. Returns the string
  /// with the broken text and tabs correctly processed.
  ///
  /// @param preText              Text that happens before the tab
  /// @param tabText              The actual tab texts
  /// @param currentStepCharLimit Current char limit used to find a better synchronized line break.
  ///                             This value comes from a previous computation of a line break that
  ///                             has a better chance of achieving a synchronized line break from
  ///                             tabs and pre-texts.
  /// @param maxCharPerLine       The max limit of chars that fits on the screen.
  /// @return
  String breakLines(
    int innerDisplayOffset,
    List<String> preText,
    List<String> tabText,
    int currentStepCharLimit,
    int maxCharPerLine,
  ) {
    _LineBreakInfo tabLineBreak;
    _LineBreakInfo preTabTextLineBreak;

    // Check so not to go to deep in search for a common line break
    if (maxCharPerLine - currentStepCharLimit >= maxDepthComparation) {
      tabLineBreak = _getSynchronizedLineBreakForTabs(tabText, maxCharPerLine);
      preTabTextLineBreak = tabLineBreak;
    } else {
      tabLineBreak = _getSynchronizedLineBreakForTabs(tabText, currentStepCharLimit);
      preTabTextLineBreak = _getSynchronizedLineBreakForPreTabsText(preText, tabLineBreak.pointOfBreak);
    }

    // Found a common break point
    if (tabLineBreak.pointOfBreak == preTabTextLineBreak.pointOfBreak ||
        tabLineBreak.textFitsInScreen ||
        preTabTextLineBreak.textFitsInScreen) {
      List<String> leftPreText = [];
      List<String> leftTabText = [];

      StringBuffer sb = StringBuffer();
      int lineBreak;
      int numberOfCharsBeforeChordLine = 0;

      // Break pre text
      int size = preText.length;
      int lineLength;
      for (int i = 0; i < size; i++) {
        lineLength = preText[i].length;

        // Shifts the line break to the current line length, if necessary
        if (preTabTextLineBreak.pointOfBreak < lineLength && !preTabTextLineBreak.textFitsInScreen) {
          lineBreak = preTabTextLineBreak.pointOfBreak;
        } else {
          lineBreak = lineLength - 1;
        }

        // If there are any text lines BEFORE the chord lines in this tablature section,
        // we must count the characters of these lines and compensate them when
        // deciding which chords should move on the line breaking of the tablature section.
        // +1 for the "\n" in the end of each line.
        if (i < size - 1) {
          numberOfCharsBeforeChordLine += lineLength + 1;
        }

        // +1 for the second parameter of the substring
        // (the 'lineBreak' index is part of the current line)
        lineBreak++;
        sb.writeln(preText[i].substring(0, lineBreak));

        if (lineBreak < lineLength) {
          leftPreText.add(preText[i].substring(lineBreak));
        }
      }

      // When a line break occurs and there are acordes present, a part of them will be
      // shifted after a whole block of tabs. This variable accounts for this shift
      int characterBlockAfterChords = 1;

      // Break tabs
      size = tabText.length;
      bool allTabsFitOnScreen = true;
      int lineBreakWithoutHeadSize;
      int tabLineHeadLength;
      for (int i = 0; i < size; i++) {
        tabLineHeadLength = tabLineHeads[i].length;
        lineBreakWithoutHeadSize = tabLineBreak.pointOfBreak - tabLineHeadLength;
        lineLength = tabText[i].length;

        // Shifts the line break to the current line length, if necessary
        if (lineBreakWithoutHeadSize < lineLength && !tabLineBreak.textFitsInScreen) {
          lineBreak = lineBreakWithoutHeadSize;
        } else {
          lineBreak = lineLength - 1;
        }

        // +1 for the second parameter of the substring
        // (the 'lineBreak' index is part of the current line)
        lineBreak++;

        sb.write(tabLineHeads[i]);
        sb.writeln(tabText[i].substring(0, lineBreak));

        // tab head + tab content + '\n'
        characterBlockAfterChords += tabLineHeadLength + lineBreak + 1;

        if (lineBreak < lineLength) {
          allTabsFitOnScreen = false;
          leftTabText.add(tabText[i].substring(lineBreak));
        } else {
          leftTabText.add(" ");
        }
      }
      sb.write('\n');
      characterBlockAfterChords += 1;

      // If all tabs fits on screen, there is no need to pass any content on the leftTabText
      // (since there is nothing left =P)
      if (allTabsFitOnScreen) {
        leftTabText = [];
      }

      // Moves all the acordes' sections that will suffer a line break.
      innerDisplayOffset += preTabTextLineBreak.pointOfBreak;
      innerDisplayOffset += numberOfCharsBeforeChordLine;

      moveSections(_displayChordSections, innerDisplayOffset, characterBlockAfterChords);

      innerDisplayOffset += characterBlockAfterChords + 1;

      // Break remaining text, if any
      if ((!allTabsFitOnScreen || leftPreText.isNotEmpty) &&
          leftTabText.isNotEmpty &&
          leftTabText.join().trim().replaceAll("-", "").replaceAll("|", "") != "") {
        sb.write(breakLines(innerDisplayOffset, leftPreText, leftTabText, maxCharPerLine, maxCharPerLine));
      }

      return sb.toString();
    }
    // No common line break found... try again with the smaller break found
    else if (tabLineBreak.pointOfBreak < preTabTextLineBreak.pointOfBreak) {
      return breakLines(innerDisplayOffset, preText, tabText, tabLineBreak.pointOfBreak, maxCharPerLine);
    } else {
      return breakLines(innerDisplayOffset, preText, tabText, preTabTextLineBreak.pointOfBreak, maxCharPerLine);
    }
  }

  /// Gets the common line break point for all the tab lines. This break point takes into account
  /// each of the tab line heads
  ///
  /// @param tabLines
  /// @param maxCharPerLine
  /// @return The exact index of the line break
  _LineBreakInfo _getSynchronizedLineBreakForTabs(List<String> tabLines, int maxCharPerLine) {
    // Line break including the last head size
    int lastLineBreak = maxCharPerLine;

    bool textFitsInScreen = true;
    int currentLineBreak;
    int currentHeadSize;
    int size = tabLines.length;
    for (int i = 0; i < size; i++) {
      // Check if the search for a synchronized line break has not gone too far
      if (maxCharPerLine - lastLineBreak > maxDepthComparation) {
        lastLineBreak = maxCharPerLine;
        textFitsInScreen = false;
        break;
      }

      currentHeadSize = tabLineHeads[i].length;

      // Check if text fits in screen
      // If the line break occurred due to a small text length, there is no need to force
      // the next line break to a smaller index
      if (tabLines[i].length <= maxCharPerLine - currentHeadSize) {
        currentLineBreak = tabLines[i].length - 1;
      }
      // Remove the current line head tab size and try to break the actual tab content
      else {
        textFitsInScreen = false;
        currentLineBreak = getClosestPossibleTabBreak(
          tabLines[i],
          lastLineBreak - currentHeadSize,
          maxCharPerLine - maxDepthComparation,
        );

        // If no possible line break was found, force the break
        if (currentLineBreak < 0) {
          currentLineBreak = lastLineBreak - currentHeadSize;
        } else if (i > 0 && (currentLineBreak + currentHeadSize) < lastLineBreak) {
          // If a new line break was found, start over
          i = -1;
        }

        lastLineBreak = currentLineBreak + currentHeadSize;
      }
    }
    return _LineBreakInfo(pointOfBreak: lastLineBreak, textFitsInScreen: textFitsInScreen);
  }

  /// Gets a line break point which is common for all the text lines.
  ///
  /// @param preTabsTextLines
  /// @param maxCharPerLine
  /// @return The exact index of the line break
  _LineBreakInfo _getSynchronizedLineBreakForPreTabsText(
    List<String> preTabsTextLines,
    int maxCharPerLine,
  ) {
    int currentLineBreak;
    int lastLineBreak;

    lastLineBreak = maxCharPerLine;

    // Break pre-tab texts
    bool textFitsInScreen = true;
    int size = preTabsTextLines.length;
    for (int i = 0; i < size; i++) {
      // Check if the search for a synchronized line break has not gone too far
      if (maxCharPerLine - lastLineBreak > maxDepthComparation) {
        lastLineBreak = maxCharPerLine;
        textFitsInScreen = false;
        break;
      }

      // Check if text fits in screen
      // If the line break occurred due to a small text length, there is no need to force
      // the next line break to a smaller index
      if (preTabsTextLines[i].length <= maxCharPerLine) {
        currentLineBreak = preTabsTextLines[i].length - 1;
      }
      // Remove the current line head tab size and try to break the actual tab content
      else {
        textFitsInScreen = false;

        // Try to break the line
        currentLineBreak = getClosestPossibleTabBreak(
          preTabsTextLines[i],
          lastLineBreak,
          maxCharPerLine - maxDepthComparation,
        );

        // If no possible line break was found, force the break
        if (currentLineBreak < 0) {
          currentLineBreak = lastLineBreak;
        }
        // Check if the line breaks are synchronized
        // If the line break occurred due to a small text length, there is no need to force
        // the next line break to a smaller index
        else if (currentLineBreak < lastLineBreak) {
          // If a new line break was found, start over
          i = -1;
          lastLineBreak = currentLineBreak;
        }
      }
    }

    return _LineBreakInfo(
      pointOfBreak: lastLineBreak,
      textFitsInScreen: textFitsInScreen,
    );
  }
}

class _LineBreakInfo {
  int pointOfBreak;
  bool textFitsInScreen;

  _LineBreakInfo({
    required this.pointOfBreak,
    required this.textFitsInScreen,
  });

  @override
  String toString() => "[pointOfBreak=$pointOfBreak, textFitsInScreen=$textFitsInScreen]"; // coverage:ignore-line
}
