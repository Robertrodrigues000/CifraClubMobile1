import 'package:cifraclub/data/version/models/user_version/user_recent_version_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_version_data_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_version_dto.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
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

  Future<int?> getLocalDatabaseIdFromSongIdInRecentSongbook(int songId) {
    return _isar.userRecentVersionDtos.where().songIdEqualTo(songId).localDatabaseIdProperty().findFirst();
  }

  Future<void> clearAllVersions() {
    return _isar.writeTxn(
      () async {
        Future.wait([
          _isar.userVersionDtos.clear(),
          _isar.userRecentVersionDtos.clear(),
          _isar.userVersionDataDtos.clear(),
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

  Future<int> getTotalRecentVersions() {
    return _isar.userRecentVersionDtos.count();
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
      await _isar.userVersionDtos.where().songbookIdEqualTo(songbookId).deleteAll();
      return _isar.userVersionDataDtos.where().songbookIdEqualTo(songbookId).deleteAll();
    });
  }

  Future<int?> deleteRecentVersions() {
    return _isar.writeTxn(() async {
      await _isar.userRecentVersionDtos.where().deleteAll();
      return _isar.userVersionDataDtos.where().songbookIdEqualTo(ListType.recents.localId).deleteAll();
    });
  }

  Future<int?> deleteVersionsById(List<int> localDatabaseIds, int songbookId) async {
    if (localDatabaseIds.isEmpty) {
      return 0;
    }

    return _isar.writeTxn(() async {
      await _isar.userVersionDtos.deleteAll(localDatabaseIds);
      return _isar.userVersionDataDtos
          .where()
          .anyOf(localDatabaseIds, (q, id) => q.versionLocalDatabaseIdSongbookIdEqualTo(id, songbookId))
          .deleteAll();
    });
  }

  Future<bool?> deleteVersionBySongId(int songId, int songbookId) {
    return _isar.writeTxn(() async {
      return _isar.userVersionDtos.where().songbookIdEqualTo(songbookId).filter().songIdEqualTo(songId).deleteFirst();
    });
  }

  Future<bool> deleteOldestRecentVersion() async {
    // Tivemos que deletar pelo id porque o método [deleteFirst] do isar está bugado e deleta duas entidades de uma vez em vez de uma só.
    return _isar.writeTxn(() async {
      var versionToDelete = await _isar.userRecentVersionDtos.where().sortByLastUpdate().findFirst();
      if (versionToDelete?.localDatabaseId == null) {
        return false;
      }
      return _isar.userRecentVersionDtos.delete(versionToDelete!.localDatabaseId);
    });
  }

  Stream<List<UserVersionDto>> getVersionsStreamFromSongbook(int songbookId) {
    return _isar.userVersionDtos.where().songbookIdEqualTo(songbookId).watch(fireImmediately: true);
  }

  Stream<List<UserRecentVersionDto>> getVersionsStreamFromRecentSongbook() {
    return _isar.userRecentVersionDtos.where().watch(fireImmediately: true);
  }

  Stream<bool> getIsFavoriteVersionBySongIdStream(int songId) {
    return _isar.userVersionDtos
        .where()
        .songbookIdEqualTo(ListType.favorites.localId)
        .filter()
        .songIdEqualTo(songId)
        .watch(fireImmediately: true)
        .map((event) => event.isNotEmpty);
  }

  Future<int> addVersionData(UserVersionDataDto versionData) {
    return _isar.writeTxn(() async {
      return _isar.userVersionDataDtos.put(versionData);
    });
  }

  Future<bool> getIsVersionOnSongbook(int songbookId, int versionId) {
    return _isar.userVersionDtos.where().songbookIdVersionIdEqualTo(songbookId, versionId).isNotEmpty();
  }
}
