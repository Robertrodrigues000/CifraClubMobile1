import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/models/songbook_version_input.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:typed_result/typed_result.dart';

abstract class SongbookRepository {
  Future<Result<Songbook, RequestError>> addSongbook({
    required String name,
    required bool isPublic,
    required DateTime createdAt,
  });
  Future<Result<List<({Songbook songbook, List<Version> versions})>, RequestError>> getAllSongbooks();
  Future<Result<void, RequestError>> deleteSongbook(int songbookId);
  Future<Result<void, RequestError>> updateSongbookData({
    required int songbookId,
    String? name,
    required bool isPublic,
    required DateTime lastUpdated,
  });
  Future<Result<void, RequestError>> deleteVersions({required int songbookId, required List<int> versionsId});
  Future<Result<List<Version>, RequestError>> addVersionsToSongbook({
    required int songbookId,
    required List<SongbookVersionInput> versionsInput,
  });
  Future<Result<Version, RequestError>> addVersionToSongbook({
    required int songbookId,
    required SongbookVersionInput versionInput,
  });
  Future<Result<void, RequestError>> sortVersionFromSongbook({required int songbookId, required List<int> versionsId});
}
