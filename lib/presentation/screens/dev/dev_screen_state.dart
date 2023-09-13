import 'package:cifraclub/domain/chord/models/chord_representation.dart';

class DevScreenState {
  const DevScreenState({
    required this.isLoading,
    this.chordRepresentation,
  });
  final List<ChordRepresentation>? chordRepresentation;
  final bool isLoading;
}
