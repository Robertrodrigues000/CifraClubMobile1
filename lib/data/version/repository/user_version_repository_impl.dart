import 'package:cifraclub/data/version/data_source/user_version_data_source.dart';
import 'package:cifraclub/data/version/models/user_version_dto.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:cifraclub/domain/version/models/version.dart';

class UserVersionRepositoryImpl extends UserVersionRepository {
  final UserVersionDataSource _userVersionDataSource;

  UserVersionRepositoryImpl(this._userVersionDataSource);

  @override
  Future<List<Version>> getUserVersionsFromSongbook(int songbookId) async {
    return (await _userVersionDataSource.getVersionsFromSongbook(songbookId)).map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<int>> addVersionToSongbook(List<Version> versions, int songbookId) {
    return _userVersionDataSource.addVersionsToSongbook(
      versions.map((e) => UserVersionDto.fromDomain(e, songbookId)).toList(),
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
    return _userVersionDataSource.deleteVersions(songbookId);
  }

  @override
  Future<int?> deleteVersionsById(List<int> songsId) {
    return _userVersionDataSource.deleteVersionsById(songsId);
  }

  @override
  Stream<List<Version>> getVersionsStreamFromSongbook(int songbookId) {
    return _userVersionDataSource
        .getVersionsStreamFromSongbook(songbookId)
        .map((event) => event.map((e) => e.toDomain()).toList());
  }
}
