import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/section/factories/multi_line_chords_section_factory.dart';
import 'package:cifraclub/domain/section/factories/single_line_chords_section_factory.dart';
import 'package:cifraclub/domain/section/factories/tab_section_factory.dart';
import 'package:cifraclub/domain/section/factories/text_section_factory.dart';
import 'package:cifraclub/domain/section/factories/section_factory.dart';
import 'package:cifraclub/domain/section/models/text_section.dart';
import 'package:cifraclub/domain/section/models/section.dart';
import 'package:injectable/injectable.dart';

@injectable
class ParseSections {
  final List<SectionFactory> _versionSectionFactories = [
    TabSectionFactory(),
    MultiLineChordsSectionFactory(),
    SingleLineChordsSectionFactory(),
    TextSectionFactory(),
  ];

  List<Section> call(String content) {
    if (content.contains('\u{200C}')) {
      content = content.replaceAll('\u{200C}', "");
      logger?.sendNonFatalCrash(exception: Exception("Version has invalid character U+200C"));
    }

    /// Adding an "\n" at the end fix parsers that could not recognize pattern of the last line
    /// Refers to `Preprocessor#initBaseText`.
    if (!content.endsWith('\n')) {
      content = "$content\n";
    }

    final sections = <Section>[];
    var start = 0;

    outerloop:
    while (start < content.length) {
      for (var versionSectionFactory in _versionSectionFactories) {
        final match = versionSectionFactory.match(content, start);
        if (match != null) {
          sections.addAll(match.sections);
          start += match.length;
          continue outerloop;
        }
      }

      // None of the parsers could handle the format,
      // so we will be creating a TextSection with all of the remaining text
      sections.add(TextSection(content.substring(start, content.length)));
      start = content.length;
      logger?.sendNonFatalCrash(exception: Exception("Unrecognized line: ${content.substring(start, content.length)}"));
    }
    return sections;
  }
}
