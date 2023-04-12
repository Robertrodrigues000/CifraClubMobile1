import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:typed_result/typed_result.dart';

abstract class SongbookRepository {
  Stream<List<Songbook>> getAllUserSongbooks();
  Future<int> insertUserSongbook(Songbook songbook);
  Future<Result<List<Songbook>, RequestError>> getAllSongbooks();
}
