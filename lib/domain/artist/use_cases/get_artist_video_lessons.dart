// coverage:ignore-file
import 'package:cifraclub/domain/artist/repository/artist_repository.dart';
import 'package:cifraclub/domain/home/models/video_lesson.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class GetArtistVideoLessons {
  final ArtistRepository _artistRepository;

  GetArtistVideoLessons(this._artistRepository);

  Future<Result<List<VideoLesson>, RequestError>> call(String artistDns) {
    return _artistRepository.getArtistVideoLessons(artistDns);
  }
}
