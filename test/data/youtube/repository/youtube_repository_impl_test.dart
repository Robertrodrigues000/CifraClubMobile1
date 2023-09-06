import 'package:cifraclub/data/youtube/data_source/youtube_data_source.dart';
import 'package:cifraclub/data/youtube/models/search/youtube_search_item_dto.dart';
import 'package:cifraclub/data/youtube/models/search/youtube_search_items_dto.dart';
import 'package:cifraclub/data/youtube/models/search/youtube_video_id_dto.dart';
import 'package:cifraclub/data/youtube/models/search/youtube_video_image_dto.dart';
import 'package:cifraclub/data/youtube/models/search/youtube_video_images_dto.dart';
import 'package:cifraclub/data/youtube/models/search/youtube_video_snippet_dto.dart';
import 'package:cifraclub/data/youtube/models/video/youtube_video_content_details_dto.dart';
import 'package:cifraclub/data/youtube/models/video/youtube_video_item_dto.dart';
import 'package:cifraclub/data/youtube/models/video/youtube_video_items_dto.dart';
import 'package:cifraclub/data/youtube/models/video/youtube_video_statistics_dto.dart';
import 'package:cifraclub/data/youtube/repository/youtube_repository_impl.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

class _YouTubeDataSourceMock extends Mock implements YouTubeDataSource {}

void main() {
  final dataSource = _YouTubeDataSourceMock();

  const youtubeVideoItemsDto = YouTubeVideoItemsDto([
    YouTubeVideoItemDto(
      "sasYdfhjs1",
      YouTubeVideoContentDetailsDto("PT1H10M22S"),
      YouTubeVideoStatisticsDto("11000"),
    )
  ]);

  const youtubeSearchItemsDto = YouTubeSearchItemsDto([
    YouTubeSearchItemDto(
      YouTubeVideoIdDto("sasYdfhjs1"),
      YouTubeVideoSnippetDto(
        "Teste",
        YouTubeVideoImagesDto(YouTubeVideoImageDto("https://example.com/size50.jpg")),
      ),
    )
  ]);

  test("When all request is success should return list of YouTubeVideo", () async {
    when(() => dataSource.search(any())).thenAnswer((_) => SynchronousFuture(const Ok(youtubeSearchItemsDto)));
    when(() => dataSource.getVideos(any())).thenAnswer((_) => SynchronousFuture(const Ok(youtubeVideoItemsDto)));

    final repository = YouTubeRepositoryImpl(dataSource);
    final result = await repository.getYouTubeVideos("Gabriela Rocha - Me Atraiu");

    expect(result.get()!.first.videoId, "sasYdfhjs1");
    expect(result.get()!.first.viewCount, "11000");
    expect(result.get()!.first.duration, 4222); // 3600 * 1 + 60 * 10 + 22 = 4222
    expect(result.get()!.first.imageUrl, "https://example.com/size50.jpg");
    expect(result.get()!.first.title, "Teste");
    verify(() => dataSource.search("Gabriela Rocha - Me Atraiu")).called(1);
    verify(() => dataSource.getVideos(["sasYdfhjs1"])).called(1);
  });

  test("When 'searchYouTubeVideos' fails should return error", () async {
    when(() => dataSource.search(any())).thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    final repository = YouTubeRepositoryImpl(dataSource);
    final result = await repository.getYouTubeVideos("Gabriela Rocha - Me Atraiu");

    expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "statusCode", 404));
    verify(() => dataSource.search("Gabriela Rocha - Me Atraiu")).called(1);
    verifyNever(() => dataSource.getVideos(any()));
  });

  test("When 'getYouTubeVideos' fails should return error", () async {
    when(() => dataSource.search(any())).thenAnswer((_) => SynchronousFuture(const Ok(youtubeSearchItemsDto)));
    when(() => dataSource.getVideos(any())).thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    final repository = YouTubeRepositoryImpl(dataSource);
    final result = await repository.getYouTubeVideos("Gabriela Rocha - Me Atraiu");

    expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "statusCode", 404));
    verify(() => dataSource.search("Gabriela Rocha - Me Atraiu")).called(1);
    verify(() => dataSource.getVideos(["sasYdfhjs1"])).called(1);
  });
}
