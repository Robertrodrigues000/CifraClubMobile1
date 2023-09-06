// coverage:ignore-file
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/youtube/models/youtube_video.dart';
import 'package:cifraclub/domain/youtube/repository/youtube_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class GetYouTubeVideos {
  final YouTubeRepository _repository;

  const GetYouTubeVideos(this._repository);

  Future<Result<List<YouTubeVideo>, RequestError>> call({required String artistName, required String songName}) async {
    return _repository.getYouTubeVideos("$artistName - $songName");
  }
}
