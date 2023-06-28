import 'package:cifraclub/domain/version/models/version.dart';

abstract class UserVersionRepository {
  Future<List<int>> addVersionToSongbook(List<Version> versions, int songbookId);
  Future<List<Version>> getUserVersionsFromSongbook(int songbookId);
  Future<void> clearAllVersions();
  Stream<int> getTotalSongbookVersions(int songbookId);
  Future<List<String?>> getImagesPreview(int songbookId);
  Future<int?> deleteVersionsBySongbookId(int songbookId);
}
