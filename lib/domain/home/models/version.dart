import 'package:equatable/equatable.dart';

class Version extends Equatable {
  final int id;
  final int type;
  final String label;

  const Version({required this.id, required this.type, required this.label});

  // coverage:ignore-start
  @override
  List<Object?> get props => [id, type, label];
  // coverage:ignore-end
}
