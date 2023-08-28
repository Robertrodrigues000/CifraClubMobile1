import 'package:equatable/equatable.dart';

class Neck extends Equatable {
  final int start;

  const Neck({required this.start});

  // coverage:ignore-start
  @override
  String toString() {
    return 'Neck(start: $start)';
  }

  @override
  List<Object?> get props => [start];
  // coverage:ignore-end
}
