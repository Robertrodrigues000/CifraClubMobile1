import 'dart:io';

import 'package:async/async.dart' hide Result;
import 'package:cifraclub/data/artist/data_source/artist_data_source.dart';
import 'package:cifraclub/data/artist/models/artist_songs_dto.dart';
import 'package:cifraclub/data/artist/models/top_artists_dto.dart';
import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/domain/artist/models/artist_song_filter.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/data/clients/http/network_service_mock.dart';

void main() {
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

  group("When getArtistSongs is called", () {
    test("When request is successful with params", () async {
      const artistDns = "gabriela-rocha";
      final queryParams = {
        'limit': 2,
        'filter': ArtistSongFilter.cifra.name,
      };

      final networkService = NetworkServiceMock();
      final mockResponse =
          await File("test/data/artist/data_source/artist_songs_mock_json_response.json").readAsString();
      await networkService.mock<ArtistSongsDto>(response: mockResponse);

      final artistDataSource = ArtistDataSource(networkService: networkService);
      final result = await artistDataSource
          .getArtistSongs(
            artistUrl: artistDns,
            limit: queryParams['limit'] as int,
            filter: ArtistSongFilter.cifra,
          )
          .value;

      final request =
          verify(() => networkService.cancelableExecute<ArtistSongsDto>(request: captureAny(named: "request")))
              .captured
              .first as NetworkRequest<ArtistSongsDto>;
      expect(request.path, "/v3/artist/$artistDns/songs?exclude=lyrics+files");
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
      when(() => networkService.cancelableExecute<ArtistSongsDto>(request: captureAny(named: "request"))).thenAnswer(
        (invocation) => CancelableOperation.fromFuture(
          SynchronousFuture(
            Err(ServerError(statusCode: 404)),
          ),
        ),
      );

      final artistDataSource = ArtistDataSource(networkService: networkService);
      final result = await artistDataSource
          .getArtistSongs(
            limit: 10,
            artistUrl: "legiao-urbana",
          )
          .value;

      expect(result.isFailure, true);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, 404);
    });
  });
}
