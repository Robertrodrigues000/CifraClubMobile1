import 'package:cifraclub/data/songbook/models/user_cifra_dto.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:isar/isar.dart';

part 'user_songbook_dto.g.dart';

@collection
class UserSongbookDto {
  final Id id;
  final DateTime createdAt;
  final DateTime lastUpdated;
  final String name;

  final userCifras = IsarLinks<UserCifraDto>();

  UserSongbookDto.fromDomain(Songbook songbook)
      : this(
          createdAt: songbook.createdAt,
          lastUpdated: songbook.lastUpdated,
          name: songbook.name,
          id: songbook.id ?? Isar.autoIncrement,
        );

  Songbook toDomain() {
    return Songbook(
      id: id,
      createdAt: createdAt,
      lastUpdated: lastUpdated,
      name: name,
    );
  }

  UserSongbookDto({
    this.id = Isar.autoIncrement,
    required this.createdAt,
    required this.lastUpdated,
    required this.name,
  });
}
