import 'package:async/async.dart' hide Result;
import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/artist/models/artist_song_filter.dart';
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
  CancelableOperation<Result<PaginatedList<Artist>, RequestError>> getTopArtists(
      {String? genreUrl, required int limit, required int offset}) {
    return artistDataSource
        .getTopArtists(genreUrl: genreUrl, limit: limit, offset: offset)
        .then((result) => result.map((topArtistsDto) => topArtistsDto.toDomain()));
  }

  @override
  CancelableOperation<Result<List<ArtistSong>, RequestError>> getArtistSongs(
      {required String artistUrl, required int limit, ArtistSongFilter? filter}) {
    return artistDataSource
        .getArtistSongs(artistUrl: artistUrl, limit: limit, filter: filter)
        .then((result) => result.map((artistSongDto) => artistSongDto.toDomain()));
  }
}
