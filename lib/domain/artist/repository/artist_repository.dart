import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/shared/paginated_list.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

abstract class ArtistRepository {
  Future<Result<PaginatedList<Artist>, RequestError>> getTopArtists({
    String? genreUrl,
    required int limit,
    required int offset,
  });
}