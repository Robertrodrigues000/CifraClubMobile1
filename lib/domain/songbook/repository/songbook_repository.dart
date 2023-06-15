import 'package:cifraclub/domain/cifra/models/cifra.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:typed_result/typed_result.dart';

abstract class SongbookRepository {
  Future<Result<Songbook, RequestError>> insertSongbook({
    required String name,
    required bool isPublic,
    required DateTime createdAt,
  });
  Future<Result<List<({Songbook songbook, List<Cifra> cifras})>, RequestError>> getAllSongbooks();
  Future<Result<void, RequestError>> deleteSongbook(int songbookId);
  Future<Result<void, RequestError>> updateSongbookData({
    required int songbookId,
    String? name,
    required bool isPublic,
    required DateTime lastUpdated,
  });
  Future<Result<void, RequestError>> deleteCifras({required int songbookId, required List<int> cifrasIds});
}
