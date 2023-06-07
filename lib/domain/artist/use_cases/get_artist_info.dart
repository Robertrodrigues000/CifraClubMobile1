// coverage:ignore-file
import 'package:cifraclub/domain/artist/models/artist_info.dart';
import 'package:cifraclub/domain/artist/repository/artist_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class GetArtistInfo {
  final ArtistRepository artistRepository;

  GetArtistInfo({
    required this.artistRepository,
  });

  Future<Result<ArtistInfo, RequestError>> call(String artistUrl) {
    return artistRepository.getArtistInfo(artistUrl: artistUrl);
  }
}
