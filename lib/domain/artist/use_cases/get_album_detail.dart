// coverage:ignore-file
import 'package:cifraclub/domain/artist/models/album_detail.dart';
import 'package:cifraclub/domain/artist/repository/artist_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class GetAlbumDetail {
  final ArtistRepository artistRepository;

  GetAlbumDetail({
    required this.artistRepository,
  });

  Future<Result<AlbumDetail, RequestError>> call({required String artistUrl, required String albumUrl}) {
    return artistRepository.getAlbumDetail(artistUrl: artistUrl, albumUrl: albumUrl);
  }
}
