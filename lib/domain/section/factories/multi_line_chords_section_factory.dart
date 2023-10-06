import 'package:cifraclub/domain/section/factories/chord_text_factory.dart';
import 'package:cifraclub/domain/section/factories/section_factory.dart';
import 'package:cifraclub/domain/section/models/multi_line_chords_section.dart';
import 'package:cifraclub/domain/section/models/section.dart';

class MultiLineChordsSectionFactory extends SectionFactory {
  final chordsFactory = ChordTextFactory();

  MultiLineChordsSectionFactory()
      : super(RegExp(
          r'(?<TWCM>^((?:[ \t]*(?:<b>(?:(?!</b>).)*?</b>))+[ \t]*?)\n((?:(?!(?:[ \t]*<b>(?:(?!</b>).)*?</b>)+[ \t]*?|#t1#).)+))',
          multiLine: true,
          dotAll: false,
        ));

  @override
  List<Section> parse(RegExpMatch match, String part) {
    final text = match.namedGroup('TWCM')!;
    final chords = chordsFactory.findAll(part);

    return [MultiLineChordsSection(text, chords)];
  }
}
