import 'package:cifraclub/domain/section/models/section.dart';
import 'package:cifraclub/domain/section/models/section_match_result.dart';

abstract class SectionFactory {
  final RegExp _matcher;

  const SectionFactory(this._matcher);

  /// Returns a matched section, starting at the [start] index of [content].
  /// The pattern must match at the beggining, otherwise it will return null.
  SectionMatchResult? match(String content, int start) {
    Match? match = _matcher.matchAsPrefix(content, start);
    if (match is RegExpMatch) {
      String part = match.group(0)!;
      return SectionMatchResult(parse(match, part), part.length);
    }
    return null;
  }

  /// Transforms a matched section into a list of [Section].
  List<Section> parse(RegExpMatch match, String part);
}
