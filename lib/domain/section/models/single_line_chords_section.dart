import 'package:cifraclub/domain/section/factories/chord_text_factory.dart';
import 'package:cifraclub/domain/section/models/chord_text.dart';
import 'package:cifraclub/domain/section/models/section.dart';

class SingleLineChordsSection extends Section {
  final List<ChordText> _chordSections;
  List<ChordText> _displayChordSections = [];
  ChordTextFactory chordsFactory = ChordTextFactory();

  SingleLineChordsSection(String text, this._chordSections) : super(text) {
    this.text = chordsFactory.stripTags(text, _chordSections, 0).strippedTagText;
    displayText = this.text;
  }

  @override
  List<ChordText> get displayChords => _displayChordSections;

  @override
  List<ChordText> get chords => _chordSections;

  @override
  void consume(int maxChar) {
    resetDisplaySections();
  }

  void resetDisplaySections() {
    _displayChordSections = _chordSections.map((e) => e.clone()).toList(growable: false);
  }
}
