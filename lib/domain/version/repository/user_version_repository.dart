import 'package:cifraclub/domain/version/models/version.dart';

abstract class UserVersionRepository {
  Future<List<int>> addVersionsToSongbook(List<Version> versions, int songbookId);
  Future<List<int>> addVersionsToRecentSongbook(List<Version> versions);
  Future<List<Version>> getUserVersionsFromSongbook(int songbookId);
  Future<void> clearAllVersions();
  Stream<int> getTotalSongbookVersions(int songbookId);
  Future<List<String?>> getImagesPreview(int songbookId);
  Future<int?> deleteVersionsBySongbookId(int songbookId);
  Future<int?> deleteVersionsById(List<int> songsId);
  Stream<List<Version>> getVersionsStreamFromSongbook(int songbookId);
  Future<List<int>> updateVersionsToSongbook(List<Version> versions, int songbookId);
}
