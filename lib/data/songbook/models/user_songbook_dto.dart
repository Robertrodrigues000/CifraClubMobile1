import 'package:cifraclub/data/songbook/models/list_type_dto.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'user_songbook_dto.g.dart';

@CopyWith()
@Collection(inheritance: false)
class UserSongbookDto extends Equatable {
  final Id id;
  final String name;
  final String? userName;
  final int? userId;
  final String? thumb;
  final bool isPublic;
  final int? status;
  final int? totalSongs;
  final int? timestamp;
  final DateTime createdAt;
  final DateTime? lastUpdated;
  @enumerated
  final ListTypeDto type;
  final List<String?> preview;

  const UserSongbookDto({
    required this.id,
    required this.createdAt,
    required this.lastUpdated,
    required this.name,
    this.userName,
    this.userId,
    this.thumb,
    required this.type,
    required this.isPublic,
    this.status,
    required this.totalSongs,
    this.timestamp,
    required this.preview,
  });

  UserSongbookDto.fromDomain(Songbook songbook)
      : this(
          createdAt: songbook.createdAt,
          lastUpdated: songbook.lastUpdated,
          name: songbook.name,
          id: _getDatabaseId(songbook),
          isPublic: songbook.isPublic,
          totalSongs: songbook.totalSongs,
          type: ListTypeDto.fromDomain(songbook.type),
          thumb: songbook.thumb,
          status: songbook.status,
          userId: songbook.userId,
          userName: songbook.userName,
          preview: songbook.preview,
        );

  Songbook toDomain() {
    return Songbook(
      id: id,
      userId: userId,
      userName: userName,
      thumb: thumb,
      isPublic: isPublic,
      status: status,
      createdAt: createdAt,
      lastUpdated: lastUpdated,
      name: name,
      type: type.toDomain(),
      totalSongs: totalSongs ?? 0,
      preview: preview,
    );
  }

  @ignore
  @override
  List<Object?> get props => [
        id,
        userId,
        userName,
        isPublic,
        status,
        createdAt,
        lastUpdated,
        name,
        totalSongs,
        preview,
      ];
}

int _getDatabaseId(Songbook songbook) {
  if (songbook.id != null) {
    return songbook.id!;
  }
  if (songbook.type != ListType.user) {
    return songbook.type.localId;
  }
  return Isar.autoIncrement;
}
