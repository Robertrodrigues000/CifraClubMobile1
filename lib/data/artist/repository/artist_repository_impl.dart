import 'package:typed_result/typed_result.dart';

import 'package:cifraclub/data/artist/data_source/artist_data_source.dart';
import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/artist/repository/artist_repository.dart';
import 'package:cifraclub/domain/shared/paginated_list.dart';
import 'package:cifraclub/domain/shared/request_error.dart';

class ArtistRepositoryImpl extends ArtistRepository {
  ArtistDataSource artistDataSource;

  ArtistRepositoryImpl({
    required this.artistDataSource,
  });

  @override
  Future<Result<PaginatedList<Artist>, RequestError>> getTopArtists(
      {String? genreUrl, required int limit, required int offset}) async {
    return (await artistDataSource.getTopArtists(genreUrl: genreUrl, limit: limit, offset: offset))
        .map((value) => value.toDomain());
  }
}
