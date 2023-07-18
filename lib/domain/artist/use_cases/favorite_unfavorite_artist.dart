// coverage:ignore-file
import 'package:cifraclub/domain/artist/repository/artist_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class FavoriteUnfavoriteArtist {
  final ArtistRepository artistRepository;

  FavoriteUnfavoriteArtist({
    required this.artistRepository,
  });

  Future<Result<void, RequestError>> call({required String artistUrl, required bool isFavorite}) async {
    if (isFavorite) {
      return artistRepository.favoriteArtist(artistUrl: artistUrl);
    } else {
      return artistRepository.unfavoriteArtist(artistUrl: artistUrl);
    }
  }
}
