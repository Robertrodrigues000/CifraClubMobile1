// coverage:ignore-file
import 'package:async/async.dart' hide Result;
import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/artist/models/artist_song_filter.dart';
import 'package:cifraclub/domain/artist/repository/artist_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class GetArtistSongs {
  final ArtistRepository artistRepository;

  GetArtistSongs({
    required this.artistRepository,
  });

  CancelableOperation<Result<List<ArtistSong>, RequestError>> call(
      {required String artistUrl, int limit = 20, ArtistSongFilter? filter}) {
    return artistRepository.getArtistSongs(artistUrl: artistUrl, limit: limit, filter: filter).then((result) {
      if (result.isSuccess && result.get()!.isEmpty) {
        return Err(ServerError());
      }
      return result;
    });
  }
}
