import 'package:cifraclub/domain/section/models/chord_text.dart';
import 'package:cifraclub/domain/section/models/section.dart';

class TextSection extends Section {
  TextSection(super.text);

  @override
  void consume(int maxChar) {}

  @override
  List<ChordText> get chords => [];

  @override
  List<ChordText> get displayChords => [];
}
