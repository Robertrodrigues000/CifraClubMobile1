import 'package:async/async.dart' hide Result;
import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/artist/models/artist_song_filter.dart';
import 'package:cifraclub/domain/shared/paginated_list.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

abstract class ArtistRepository {
  CancelableOperation<Result<PaginatedList<Artist>, RequestError>> getTopArtists({
    String? genreUrl,
    required int limit,
    required int offset,
  });

  CancelableOperation<Result<List<ArtistSong>, RequestError>> getArtistSongs(
      {required String artistUrl, required int limit, ArtistSongFilter? filter});
}
