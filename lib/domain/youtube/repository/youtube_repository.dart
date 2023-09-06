import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/youtube/models/youtube_video.dart';
import 'package:typed_result/typed_result.dart';

abstract class YouTubeRepository {
  Future<Result<List<YouTubeVideo>, RequestError>> getYouTubeVideos(String query);
}
