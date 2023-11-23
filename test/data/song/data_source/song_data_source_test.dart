import 'dart:io';

import 'package:async/async.dart' hide Result;
import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/song/data_source/song_data_source.dart';
import 'package:cifraclub/data/song/models/send_email_to_blocked_song_dto.dart';
import 'package:cifraclub/data/song/models/top_songs_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/data/clients/http/network_service_mock.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(NetworkRequest<void>(
      parser: (_) => throw Exception(""),
      path: "",
      type: NetworkRequestType.get,
    ));
  });

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

      final songDataSource = SongDataSource(networkService);
      final result = await songDataSource
          .getTopSongs(
            genreUrl: queryParams['genre'] as String,
            limit: queryParams['limit'] as int,
            offset: queryParams['offset'] as int,
          )
          .value;

      final request = verify(() => networkService.cancelableExecute<TopSongsDto>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<TopSongsDto>;

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

      final songDataSource = SongDataSource(networkService);
      final result = await songDataSource
          .getTopSongs(
            limit: queryParams['limit'] as int,
            offset: 0,
          )
          .value;

      final request = verify(() => networkService.cancelableExecute<TopSongsDto>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<TopSongsDto>;

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
      when(() => networkService.cancelableExecute<TopSongsDto>(request: captureAny(named: "request"))).thenAnswer(
        (invocation) => CancelableOperation.fromFuture(
          SynchronousFuture(
            Err(ServerError(statusCode: 404)),
          ),
        ),
      );

      final songDataSource = SongDataSource(networkService);
      final result = await songDataSource
          .getTopSongs(
            limit: 2,
            offset: 10,
          )
          .value;

      expect(result.isFailure, true);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, 404);
    });
  });

  group("When sendEmail is called", () {
    test("and request is successful", () async {
      final networkService = NetworkServiceMock();
      when(() => networkService.execute<void>(request: captureAny(named: "request"))).thenAnswer(
        (_) => SynchronousFuture(const Ok(null)),
      );

      final songDataSource = SongDataSource(networkService);
      final result = await songDataSource.sendEmail(SendEmailToBlockedSongDto(email: "email@test.com", url: "url"));

      final request = verify(() => networkService.execute<void>(request: captureAny(named: "request"))).captured.first
          as NetworkRequest<void>;

      expect(result.isSuccess, isTrue);

      expect(request.type, NetworkRequestType.post);
      expect(request.path, "/v3/song/blocked/signup");
      expect(request.data!["email"], "email@test.com");
      expect(request.data!["url"], "url");
    });

    test("and request fails", () async {
      final networkService = NetworkServiceMock();
      when(() => networkService.execute<void>(request: captureAny(named: "request"))).thenAnswer(
        (_) => SynchronousFuture(Err(ServerError(statusCode: 404))),
      );

      final songDataSource = SongDataSource(networkService);
      final result = await songDataSource.sendEmail(SendEmailToBlockedSongDto(email: "email@test.com", url: "url"));

      expect(result.isFailure, isTrue);
      expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "statusCode", 404));
    });
  });
}
