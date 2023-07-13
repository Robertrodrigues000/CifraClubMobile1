import 'package:cifraclub/data/version/data_source/user_version_data_source.dart';
import 'package:cifraclub/data/version/models/user_version_dto.dart';
import 'package:cifraclub/data/version/models/user_recent_version_dto.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:cifraclub/domain/version/models/version.dart';

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
  Future<List<int>> addVersionToSongbook(List<Version> versions, int songbookId) {
    return _userVersionDataSource.addVersionsToSongbook(
      versions.map((e) => UserVersionDto.fromDomain(e, songbookId)).toList(),
    );
  }

  @override
  Future<List<int>> addVersionToRecentSongbook(List<Version> versions) {
    return _userVersionDataSource.addVersionsToRecentSongbook(
      versions.map(UserRecentVersionDto.fromDomain).toList(),
    );
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
  Future<int?> deleteVersionsById(List<int> songsId) {
    return _userVersionDataSource.deleteVersionsById(songsId);
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
}
