import 'package:cifraclub/data/version/data_source/user_version_data_source.dart';
import 'package:cifraclub/data/version/models/user_version/user_recent_version_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_version_data_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_version_dto.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:collection/collection.dart';

class UserVersionRepositoryImpl extends UserVersionRepository {
  final UserVersionDataSource _userVersionDataSource;

  UserVersionRepositoryImpl(this._userVersionDataSource);

  @override
  Future<List<Version>> getUserVersionsFromSongbook(int songbookId) async {
    if (songbookId == ListType.recents.localId) {
      return (await _userVersionDataSource.getVersionsFromRecentSongbook()).map((e) => e.toDomain()).toList();
    } else {
      return (await _userVersionDataSource.getVersionsFromSongbook(songbookId)).map((e) => e.toDomain()).toList();
    }
  }

  @override
  Future<List<int>> putVersionsToSongbook(List<Version> versions, int songbookId) async {
    if (songbookId == ListType.recents.localId) {
      return putVersionsToRecentSongbook(versions);
    }

    final order = await _userVersionDataSource.getTotalSongbookVersions(songbookId).first;

    return _userVersionDataSource.putVersionsToSongbook(
      versions
          .mapIndexed((index, version) => UserVersionDto.fromDomain(
                version,
                songbookId,
                version.order == -1 ? order + index : null,
              ))
          .toList(),
    );
  }

  @override
  Future<List<int>> putVersionsToRecentSongbook(List<Version> versions) {
    return _userVersionDataSource.putVersionsToRecentSongbook(
      versions.map(UserRecentVersionDto.fromDomain).toList(),
    );
  }

  @override
  Future<int?> getLocalDatabaseIdFromSongIdInRecentSongbook(int songId) {
    return _userVersionDataSource.getLocalDatabaseIdFromSongIdInRecentSongbook(songId);
  }

  @override
  Future<void> clearAllVersions() {
    return _userVersionDataSource.clearAllVersions();
  }

  @override
  Stream<int> getTotalSongbookVersions(int songbookId) {
    return _userVersionDataSource.getTotalSongbookVersions(songbookId);
  }

  @override
  Future<int> getTotalRecentVersions() {
    return _userVersionDataSource.getTotalRecentVersions();
  }

  @override
  Future<List<String?>> getImagesPreview(int songbookId) {
    return _userVersionDataSource.getImagesPreview(songbookId);
  }

  @override
  Future<int?> deleteVersionsBySongbookId(int songbookId) {
    if (songbookId == ListType.recents.localId) {
      return _userVersionDataSource.deleteRecentVersions();
    } else {
      return _userVersionDataSource.deleteVersions(songbookId);
    }
  }

  @override
  Future<int?> deleteVersionsById(List<int> localDatabaseIds, int songbookId) {
    return _userVersionDataSource.deleteVersionsById(localDatabaseIds, songbookId);
  }

  @override
  Future<bool> deleteOldestRecentVersion() {
    return _userVersionDataSource.deleteOldestRecentVersion();
  }

  @override
  Stream<List<Version>> getVersionsStreamFromSongbook(int songbookId) {
    if (songbookId == ListType.recents.localId) {
      return _userVersionDataSource
          .getVersionsStreamFromRecentSongbook()
          .map((event) => event.map((e) => e.toDomain()).toList());
    } else {
      return _userVersionDataSource
          .getVersionsStreamFromSongbook(songbookId)
          .map((event) => event.map((e) => e.toDomain()).toList());
    }
  }

  @override
  Future<List<int>> updateVersionsToSongbook(List<Version> versions, int songbookId) async {
    return _userVersionDataSource.putVersionsToSongbook(
      versions.map((e) => UserVersionDto.fromDomain(e, songbookId)).toList(),
    );
  }

  @override
  Stream<bool> getIsFavoriteVersionBySongIdStream(int songId) {
    return _userVersionDataSource.getIsFavoriteVersionBySongIdStream(songId);
  }

  @override
  Future<int> addVersionData({
    required VersionData versionData,
    required int versionLocalDatabaseId,
    required int songbookId,
  }) {
    return _userVersionDataSource.addVersionData(UserVersionDataDto.fromDomain(
      versionData: versionData,
      versionLocalDatabaseId: versionLocalDatabaseId,
      songbookId: songbookId,
    ));
  }
}
