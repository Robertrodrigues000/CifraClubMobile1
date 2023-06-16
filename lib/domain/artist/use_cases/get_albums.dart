// coverage:ignore-file
import 'package:cifraclub/domain/artist/models/album.dart';
import 'package:cifraclub/domain/artist/repository/artist_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class GetAlbums {
  final ArtistRepository artistRepository;

  GetAlbums({
    required this.artistRepository,
  });

  Future<Result<List<Album>, RequestError>> call(String artistUrl) {
    return artistRepository.getAlbums(artistUrl: artistUrl);
  }
}
