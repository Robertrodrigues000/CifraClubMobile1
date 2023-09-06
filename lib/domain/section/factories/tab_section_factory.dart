import 'package:cifraclub/domain/section/factories/chord_text_factory.dart';
import 'package:cifraclub/domain/section/factories/section_factory.dart';
import 'package:cifraclub/domain/section/models/section_offset.dart';
import 'package:cifraclub/domain/section/models/tab_section.dart';
import 'package:cifraclub/domain/section/models/tag_mark.dart';
import 'package:cifraclub/domain/section/models/text_section.dart';
import 'package:cifraclub/domain/section/models/section.dart';

class TabSectionFactory extends SectionFactory {
  final chordsFactory = ChordTextFactory();

  TabSectionFactory()
      : super(RegExp(
          r'(?<TABS>(?<TABSBEFORE>(?:(?!\n).)*?)(?<TABSTRIMMED>#t1#(?<TABSHEADER>.*?)(?<TABSBODY>#t2#.*?#/t2#)(?<TABSFOOTER>.*?)#/t1#))',
          multiLine: false,
          dotAll: true,
        ));

  @override
  List<Section> parse(RegExpMatch match, String part) {
    List<Section> sections = [];

    final innerTab = match.namedGroup('TABSBODY')!;
    int innerTabStart = part.indexOf(innerTab);
    int innerTabEnd = innerTabStart + innerTab.length;
    SectionOffset innerTabSection = SectionOffset(
      start: innerTabStart,
      end: innerTabEnd,
    );

    final text = match.namedGroup('TABSTRIMMED')!;
    int textStart = text.indexOf(TagMark.tabExternalStart.mark) + TagMark.tabExternalStart.mark.length;
    final chords = chordsFactory.findAll(match.namedGroup('TABSHEADER') ?? "", textStart);

    final tabBefore = match.namedGroup('TABSBEFORE');
    if (tabBefore != null && tabBefore.trim().isNotEmpty) {
      sections.add(TextSection(tabBefore));
    }

    sections.add(TabSection(text, chords, innerTabSection)..preprocess());
    return sections;
  }
}
