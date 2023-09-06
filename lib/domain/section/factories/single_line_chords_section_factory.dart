import 'package:cifraclub/domain/section/factories/chord_text_factory.dart';
import 'package:cifraclub/domain/section/factories/section_factory.dart';
import 'package:cifraclub/domain/section/models/single_line_chords_section.dart';
import 'package:cifraclub/domain/section/models/section.dart';

class SingleLineChordsSectionFactory extends SectionFactory {
  final chordsFactory = ChordTextFactory();

  SingleLineChordsSectionFactory()
      : super(RegExp(
          r'(?<TWCS>(?:(?!\n).)*?(?:<b>(?:(?!\n|</b>).)*?</b>)+(?:(?!\n).)*)',
          multiLine: false,
          dotAll: true,
        ));

  @override
  List<Section> parse(RegExpMatch match, String part) {
    final text = match.namedGroup('TWCS')!;

    final chordSections = chordsFactory.findAll(text);
    return [SingleLineChordsSection(text, chordSections)];
  }
}
