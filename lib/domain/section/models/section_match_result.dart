import 'package:cifraclub/domain/section/models/section.dart';

class SectionMatchResult {
  final List<Section> sections;
  final int length;

  const SectionMatchResult(this.sections, this.length);

  @override
  String toString() => "length=$length; sections: ${sections.join(", ")}"; // coverage:ignore-line
}
