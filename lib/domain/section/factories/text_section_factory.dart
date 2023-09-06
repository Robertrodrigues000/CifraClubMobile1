import 'package:cifraclub/domain/section/factories/section_factory.dart';
import 'package:cifraclub/domain/section/models/text_section.dart';
import 'package:cifraclub/domain/section/models/section.dart';

class TextSectionFactory extends SectionFactory {
  TextSectionFactory()
      : super(RegExp(
          r'(?<DEFAULT>.*\n+)',
          multiLine: true,
          dotAll: false,
        ));

  @override
  List<Section> parse(RegExpMatch match, String part) {
    final text = match.namedGroup('DEFAULT')!;
    if (text != "\n") {
      return [TextSection(text)];
    }
    return [];
  }
}
