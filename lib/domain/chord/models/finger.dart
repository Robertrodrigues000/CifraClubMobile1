import 'package:equatable/equatable.dart';

class Finger extends Equatable {
  final int id;
  final int fret;
  final int string;

  const Finger({
    required this.id,
    required this.fret,
    required this.string,
  });

  // coverage:ignore-start
  @override
  String toString() {
    return 'Finger(id: $id, fret: $fret, string: $string)';
  }

  @override
  List<Object?> get props => [id, fret, string];

  // coverage:ignore-end
}
