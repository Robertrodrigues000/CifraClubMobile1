import 'package:cifraclub/data/songbook/models/user_songbook_dto.dart';
import 'package:isar/isar.dart';

class UserSongbookDataSource {
  final Isar _isar;

  UserSongbookDataSource(this._isar);

  Stream<List<UserSongbookDto>> getAll() {
    Query<UserSongbookDto> query = _isar.userSongbookDtos.where().build();
    return query.watch(fireImmediately: true);
  }

  /// Insert or update a songbook
  Future<int> insert(UserSongbookDto userSongbookDto) async {
    if (userSongbookDto.id == Isar.autoIncrement) {
      throw Exception("Songbook should have an id set");
    }

    return _isar.writeTxn(
      () async {
        return _isar.userSongbookDtos.put(userSongbookDto);
      },
    );
  }

  /// Remove all songbooks, then insert all songbooks from [userSongbookDtos]
  Future<List<int>> setAll(List<UserSongbookDto> userSongbookDtos) async {
    if (userSongbookDtos.any((element) => element.id == Isar.autoIncrement)) {
      throw Exception("Songbook should have an id set");
    }

    return _isar.writeTxn(
      () async {
        await _isar.userSongbookDtos.clear();
        return _isar.userSongbookDtos.putAll(userSongbookDtos);
      },
    );
  }
}
