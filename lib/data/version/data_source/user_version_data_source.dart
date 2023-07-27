import 'package:cifraclub/data/version/models/user_version_dto.dart';
import 'package:cifraclub/data/version/models/user_recent_version_dto.dart';
import 'package:isar/isar.dart';

class UserVersionDataSource {
  final Isar _isar;

  UserVersionDataSource(
    this._isar,
  );

  Future<List<int>> putVersionsToSongbook(List<UserVersionDto> userVersionDtos) async {
    return _isar.writeTxn(
      () async {
        return _isar.userVersionDtos.putAll(userVersionDtos);
      },
    );
  }

  Future<List<int>> putVersionsToRecentSongbook(List<UserRecentVersionDto> userVersionDtos) async {
    return _isar.writeTxn(
      () async {
        return _isar.userRecentVersionDtos.putAll(userVersionDtos);
      },
    );
  }

  Future<void> clearAllVersions() {
    return _isar.writeTxn(
      () async {
        Future.wait([
          _isar.userVersionDtos.clear(),
          _isar.userRecentVersionDtos.clear(),
        ]);
      },
    );
  }

  Future<List<UserVersionDto>> getVersionsFromSongbook(int songbookId) async {
    return _isar.userVersionDtos.where().songbookIdEqualTo(songbookId).findAll();
  }

  Future<List<UserRecentVersionDto>> getVersionsFromRecentSongbook() async {
    return _isar.userRecentVersionDtos.where().findAll();
  }

  Stream<int> getTotalSongbookVersions(int songbookId) {
    return _isar.txnSync(
      () {
        return _isar.userVersionDtos
            .where()
            .songbookIdEqualTo(songbookId)
            .watch(fireImmediately: true)
            .map((e) => e.length);
      },
    );
  }

  Future<List<String?>> getImagesPreview(int songbookId) async {
    return _isar.userVersionDtos
        .where()
        .songbookIdEqualToArtistImageIsNotNull(songbookId)
        .sortByArtistImage()
        .distinctByArtistImage()
        .limit(5)
        .artistImageProperty()
        .findAll();
  }

  Future<int?> deleteVersions(int songbookId) async {
    return _isar.writeTxn(() async {
      return _isar.userVersionDtos.where().songbookIdEqualTo(songbookId).deleteAll();
    });
  }

  Future<int?> deleteRecentVersions() {
    return _isar.writeTxn(() async {
      return _isar.userRecentVersionDtos.where().deleteAll();
    });
  }

  Future<int?> deleteVersionsById(List<int> ids) async {
    return _isar.writeTxn(() async {
      return _isar.userVersionDtos.deleteAll(ids);
    });
  }

  Stream<List<UserVersionDto>> getVersionsStreamFromSongbook(int songbookId) {
    return _isar.userVersionDtos.where().songbookIdEqualTo(songbookId).watch(fireImmediately: true);
  }

  Stream<List<UserRecentVersionDto>> getVersionsStreamFromRecentSongbook() {
    return _isar.userRecentVersionDtos.where().watch(fireImmediately: true);
  }
}
