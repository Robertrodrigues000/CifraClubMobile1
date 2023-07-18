// coverage:ignore-file
import 'package:cifraclub/domain/artist/repository/artist_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class GetIsArtistFan {
  final ArtistRepository artistRepository;

  GetIsArtistFan({
    required this.artistRepository,
  });

  Future<Result<bool, RequestError>> call({required String artistUrl, required int userId}) {
    return artistRepository.getIsArtistFan(artistUrl: artistUrl, userId: userId);
  }
}
