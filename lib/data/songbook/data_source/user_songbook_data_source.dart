import 'package:cifraclub/data/songbook/models/user_songbook_dto.dart';
import 'package:isar/isar.dart';

class UserSongbookDataSource {
  final Isar _isar;
  UserSongbookDataSource(this._isar);

  Stream<List<UserSongbookDto>> getAll() {
    Query<UserSongbookDto> query = _isar.userSongbookDtos.where().build();
    return query.watch(fireImmediately: true);
  }

  Future<int> insert(UserSongbookDto userSongbookDto) async {
    return _isar.writeTxn(
      () async {
        return _isar.userSongbookDtos.put(userSongbookDto);
      },
    );
  }
}
