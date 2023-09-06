import 'dart:io';

import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/youtube/data_source/youtube_data_source.dart';
import 'package:cifraclub/data/youtube/models/search/youtube_search_items_dto.dart';
import 'package:cifraclub/data/youtube/models/video/youtube_video_items_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/data/clients/http/network_service_mock.dart';

void main() {
  group("When search is called", () {
    test("and request is successful", () async {
      final networkService = NetworkServiceMock();
      final youtubeDataSource = YouTubeDataSource(networkService);

      final mockResponse = await File("test/data/youtube/data_source/youtube_search_json_response.json").readAsString();
      await networkService.mock<YouTubeSearchItemsDto>(response: mockResponse);

      final result = await youtubeDataSource.search("Gabriela Rocha - Me Atraiu");

      final request = verify(() => networkService.execute<YouTubeSearchItemsDto>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<YouTubeSearchItemsDto>;

      expect(request.path, "https://gapi.cifraclub.com.br/youtube/v3/search");
      expect(request.queryParams, {
        "part": "snippet",
        "maxResults": 10,
        "order": "relevance",
        "type": "video",
        "q": "Gabriela Rocha - Me Atraiu",
        "key": "AIzaSyBbzM-yYzmQsveZcksn8UswSCIPk5u_qas",
      });
      expect(request.type, NetworkRequestType.get);

      expect(result.isSuccess, true);
      expect(result.get()!.items.first.youTubeVideoId.videoId, "Z6cONvRUFZQ");
      expect(result.get()!.items.first.youTubeVideoSnippet.title, "GABRIELA ROCHA - ME ATRAIU (AO VIVO)");
      expect(
        result.get()!.items.first.youTubeVideoSnippet.youTubeVideoImages.images.url,
        "https://i.ytimg.com/vi/Z6cONvRUFZQ/mqdefault.jpg",
      );
    });

    test("and request fails", () async {
      final networkService = NetworkServiceMock();

      when(() => networkService.execute<YouTubeSearchItemsDto>(request: captureAny(named: "request"))).thenAnswer(
        (_) => SynchronousFuture(Err(ServerError(statusCode: 404))),
      );

      final songbookDataSource = YouTubeDataSource(networkService);
      final result = await songbookDataSource.search("");

      expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "statusCode", 404));
    });
  });

  group("When getVideos is called", () {
    test("and request is successful", () async {
      final networkService = NetworkServiceMock();
      final youtubeDataSource = YouTubeDataSource(networkService);

      final mockResponse = await File("test/data/youtube/data_source/youtube_video_json_reponse.json").readAsString();
      await networkService.mock<YouTubeVideoItemsDto>(response: mockResponse);

      final result = await youtubeDataSource.getVideos(["Z6cONvRUFZQ", "wQBPsVJVTGI"]);

      final request = verify(() => networkService.execute<YouTubeVideoItemsDto>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<YouTubeVideoItemsDto>;

      expect(request.path, "https://gapi.cifraclub.com.br/youtube/v3/videos");
      expect(request.queryParams, {
        "part": "statistics,contentDetails",
        "id": "Z6cONvRUFZQ,wQBPsVJVTGI",
        "fields": "items",
        "key": "AIzaSyBbzM-yYzmQsveZcksn8UswSCIPk5u_qas",
      });
      expect(request.type, NetworkRequestType.get);

      expect(result.isSuccess, true);
      expect(result.get()!.items.first.id, "Z6cONvRUFZQ");
      expect(result.get()!.items.first.statistics.viewCount, "108992794");
      expect(result.get()!.items.first.contentDetails.duration, "PT8M28S");
      expect(result.get()!.items.last.id, "wQBPsVJVTGI");
      expect(result.get()!.items.last.statistics.viewCount, "3109389");
      expect(result.get()!.items.last.contentDetails.duration, "PT8M46S");
    });

    test("and request fails", () async {
      final networkService = NetworkServiceMock();

      when(() => networkService.execute<YouTubeVideoItemsDto>(request: captureAny(named: "request"))).thenAnswer(
        (_) => SynchronousFuture(Err(ServerError(statusCode: 404))),
      );

      final songbookDataSource = YouTubeDataSource(networkService);
      final result = await songbookDataSource.getVideos(["Z6cONvRUFZQ", "wQBPsVJVTGI"]);

      expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "statusCode", 404));
    });
  });
}
