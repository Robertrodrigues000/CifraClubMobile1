import 'package:async/async.dart' hide Result;
import 'package:cifraclub/domain/shared/paginated_list.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/song/models/song.dart';
import 'package:typed_result/typed_result.dart';

abstract class SongRepository {
  CancelableOperation<Result<PaginatedList<Song>, RequestError>> getTopSongs({
    String? genreUrl,
    required int limit,
    required int offset,
  });
  Future<Result<void, RequestError>> sendEmail(String email, String url);
}
