import 'package:cifraclub/data/youtube/data_source/youtube_data_source.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/youtube/models/youtube_video.dart';
import 'package:cifraclub/domain/youtube/repository/youtube_repository.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@Injectable(as: YouTubeRepository)
class YouTubeRepositoryImpl implements YouTubeRepository {
  final YouTubeDataSource _dataSource;

  const YouTubeRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<YouTubeVideo>, RequestError>> getYouTubeVideos(String query) {
    final RegExp regex = RegExp(r'PT((?<HOUR>\d+)H)?((?<MINUTE>\d+)M)?((?<SECOND>\d+)S)?');

    return _dataSource.search(query).then(
      (searchItems) async {
        if (searchItems.isSuccess) {
          final videosIds = searchItems.get()!.items.map((e) => e.youTubeVideoId.videoId).toList(growable: false);
          final videoItems = await _dataSource.getVideos(videosIds);

          if (videoItems.isSuccess) {
            return Ok(
              videoItems.get()!.items.mapIndexed(
                (index, element) {
                  return YouTubeVideo(
                    videoId: element.id,
                    title: searchItems.get()!.items[index].youTubeVideoSnippet.title,
                    viewCount: element.statistics.viewCount,
                    duration: _parseToSeconds(element.contentDetails.duration, regex),
                    imageUrl: searchItems.get()!.items[index].youTubeVideoSnippet.youTubeVideoImages.images.url,
                  );
                },
              ).toList(),
            );
          }
          return Err(videoItems.getError()!);
        }
        return Err(searchItems.getError()!);
      },
    );
  }

  int _parseToSeconds(String durationPattern, RegExp regExp) {
    final match = regExp.firstMatch(durationPattern);

    if (match != null) {
      int? hours = int.tryParse(match.namedGroup('HOUR') ?? "");
      int? minutes = int.tryParse(match.namedGroup('MINUTE') ?? "");
      int? seconds = int.tryParse(match.namedGroup('SECOND') ?? "");

      return Duration(hours: hours ?? 0, minutes: minutes ?? 0, seconds: seconds ?? 0).inSeconds;
    } else {
      throw ArgumentError("Invalid pattern");
    }
  }
}
