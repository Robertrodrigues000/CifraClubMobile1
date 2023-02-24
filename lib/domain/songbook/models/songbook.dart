// coverage:ignore-file
import 'package:cifraclub/domain/cifra/models/cifra.dart';
import 'package:equatable/equatable.dart';

class Songbook extends Equatable {
  final int? id;
  final DateTime createdAt;
  final DateTime lastUpdated;
  final String name;
  final List<Cifra>? cifras;

  const Songbook({
    this.id,
    required this.createdAt,
    required this.lastUpdated,
    required this.name,
    this.cifras,
  });

  @override
  List<Object?> get props => [id, name];
}
