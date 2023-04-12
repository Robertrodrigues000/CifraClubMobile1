import 'package:cifraclub/data/songbook/models/list_type_dto.dart';
import 'package:cifraclub/data/songbook/models/user_cifra_dto.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:isar/isar.dart';

part 'user_songbook_dto.g.dart';

@collection
class UserSongbookDto {
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
  final userCifras = IsarLinks<UserCifraDto>();

  UserSongbookDto.fromDomain(Songbook songbook)
      : this(
          createdAt: songbook.createdAt,
          lastUpdated: songbook.lastUpdated,
          name: songbook.name,
          id: songbook.id ?? Isar.autoIncrement,
          isPublic: songbook.isPublic,
          totalSongs: songbook.totalSongs,
          type: ListTypeDto.fromDomain(songbook.type),
          thumb: songbook.thumb,
          status: songbook.status,
          userId: songbook.userId,
          userName: songbook.userName,
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
      cifras: null,
      totalSongs: totalSongs ?? 0,
    );
  }

  UserSongbookDto({
    this.id = Isar.autoIncrement,
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
  });
}
