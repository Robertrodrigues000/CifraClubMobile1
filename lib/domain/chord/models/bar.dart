//Pestana

import 'package:equatable/equatable.dart';

class Bar extends Equatable {
  final int string;
  final int fret;
  final int? endString;

  const Bar({
    required this.string,
    required this.fret,
    this.endString,
  });

  // coverage:ignore-start
  @override
  String toString() {
    return 'Bar(string: $string, fret: $fret, endString: $endString)';
  }

  @override
  List<Object?> get props => [string, fret, endString];
  // coverage:ignore-end
}
