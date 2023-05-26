import 'package:cifraclub/data/songbook/models/list_type_dto.dart';
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

  Stream<int> getTotalSongbooks() {
    Query<UserSongbookDto> query = _isar.userSongbookDtos.filter().typeEqualTo(ListTypeDto.user).build();
    return query.watch(fireImmediately: true).map((songbookList) => songbookList.length);
  }

  Future<UserSongbookDto?> getSongbookById(int id) {
    return _isar.userSongbookDtos.filter().idEqualTo(id).findFirst();
  }

  Stream<int> getTotalSongbookCifras(int id) {
    return _isar.userSongbookDtos
        .watchObject(id, fireImmediately: true)
        .map((userSongbook) => userSongbook?.userCifras.countSync() ?? 0);
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

  Future<bool> deleteSongbook(int songbookId) async {
    return _isar.writeTxn(() async {
      return _isar.userSongbookDtos.delete(songbookId);
    });
  }

  Future<int?> deleteCifras(int songbookId) async {
    return _isar.writeTxn(() async {
      final songbook = await _isar.userSongbookDtos.filter().idEqualTo(songbookId).findFirst();
      return songbook?.userCifras.filter().deleteAll();
    });
  }

  Future<List<int>?> getCifrasIds(int songbookId) async {
    return _isar.writeTxn(() async {
      final songbook = await _isar.userSongbookDtos.filter().idEqualTo(songbookId).findFirst();
      return (await songbook?.userCifras.filter().findAll())?.map((e) => e.apiId).toList();
    });
  }
}
