import 'dart:io';

import 'package:async/async.dart' hide Result;
import 'package:cifraclub/data/artist/data_source/artist_data_source.dart';
import 'package:cifraclub/data/artist/models/album_detail_dto.dart';
import 'package:cifraclub/data/artist/models/albums_dto.dart';
import 'package:cifraclub/data/artist/models/artist_fan_dto.dart';
import 'package:cifraclub/data/artist/models/artist_info_dto.dart';
import 'package:cifraclub/data/artist/models/artist_songs_dto.dart';
import 'package:cifraclub/data/artist/models/top_artists_dto.dart';
import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/home/models/video_lessons/video_lesson_version_dto.dart';
import 'package:cifraclub/data/home/models/video_lessons/video_lessons_dto.dart';
import 'package:cifraclub/data/home/models/video_lessons/video_lessons_image_dto.dart';
import 'package:cifraclub/domain/artist/models/artist_song_filter.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/data/clients/http/network_service_mock.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(NetworkRequest<dynamic>(
      parser: (_) => throw Exception(""),
      path: "",
      type: NetworkRequestType.get,
    ));
  });

  group("When getTopArtists is called", () {
    test("When request is successful with params", () async {
      final queryParams = {
        'genre': 'mpb',
        'offset': 5,
        'limit': 3,
      };

      final networkService = NetworkServiceMock();
      final mockResponse =
          await File("test/data/artist/data_source/top_artists_mock_json_response.json").readAsString();
      await networkService.mock<TopArtistsDto>(response: mockResponse);

      final artistDataSource = ArtistDataSource(networkService: networkService);
      final result = await artistDataSource
          .getTopArtists(
            genreUrl: queryParams['genre'] as String,
            limit: queryParams['limit'] as int,
            offset: queryParams['offset'] as int,
          )
          .value;

      final request =
          verify(() => networkService.cancelableExecute<TopArtistsDto>(request: captureAny(named: "request")))
              .captured
              .first as NetworkRequest<TopArtistsDto>;

      expect(request.path, "/v3/top/artists");
      expect(request.type, NetworkRequestType.get);
      expect(request.queryParams, queryParams);

      expect(result.isSuccess, true);
      final topArtists = result.get()!;

      expect(topArtists.artists.length, 3);
      expect(topArtists.artists.first.id, 7507);
      expect(topArtists.artists.first.name, "Zé Ramalho");
      expect(topArtists.artists.first.url, "ze-ramalho");
      expect(topArtists.moreResults, true);
    });

    test("When request is successful without params", () async {
      final queryParams = {
        'limit': 10,
      };

      final networkService = NetworkServiceMock();
      final mockResponse =
          await File("test/data/artist/data_source/top_artists_mock_json_response.json").readAsString();
      await networkService.mock<TopArtistsDto>(response: mockResponse);

      final artistDataSource = ArtistDataSource(networkService: networkService);
      final result = await artistDataSource
          .getTopArtists(
            limit: queryParams['limit'] as int,
            offset: 0,
          )
          .value;

      final request =
          verify(() => networkService.cancelableExecute<TopArtistsDto>(request: captureAny(named: "request")))
              .captured
              .first as NetworkRequest<TopArtistsDto>;

      expect(request.path, "/v3/top/artists");
      expect(request.type, NetworkRequestType.get);
      expect(request.queryParams, queryParams);

      expect(result.isSuccess, true);
      final topArtists = result.get()!;

      expect(topArtists.artists.length, 3);
      expect(topArtists.artists.first.id, 7507);
      expect(topArtists.artists.first.name, "Zé Ramalho");
      expect(topArtists.artists.first.url, "ze-ramalho");
      expect(topArtists.moreResults, true);
    });

    test("When request fails", () async {
      final networkService = NetworkServiceMock();
      when(() => networkService.cancelableExecute<TopArtistsDto>(request: captureAny(named: "request"))).thenAnswer(
        (invocation) => CancelableOperation.fromFuture(
          SynchronousFuture(
            Err(ServerError(statusCode: 404)),
          ),
        ),
      );

      final artistDataSource = ArtistDataSource(networkService: networkService);
      final result = await artistDataSource
          .getTopArtists(
            limit: 10,
            offset: 0,
          )
          .value;

      expect(result.isFailure, true);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, 404);
    });
  });

  group("When getArtistInfo is called", () {
    const artistUrl = "bruno-e-marrone";
    test("When request is successful ", () async {
      final networkService = NetworkServiceMock();
      final mockResponse =
          await File("test/data/artist/data_source/artist_info_mock_json_response.json").readAsString();
      await networkService.mock<ArtistInfoDto>(response: mockResponse);

      final artistDataSource = ArtistDataSource(networkService: networkService);
      final result = await artistDataSource.getArtistInfo(artistUrl);

      final request = verify(() => networkService.execute<ArtistInfoDto>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<ArtistInfoDto>;

      expect(request.path, "/v3/artist/$artistUrl/info");
      expect(request.type, NetworkRequestType.get);
      expect(result.isSuccess, true);
      final artistInfo = result.get()!;

      expect(artistInfo.id, 6908);
      expect(artistInfo.name, "Bruno e Marrone");
      expect(artistInfo.url, "bruno-e-marrone");
      expect(artistInfo.hitsCount, 174581162);
    });
    test("When request fails", () async {
      final networkService = NetworkServiceMock();
      when(() => networkService.execute<ArtistInfoDto>(request: captureAny(named: "request")))
          .thenAnswer((invocation) => SynchronousFuture(
                Err(ServerError(statusCode: 404)),
              ));

      final artistDataSource = ArtistDataSource(networkService: networkService);
      final result = await artistDataSource.getArtistInfo(artistUrl);
      expect(result.isFailure, true);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, 404);
    });
  });
  group("When getArtistSongs is called", () {
    test("When request is successful with params", () async {
      const artistUrl = "gabriela-rocha";
      final queryParams = {
        'filter': ArtistSongFilter.cifra.name,
      };

      final networkService = NetworkServiceMock();
      final mockResponse =
          await File("test/data/artist/data_source/artist_songs_mock_json_response.json").readAsString();
      await networkService.mock<ArtistSongsDto>(response: mockResponse);

      final artistDataSource = ArtistDataSource(networkService: networkService);
      final result = await artistDataSource.getArtistSongs(
        artistUrl: artistUrl,
        filter: ArtistSongFilter.cifra,
      );

      final request = verify(() => networkService.execute<ArtistSongsDto>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<ArtistSongsDto>;
      expect(request.path, "/v3/artist/$artistUrl/songs?exclude=lyrics+files");
      expect(request.type, NetworkRequestType.get);
      expect(request.queryParams, queryParams);

      expect(result.isSuccess, true);
      final artistSongs = result.get()!;

      expect(artistSongs.songs.length, 2);
      expect(artistSongs.songs.first.id, 3098382);
      expect(artistSongs.songs.first.name, "Me Atraiu");
      expect(artistSongs.songs.first.url, "me-atraiu");
      expect(artistSongs.songs.first.verified, true);
    });

    test("When request fails", () async {
      final networkService = NetworkServiceMock();

      when(() => networkService.execute<ArtistSongsDto>(request: captureAny(named: "request"))).thenAnswer(
        (invocation) => SynchronousFuture(
          Err(ServerError(statusCode: 404)),
        ),
      );

      final artistDataSource = ArtistDataSource(networkService: networkService);
      final result = await artistDataSource.getArtistSongs(
        artistUrl: "legiao-urbana",
      );

      expect(result.isFailure, true);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, 404);
    });
  });

  group("When `getVideoLessons` is called", () {
    test("When request is successful with params", () async {
      const artistUrl = "the-beatles";

      final networkService = NetworkServiceMock();
      final mockResponse =
          await File("test/data/artist/data_source/artist_video_lessons_mock_json_response.json").readAsString();
      await networkService.mock<List<VideoLessonsDto>>(response: mockResponse);

      final artistDataSource = ArtistDataSource(networkService: networkService);
      final result = await artistDataSource.getVideoLessons(artistUrl: artistUrl);

      final request = verify(() => networkService.execute<List<VideoLessonsDto>>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<List<VideoLessonsDto>>;
      expect(request.path, "/v3/artist/$artistUrl/video-lessons");
      expect(request.type, NetworkRequestType.get);

      expect(result.isSuccess, true);
      final videoLessons = result.get()!;

      final versionDto = VideoLessonVersionDto(id: 12, type: 2, label: "principal");
      final videoLessonsDto = VideoLessonsDto(
        id: 5299,
        youtubeId: "GxCFTKpk6Rc",
        title: "COMO TOCAR SOMETHING DOS BEATLES NO BAIXO",
        url: "the-beatles-something-aula-de-baixo",
        views: 390,
        duration: 492,
        urlApi: "/the-beatles/something/tabs-baixo",
        images: VideoLessonsImageDto(
          image: "https://i3.ytimg.com/vi/GxCFTKpk6Rc/default.jpg",
          imagemq: "https://i3.ytimg.com/vi/GxCFTKpk6Rc/mqdefault.jpg",
          imagesd: "https://i3.ytimg.com/vi/GxCFTKpk6Rc/sddefault.jpg",
        ),
        instruments: const ["bass"],
        version: versionDto,
      );

      expect(videoLessons.length, 2);
      expect(videoLessons.first, videoLessonsDto);
    });

    test("When request fails", () async {
      const artistUrl = "the-beatles";

      final networkService = NetworkServiceMock();
      when(() => networkService.execute<List<VideoLessonsDto>>(request: captureAny(named: "request"))).thenAnswer(
        (invocation) => SynchronousFuture(
          Err(ServerError(statusCode: 404)),
        ),
      );

      final artistDataSource = ArtistDataSource(networkService: networkService);

      final result = await artistDataSource.getVideoLessons(artistUrl: artistUrl);

      final request = verify(() => networkService.execute<List<VideoLessonsDto>>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<List<VideoLessonsDto>>;
      expect(request.path, "/v3/artist/$artistUrl/video-lessons");
      expect(request.type, NetworkRequestType.get);

      expect(result.isFailure, true);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, 404);
    });
  });

  group("When getAlbums is called", () {
    test("When request is successful", () async {
      const artistUrl = "gabriela-rocha";

      final networkService = NetworkServiceMock();
      final mockResponse =
          await File("test/data/artist/data_source/artist_albums_mock_json_response.json").readAsString();
      await networkService.mock<AlbumsDto>(response: mockResponse);

      final artistDataSource = ArtistDataSource(networkService: networkService);
      final result = await artistDataSource.getAlbums(
        artistUrl: artistUrl,
      );

      final request = verify(() => networkService.execute<AlbumsDto>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<AlbumsDto>;
      expect(request.path, "/v3/artist/$artistUrl/albums");
      expect(request.type, NetworkRequestType.get);

      expect(result.isSuccess, true);
      final albums = result.get()!.albums;

      expect(albums.length, 2);
      expect(albums.first.id, 70487);
      expect(albums.first.albumUrl, "studio-bar-ao-vivo-2019");
      expect(albums.last.id, 75976);
      expect(albums.last.albumUrl, "studio-bar-vol-2-ao-vivo-2019");
    });

    test("When request fails", () async {
      final networkService = NetworkServiceMock();

      when(() => networkService.execute<AlbumsDto>(request: captureAny(named: "request"))).thenAnswer(
        (invocation) => SynchronousFuture(
          Err(ServerError(statusCode: 404)),
        ),
      );

      final artistDataSource = ArtistDataSource(networkService: networkService);
      final result = await artistDataSource.getAlbums(
        artistUrl: "legiao-urbana",
      );

      expect(result.isFailure, true);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, 404);
    });
  });

  group("When getAlbumDetail is called", () {
    test("When request is successful", () async {
      const artistUrl = "bruno-e-marrone";
      const albumUrl = "studio-bar-ao-vivo-2019";
      final networkService = NetworkServiceMock();
      final mockResponse =
          await File("test/data/artist/data_source/artist_album_detail_mock_json_response.json").readAsString();
      await networkService.mock<AlbumDetailDto>(response: mockResponse);

      final artistDataSource = ArtistDataSource(networkService: networkService);
      final result = await artistDataSource.getAlbumDetail(
        artistUrl: artistUrl,
        albumUrl: albumUrl,
      );

      final request = verify(() => networkService.execute<AlbumDetailDto>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<AlbumDetailDto>;
      expect(request.path, "/v3/album/$artistUrl/$albumUrl");
      expect(request.type, NetworkRequestType.get);

      expect(result.isSuccess, true);
      final albumDetail = result.get()!;

      expect(albumDetail.id, 70487);
      expect(albumDetail.discs.length, 1);
      expect(albumDetail.albumUrl, albumUrl);
      expect(albumDetail.artistUrl, artistUrl);
      expect(albumDetail.title, "Studio Bar (Ao Vivo)");
      expect(albumDetail.artistName, "Bruno e Marrone");
      expect(albumDetail.discs.first.songs.first.id, 471241);
      expect(albumDetail.discs.first.songs.first.name, "Gostinho de Cerveja");
    });

    test("When request fails", () async {
      const artistUrl = "bruno-e-marrone";
      const albumUrl = "studio-bar-ao-vivo-2019";
      final networkService = NetworkServiceMock();

      when(() => networkService.execute<AlbumDetailDto>(request: captureAny(named: "request"))).thenAnswer(
        (invocation) => SynchronousFuture(
          Err(ServerError(statusCode: 404)),
        ),
      );

      final artistDataSource = ArtistDataSource(networkService: networkService);
      final result = await artistDataSource.getAlbumDetail(
        artistUrl: artistUrl,
        albumUrl: albumUrl,
      );

      expect(result.isFailure, true);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, 404);
    });
  });

  group("When getIsArtistFan is called", () {
    const artistUrl = "bruno-e-marrone";
    const userId = 54054612;
    test("When request is successful ", () async {
      final networkService = NetworkServiceMock();
      final mockResponse =
          await File("test/data/artist/data_source/artist_user_is_fan_mock_json_response.json").readAsString();
      await networkService.mock<ArtistFanDto>(response: mockResponse);

      final artistDataSource = ArtistDataSource(networkService: networkService);
      final result = await artistDataSource.getIsArtistFan(artistUrl: artistUrl, userId: userId);

      final request = verify(() => networkService.execute<ArtistFanDto>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<ArtistFanDto>;

      expect(request.path, "/v3/user/$userId/is-fan/$artistUrl");
      expect(request.type, NetworkRequestType.get);
      expect(result.isSuccess, true);
      final artistFanDto = result.get()!;

      expect(artistFanDto.isFan, true);
    });
    test("When request fails", () async {
      final networkService = NetworkServiceMock();
      when(() => networkService.execute<ArtistFanDto>(request: captureAny(named: "request")))
          .thenAnswer((invocation) => SynchronousFuture(
                Err(ServerError(statusCode: 404)),
              ));

      final artistDataSource = ArtistDataSource(networkService: networkService);
      final result = await artistDataSource.getIsArtistFan(artistUrl: artistUrl, userId: userId);
      expect(result.isFailure, true);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, 404);
    });
  });

  group("When favoriteArtist is called", () {
    const artistUrl = "bruno-e-marrone";
    test("When request is successful ", () async {
      final networkService = NetworkServiceMock();

      when(() => networkService.execute<void>(request: captureAny(named: "request")))
          .thenAnswer((invocation) => SynchronousFuture(
                const Ok(null),
              ));

      final artistDataSource = ArtistDataSource(networkService: networkService);
      final result = await artistDataSource.favoriteArtist(artistUrl: artistUrl);

      final request = verify(() => networkService.execute<void>(request: captureAny(named: "request"))).captured.first
          as NetworkRequest<void>;

      expect(request.path, "/v3/artist/$artistUrl/favorite");
      expect(request.type, NetworkRequestType.post);
      expect(result.isSuccess, isTrue);
    });
    test("When request fails", () async {
      final networkService = NetworkServiceMock();
      when(() => networkService.execute<void>(request: captureAny(named: "request")))
          .thenAnswer((invocation) => SynchronousFuture(
                Err(ServerError(statusCode: 404)),
              ));

      final artistDataSource = ArtistDataSource(networkService: networkService);

      final result = await artistDataSource.favoriteArtist(artistUrl: artistUrl);

      expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "statusCode", 404));
    });
  });

  group("When unfavoriteArtist is called", () {
    const artistUrl = "bruno-e-marrone";
    test("When request is successful ", () async {
      final networkService = NetworkServiceMock();

      when(() => networkService.execute<void>(request: captureAny(named: "request")))
          .thenAnswer((invocation) => SynchronousFuture(
                const Ok(null),
              ));

      final artistDataSource = ArtistDataSource(networkService: networkService);
      final result = await artistDataSource.unfavoriteArtist(artistUrl: artistUrl);

      final request = verify(() => networkService.execute<void>(request: captureAny(named: "request"))).captured.first
          as NetworkRequest<void>;

      expect(request.path, "/v3/artist/$artistUrl/unfavorite");
      expect(request.type, NetworkRequestType.post);
      expect(result.isSuccess, isTrue);
    });
    test("When request fails", () async {
      final networkService = NetworkServiceMock();
      when(() => networkService.execute<void>(request: captureAny(named: "request")))
          .thenAnswer((invocation) => SynchronousFuture(
                Err(ServerError(statusCode: 404)),
              ));

      final artistDataSource = ArtistDataSource(networkService: networkService);

      final result = await artistDataSource.unfavoriteArtist(artistUrl: artistUrl);

      expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "statusCode", 404));
    });
  });
}
