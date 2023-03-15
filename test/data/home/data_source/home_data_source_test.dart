import 'dart:io';

import 'package:async/async.dart' hide Result;
import 'package:cifraclub/data/artist/models/artist_dto.dart';
import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/home/data_souce/home_data_source.dart';
import 'package:cifraclub/data/home/models/highlight/highlight_dto.dart';
import 'package:cifraclub/data/home/models/highlight/highlights_dto.dart';
import 'package:cifraclub/data/home/models/highlight/photo_dto.dart';
import 'package:cifraclub/data/home/models/highlight/photos_dto.dart';
import 'package:cifraclub/data/home/models/home_dto.dart';
import 'package:cifraclub/data/home/models/news/news_dto.dart';
import 'package:cifraclub/data/home/models/video_lessons/video_lessons_dto.dart';
import 'package:cifraclub/data/song/models/song_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/data/clients/http/network_service_mock.dart';

void main() {
  final highlightDto = HighlightDto(
    url: "/jimi-hendrix/purple-haze/",
    title: "Jimi Hendrix",
    subtitle: "Purple Haze",
    description: "O melhor que nós temos!",
    imageDescription: "Na imagem, foto do guitarrista Jimi Hendrix.",
    photos: PhotosDto(
      app: const PhotoDto(
        small: "https://akamai.sscdn.co/gcs/cifraclub/destaques/5/3/e/f/d9559191677089838_x3_app.jpeg",
        medium: "https://akamai.sscdn.co/gcs/cifraclub/destaques/1/8/c/c/d9559191677089837_x2_app.jpeg",
        large: "https://akamai.sscdn.co/gcs/cifraclub/destaques/d/b/a/5/d9559191677089837_x1_app.jpeg",
      ),
    ),
    icon: "guitarra",
  );

  const songDto = SongDto(id: 738834, name: "Deserto", url: "deserto", isVerified: false);
  const artistDto = ArtistDto(url: "bruno-e-marrone", image: null, name: "Bruno e Marrone", id: 6908);
  const newsDto = NewsDto(
    url: "https://www.cifraclub.com.br/blog/cifras-simplificadas-jorge-e-mateus/",
    image:
        "https://akamai.sscdn.co/tb/cifra-blog/pt/wp-content/uploads/2023/02/a591cc2-cifras-simplificadas-de-jorge-e-mateus.png",
    thumb: null,
    headline: "Aprenda 20 cifras simplificadas de Jorge e Mateus",
    publishDate: "2023-02-22 11:02:00",
  );
  const videoLessonsDto = VideoLessonsDto(
    id: 5583,
    youtubeId: "tuFfT0ycVNA",
    title: "COMO TOCAR I'LL BE THERE FOR YOU DO BON JOVI NA GUITARRA",
    url: "bon-jovi-ill-be-there-for-you-aula-de-guitarra-completa",
    views: 174,
    duration: 508,
    urlApi: "/bon-jovi/ill-be-there-for-you",
    images: null,
    instruments: ["electric-guitar"],
  );

  final homeDto = HomeDto(
    highlights: HighlightsDto(highlights: [highlightDto]),
    songs: const [songDto],
    artists: const [artistDto],
    videoLessons: const [videoLessonsDto],
    news: const [newsDto],
  );

  group("When `getHomeInfos` is called", () {
    test("When request is success without param, should return HomeDto", () async {
      final networkService = NetworkServiceMock();
      final mockResponse = await File("test/data/home/data_source/home_mock_json_response.json").readAsString();
      await networkService.mock<HomeDto>(response: mockResponse);

      final dataSource = HomeDataSource(networkService);
      final result = await dataSource.getHomeInfos(null).value;

      final request = verify(() => networkService.cancelableExecute<HomeDto>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<HomeDto>;

      expect(request.path, "/v3/home/");
      expect(request.type, NetworkRequestType.get);

      expect(result.isSuccess, true);
      expect(result.get(), homeDto);
    });

    test("When request is success with param, should return HomeDto", () async {
      const dns = "sertanejo";

      final networkService = NetworkServiceMock();
      final mockResponse = await File("test/data/home/data_source/home_mock_json_response.json").readAsString();
      await networkService.mock<HomeDto>(response: mockResponse);

      final dataSource = HomeDataSource(networkService);
      final result = await dataSource.getHomeInfos(dns).value;

      final request = verify(() => networkService.cancelableExecute<HomeDto>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<HomeDto>;

      expect(request.path, "/v3/home/sertanejo");
      expect(request.type, NetworkRequestType.get);

      expect(result.isSuccess, true);
      expect(result.get(), homeDto);
    });

    test("When request failure, should return server error", () async {
      final networkService = NetworkServiceMock();
      final mockResponse = await File("test/data/home/data_source/home_mock_json_response.json").readAsString();
      await networkService.mock<HomeDto>(response: mockResponse);

      when(() => networkService.cancelableExecute<HomeDto>(request: captureAny(named: "request"))).thenAnswer(
        (invocation) => CancelableOperation.fromFuture(SynchronousFuture(Err(ServerError()))),
      );

      final dataSource = HomeDataSource(networkService);
      final result = await dataSource.getHomeInfos(null).value;

      final request = verify(() => networkService.cancelableExecute<HomeDto>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<HomeDto>;

      expect(request.path, "/v3/home/");
      expect(request.type, NetworkRequestType.get);

      expect(result.isSuccess, false);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, null);
    });
  });
}
