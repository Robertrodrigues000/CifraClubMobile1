import 'dart:io';

import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/song/data_source/song_data_source.dart';
import 'package:cifraclub/data/song/models/top_songs_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/data/clients/http/network_service_mock.dart';

void main() {
  group("When getTopSongs is called", () {
    test("When request is successful with params", () async {
      final queryParams = {
        'genre': 'mpb',
        'offset': 10,
        'limit': 2,
      };

      final networkService = NetworkServiceMock();
      final mockResponse = await File("test/data/song/data_source/top_songs_mock_json_response.json").readAsString();
      await networkService.mock<TopSongsDto>(response: mockResponse);

      final songDataSource = SongDataSource(networkService: networkService);
      final result = await songDataSource.getTopSongs(
        genreUrl: queryParams['genre'] as String,
        limit: queryParams['limit'] as int,
        offset: queryParams['offset'] as int,
      );

      final request = verify(() => networkService.execute<TopSongsDto>(request: captureAny(named: "request"))).captured.first as NetworkRequest<TopSongsDto>;

      expect(request.path, "/v3/top/songs");
      expect(request.type, NetworkRequestType.get);
      expect(request.queryParams, queryParams);

      expect(result.isSuccess, true);
      final topSongs = result.get()!;

      expect(topSongs.songs.length, 2);
      expect(topSongs.songs.first.id, 6578);
      expect(topSongs.songs.first.name, "All Star");
      expect(topSongs.songs.first.url, "all-star");
      expect(topSongs.songs.first.artist?.name, "Nando Reis");
      expect(topSongs.songs.first.artist?.id, 7237);
      expect(topSongs.moreResults, true);
    });

    test("When request is successful without params", () async {
      final queryParams = {
        'limit': 2,
      };

      final networkService = NetworkServiceMock();
      final mockResponse = await File("test/data/song/data_source/top_songs_mock_json_response.json").readAsString();
      await networkService.mock<TopSongsDto>(response: mockResponse);

      final songDataSource = SongDataSource(networkService: networkService);
      final result = await songDataSource.getTopSongs(
        limit: queryParams['limit'] as int,
        offset: 0,
      );

      final request = verify(() => networkService.execute<TopSongsDto>(request: captureAny(named: "request"))).captured.first as NetworkRequest<TopSongsDto>;

      expect(request.path, "/v3/top/songs");
      expect(request.type, NetworkRequestType.get);
      expect(request.queryParams, queryParams);

      expect(result.isSuccess, true);
      final topSongs = result.get()!;

      expect(topSongs.songs.length, 2);
      expect(topSongs.songs.first.id, 6578);
      expect(topSongs.songs.first.name, "All Star");
      expect(topSongs.songs.first.url, "all-star");
      expect(topSongs.songs.first.artist?.name, "Nando Reis");
      expect(topSongs.songs.first.artist?.id, 7237);
      expect(topSongs.moreResults, true);
    });

    test("When request fails", () async {
      final networkService = NetworkServiceMock();
      when(() => networkService.execute<TopSongsDto>(request: captureAny(named: "request"))).thenAnswer(
        (invocation) => SynchronousFuture(
          Err(ServerError(statusCode: 404)),
        ),
      );

      final songDataSource = SongDataSource(networkService: networkService);
      final result = await songDataSource.getTopSongs(
        limit: 2,
        offset: 10,
      );

      expect(result.isFailure, true);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, 404);
    });
  });
}
