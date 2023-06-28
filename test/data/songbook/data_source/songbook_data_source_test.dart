import 'dart:io';
import 'dart:math';

import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/songbook/data_source/songbook_data_source.dart';
import 'package:cifraclub/data/songbook/models/delete_versions_input_dto.dart';
import 'package:cifraclub/data/songbook/models/new_songbook_response_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_input_dto.dart';
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

  group("When getAll is called", () {
    test("and request is successful", () async {
      final networkService = NetworkServiceMock();
      final mockResponse =
          await File("test/data/songbook/data_source/songbooks_mock_json_response.json").readAsString();
      await networkService.mock<List<SongbookDto>>(response: mockResponse);

      final songbookDataSource = SongbookDataSource(networkService);
      final result = await songbookDataSource.getAll();

      expect(result.isSuccess, true);
      final songbooks = result.get()!;

      expect(songbooks.length, 1);
      expect(songbooks.first.id, 9116248);
      expect(songbooks.first.name, "test2");
      expect(songbooks.first.userId, 545320573);
      expect(songbooks.first.createdAt, "2022-10-27 15:18:04");
      expect(songbooks.first.lastUpdated, "2023-01-16 17:04:44");
      expect(songbooks.first.isPublic, false);
      expect(songbooks.first.status, 1);
      expect(songbooks.first.totalSongs, 2);
      expect(songbooks.first.versions?.length, 2);
      expect(songbooks.first.versions?.first.remoteDatabaseID, 122674888);
      expect(songbooks.first.versions?.first.songUrl, "lindo-testemunho");
      expect(songbooks.first.versions?.first.type, 1);
      expect(songbooks.first.versions?.first.tone, "F");
      expect(songbooks.first.versions?.first.name, "Lindo Testemunho");
      expect(songbooks.first.versions?.last.remoteDatabaseID, 128668178);
      expect(songbooks.first.versions?.last.songUrl, "we-are-the-world");
      expect(songbooks.first.versions?.last.type, 1);
      expect(songbooks.first.versions?.last.tone, "E");
      expect(songbooks.first.versions?.last.name, "We Are The World");
    });

    test("and request fails", () async {
      final networkService = NetworkServiceMock();
      when(() => networkService.execute<List<SongbookDto>>(request: captureAny(named: "request"))).thenAnswer(
        (invocation) => SynchronousFuture(
          Err(ServerError(statusCode: 404)),
        ),
      );

      final songbookDataSource = SongbookDataSource(networkService);
      final result = await songbookDataSource.getAll();

      expect(result.isFailure, true);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, 404);
    });
  });

  group("When insertSongbook is called", () {
    test("and request is successful", () async {
      final networkService = NetworkServiceMock();
      final mockResponse =
          await File("test/data/songbook/data_source/new_songbook_mock_json_response.json").readAsString();
      await networkService.mock<NewSongbookResponseDto>(response: mockResponse);

      final songbookDataSource = SongbookDataSource(networkService);
      final result = await songbookDataSource.insertSongbook(SongbookInputDto(name: "name", isPublic: true));

      expect(result.isSuccess, true);
      final newSongbookResponse = result.getOrThrow();

      expect(newSongbookResponse.id, 123);
      expect(newSongbookResponse.name, "name");
      expect(newSongbookResponse.isPublic, 1);
    });

    test("and request fails", () async {
      final networkService = NetworkServiceMock();
      when(() => networkService.execute<NewSongbookResponseDto>(request: captureAny(named: "request"))).thenAnswer(
        (_) => SynchronousFuture(Err(ServerError(statusCode: 404))),
      );
      final songbookDataSource = SongbookDataSource(networkService);
      final result = await songbookDataSource.insertSongbook(SongbookInputDto(name: "name", isPublic: true));
      expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "statusCode", 404));
    });
  });

  group("When deleteSongbook is called", () {
    test("and request is successful", () async {
      final networkService = NetworkServiceMock();
      when(() => networkService.execute<void>(request: captureAny(named: "request"))).thenAnswer(
        (_) => SynchronousFuture(const Ok(null)),
      );

      final songbookId = Random().nextInt(1000);
      final songbookDataSource = SongbookDataSource(networkService);

      final result = await songbookDataSource.deleteSongbook(songbookId);

      final request = verify(() => networkService.execute<void>(request: captureAny(named: "request"))).captured.first
          as NetworkRequest<void>;

      expect(result.isSuccess, isTrue);

      expect(request.type, NetworkRequestType.post);
      expect(request.path, "/v3/songbook/$songbookId/delete");
    });

    test("and request fails", () async {
      final networkService = NetworkServiceMock();
      when(() => networkService.execute<void>(request: captureAny(named: "request"))).thenAnswer(
        (_) => SynchronousFuture(Err(ServerError(statusCode: 404))),
      );

      final songbookId = Random().nextInt(1000);
      final songbookDataSource = SongbookDataSource(networkService);

      final result = await songbookDataSource.deleteSongbook(songbookId);

      expect(result.isFailure, isTrue);
      expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "statusCode", 404));
    });
  });

  group("When updateSongbookData is called", () {
    const songbookId = 0;
    test("and request is successful", () async {
      final networkService = NetworkServiceMock();
      final songbookDataSource = SongbookDataSource(networkService);

      when(() => networkService.execute<void>(request: captureAny(named: "request"))).thenAnswer(
        (_) => SynchronousFuture(const Ok(null)),
      );

      final result =
          await songbookDataSource.updateSongbookData(songbookId, SongbookInputDto(name: "name", isPublic: false));

      final request = verify(() => networkService.execute<void>(request: captureAny(named: "request"))).captured.first
          as NetworkRequest<void>;

      expect(request.path, "/v3/songbook/$songbookId");
      expect(request.type, NetworkRequestType.put);

      expect(result.isSuccess, true);
    });

    test("and request fails", () async {
      final networkService = NetworkServiceMock();

      when(() => networkService.execute<void>(request: captureAny(named: "request"))).thenAnswer(
        (_) => SynchronousFuture(Err(ServerError(statusCode: 404))),
      );

      final songbookDataSource = SongbookDataSource(networkService);
      final result =
          await songbookDataSource.updateSongbookData(songbookId, SongbookInputDto(name: "name", isPublic: false));
      expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "statusCode", 404));
    });
  });

  group("When deleteVersions is called", () {
    const songbookId = 0;
    test("and request is successful", () async {
      final networkService = NetworkServiceMock();
      final songbookDataSource = SongbookDataSource(networkService);

      when(() => networkService.execute<void>(request: captureAny(named: "request"))).thenAnswer(
        (_) => SynchronousFuture(const Ok(null)),
      );

      final result = await songbookDataSource.deleteVersions(songbookId, const DeleteVersionsInputDto([0]));

      final request = verify(() => networkService.execute<void>(request: captureAny(named: "request"))).captured.first
          as NetworkRequest<void>;

      expect(request.path, "/v3/songbook/$songbookId/songs/delete");
      expect(request.type, NetworkRequestType.post);

      expect(result.isSuccess, true);
    });

    test("and request fails", () async {
      final networkService = NetworkServiceMock();

      when(() => networkService.execute<void>(request: captureAny(named: "request"))).thenAnswer(
        (_) => SynchronousFuture(Err(ServerError(statusCode: 404))),
      );

      final songbookDataSource = SongbookDataSource(networkService);
      final result = await songbookDataSource.deleteVersions(songbookId, const DeleteVersionsInputDto([0]));

      expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "statusCode", 404));
    });
  });
}
