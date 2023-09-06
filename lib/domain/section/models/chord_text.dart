import 'package:cifraclub/domain/section/models/section_offset.dart';

class ChordText {
  String name;
  SectionOffset offset;

  ChordText({
    required this.name,
    required this.offset,
  });

  @override
  String toString() => "$name $offset"; // coverage:ignore-line

  ChordText clone() {
    return ChordText(
      name: name,
      offset: offset.copyWith(),
    );
  }
}
