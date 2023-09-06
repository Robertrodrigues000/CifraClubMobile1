import 'package:cifraclub/data/songbook/data_source/user_songbook_data_source.dart';
import 'package:cifraclub/data/songbook/models/user_songbook_dto.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';

class UserSongbookRepositoryImpl extends UserSongbookRepository {
  final UserSongbookDataSource _userSongbookDataSource;

  UserSongbookRepositoryImpl(this._userSongbookDataSource);

  @override
  Stream<List<Songbook>> getAllUserSongbooks() {
    return _userSongbookDataSource
        .getAll()
        .map((songbookList) => songbookList.map((songbook) => songbook.toDomain()).toList());
  }

  @override
  Future<int> putUserSongbook(Songbook songbook) async {
    return _userSongbookDataSource.put(UserSongbookDto.fromDomain(songbook));
  }

  @override
  Future<List<int>> setUserSongbooks(List<Songbook> songbooks) {
    return _userSongbookDataSource.setAll(songbooks.map(UserSongbookDto.fromDomain).toList(growable: false));
  }

  @override
  Future<bool> deleteUserSongbook(int songbookId) {
    return _userSongbookDataSource.deleteSongbook(songbookId);
  }

  @override
  Stream<int> getTotalSongbooks() {
    return _userSongbookDataSource.getTotalSongbooks();
  }

  @override
  Future<Songbook?> getSongbookById(int id) async {
    return (await _userSongbookDataSource.getSongbookById(id))?.toDomain();
  }

  @override
  Future<int?> updateSongbookPreview(int songbookId, List<String?> preview) {
    return _userSongbookDataSource.updatePreview(songbookId, preview);
  }

  @override
  Stream<Songbook?> getSongbookStreamById(int? id) {
    return _userSongbookDataSource.getSongbookStreamById(id).map((songbook) => songbook?.toDomain());
  }

  @override
  Future<void> deleteAll() {
    return _userSongbookDataSource.deleteAll();
  }

  @override
  Future<int?> updateTotalSongs({required int songbookId}) {
    return _userSongbookDataSource.updateTotalSongs(songbookId);
  }
}
