import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';

abstract class UserVersionRepository {
  Future<List<int>> putVersionsToSongbook(List<Version> versions, int songbookId);
  Future<List<int>> putVersionsToRecentSongbook(List<Version> versions);
  Future<int?> getLocalDatabaseIdFromSongIdInRecentSongbook(int songId);
  Future<List<Version>> getUserVersionsFromSongbook(int songbookId);
  Future<void> clearAllVersions();
  Stream<int> getTotalSongbookVersions(int songbookId);
  Future<int> getTotalRecentVersions();
  Future<List<String?>> getImagesPreview(int songbookId);
  Future<int?> deleteVersionsBySongbookId(int songbookId);
  Future<int?> deleteVersionsById(List<int> localDatabaseIds, int songbookId);
  Future<bool?> deleteVersionBySongId(int songId, int songbookId);
  Future<bool> deleteOldestRecentVersion();
  Stream<List<Version>> getVersionsStreamFromSongbook(int songbookId);
  Future<List<int>> updateVersionsToSongbook(List<Version> versions, int songbookId);
  Stream<bool> getIsFavoriteVersionBySongIdStream(int songId);
  Future<int> addVersionData({
    required VersionData versionData,
    required int versionLocalDatabaseId,
    required int songbookId,
  });
  Future<bool> getIsVersionOnSongbook(int songbookId, int versionId);
}
