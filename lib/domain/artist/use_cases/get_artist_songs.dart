// coverage:ignore-file
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

  Future<Result<List<ArtistSong>, RequestError>> call({required String artistUrl, ArtistSongFilter? filter}) =>
      artistRepository.getArtistSongs(artistUrl: artistUrl, filter: filter);
}
