// coverage:ignore-file
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'songbook.g.dart';

@CopyWith()
class Songbook extends Equatable {
  final int? id;
  final String name;
  final String? userName;
  final int? userId;
  final String? thumb;
  final bool isPublic;
  final int? status;
  final DateTime createdAt;
  final DateTime? lastUpdated;
  final int totalSongs;
  final ListType type;
  final List<String?> preview;

  const Songbook({
    this.id,
    required this.name,
    this.userName,
    this.userId,
    this.thumb,
    required this.isPublic,
    this.status,
    required this.createdAt,
    this.lastUpdated,
    required this.totalSongs,
    required this.type,
    required this.preview,
  });

  @override
  List<Object?> get props =>
      [id, userId, name, userName, isPublic, thumb, status, createdAt, lastUpdated, type.apiName];
}
