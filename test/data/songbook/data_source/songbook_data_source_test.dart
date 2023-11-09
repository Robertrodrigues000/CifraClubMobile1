import 'dart:io';
import 'dart:math';

import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/songbook/data_source/songbook_data_source.dart';
import 'package:cifraclub/data/songbook/models/songbook_version_artist_dto.dart';
import 'package:cifraclub/data/songbook/models/versions_ids_input_dto.dart';
import 'package:cifraclub/data/songbook/models/new_songbook_response_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_input_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_version_input_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_version_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/data/clients/http/network_service_mock.dart';
import '../../../shared_mocks/domain/songbook/models/songbook_version_input_mock.dart';

void main() {
  const songbookVersion = SongbookVersionDto(
    songId: 2498,
    versionId: 2498,
    type: 1,
    name: "S.O.S",
    songUrl: "sos",
    remoteDatabaseId: 141322313,
    key: "G",
    stdKey: "G",
    capo: 0,
    tuning: "E A D G B E",
    lastUpdate: "2023-05-09 10:26:58",
    artist: SongbookVersionArtistDto(
        url: "raul-seixas",
        image: "2/b/f/f/2bffb38ff274a89069f0b98bb8cf1335.jpg",
        name: "Raul Seixas",
        id: 52,
        color: "#BDBDBD"),
  );

  setUpAll(() {
    registerFallbackValue(NetworkRequest<dynamic>(
      parser: (_) => throw Exception(""),
      path: "",
      type: NetworkRequestType.get,
    ));

    registerFallbackValue(NetworkRequest<SongbookVersionDto>(
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
      expect(songbooks.first.versions?.first.remoteDatabaseId, 122674888);
      expect(songbooks.first.versions?.first.songUrl, "lindo-testemunho");
      expect(songbooks.first.versions?.first.type, 1);
      expect(songbooks.first.versions?.first.key, "F");
      expect(songbooks.first.versions?.first.name, "Lindo Testemunho");
      expect(songbooks.first.versions?.last.remoteDatabaseId, 128668178);
      expect(songbooks.first.versions?.last.songUrl, "we-are-the-world");
      expect(songbooks.first.versions?.last.type, 1);
      expect(songbooks.first.versions?.last.key, "E");
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

  group("When addSongbook is called", () {
    test("and request is successful", () async {
      final networkService = NetworkServiceMock();
      final mockResponse =
          await File("test/data/songbook/data_source/new_songbook_mock_json_response.json").readAsString();
      await networkService.mock<NewSongbookResponseDto>(response: mockResponse);

      final songbookDataSource = SongbookDataSource(networkService);
      final result = await songbookDataSource.addSongbook(SongbookInputDto(name: "name", isPublic: true));

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
      final result = await songbookDataSource.addSongbook(SongbookInputDto(name: "name", isPublic: true));
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

      final result = await songbookDataSource.deleteVersions(songbookId, const VersionsIdsInputDto([0]));

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
      final result = await songbookDataSource.deleteVersions(songbookId, const VersionsIdsInputDto([0]));

      expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "statusCode", 404));
    });
  });

  group("When sortVersions is called", () {
    const songbookId = 0;
    test("and request is successful", () async {
      final networkService = NetworkServiceMock();
      final songbookDataSource = SongbookDataSource(networkService);

      when(() => networkService.execute<void>(request: captureAny(named: "request"))).thenAnswer(
        (_) => SynchronousFuture(const Ok(null)),
      );

      final result = await songbookDataSource.sortVersions(songbookId, const VersionsIdsInputDto([0, 1]));

      final request = verify(() => networkService.execute<void>(request: captureAny(named: "request"))).captured.first
          as NetworkRequest<void>;

      expect(request.path, "/v3/songbook/$songbookId/sort");
      expect(request.type, NetworkRequestType.put);

      expect(result.isSuccess, true);
    });

    test("and request fails", () async {
      final networkService = NetworkServiceMock();

      when(() => networkService.execute<void>(request: captureAny(named: "request"))).thenAnswer(
        (_) => SynchronousFuture(Err(ServerError(statusCode: 404))),
      );

      final songbookDataSource = SongbookDataSource(networkService);
      final result = await songbookDataSource.sortVersions(songbookId, const VersionsIdsInputDto([0]));

      expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "statusCode", 404));
    });
  });

  group("When addVersionToSongbook is called", () {
    const songbookId = 0;
    test("and request is successful and is user songbook", () async {
      final networkService = NetworkServiceMock();
      final songbookDataSource = SongbookDataSource(networkService);

      final mockResponse =
          await File("test/data/songbook/data_source/songbook_version_input_mock_json_reponse.json").readAsString();
      await networkService.mock<SongbookVersionDto?>(response: mockResponse);

      final result = await songbookDataSource.addVersionToSongbook(
          songbookId, SongbookVersionInputDto.fromDomain(getFakeSongbookVersionInput()));

      final request = verify(() => networkService.execute<SongbookVersionDto?>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<SongbookVersionDto?>;

      expect(request.path, "/v3/songbook/$songbookId/song");
      expect(request.type, NetworkRequestType.post);

      expect(result.isSuccess, true);
      expect(result.get()?.name, songbookVersion.name);
      expect(result.get()?.songId, songbookVersion.songId);
      expect(result.get()?.versionId, songbookVersion.versionId);
      expect(result.get()?.type, songbookVersion.type);
      expect(result.get()?.songUrl, songbookVersion.songUrl);
      expect(result.get()?.key, songbookVersion.key);
      expect(result.get()?.stdKey, songbookVersion.stdKey);
      expect(result.get()?.capo, songbookVersion.capo);
      expect(result.get()?.tuning, songbookVersion.tuning);
      expect(result.get()?.remoteDatabaseId, songbookVersion.remoteDatabaseId);
      expect(result.get()?.artist.url, songbookVersion.artist.url);
      expect(result.get()?.artist.name, songbookVersion.artist.name);
    });

    test("and request is successful and is favorite songbook", () async {
      final networkService = NetworkServiceMock();
      final songbookDataSource = SongbookDataSource(networkService);

      final mockResponse =
          await File("test/data/songbook/data_source/songbook_version_input_mock_json_reponse.json").readAsString();
      await networkService.mock<SongbookVersionDto?>(response: mockResponse);

      final result = await songbookDataSource.addVersionToSongbook(
          ListType.favorites.localId, SongbookVersionInputDto.fromDomain(getFakeSongbookVersionInput()));

      final request = verify(() => networkService.execute<SongbookVersionDto?>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<SongbookVersionDto?>;

      expect(request.path, "/v3/user/favorite-song");
      expect(request.type, NetworkRequestType.post);

      expect(result.isSuccess, true);
      expect(result.get(), songbookVersion);
    });

    test("and request is successful and is can songbook", () async {
      final networkService = NetworkServiceMock();
      final songbookDataSource = SongbookDataSource(networkService);

      final mockResponse =
          await File("test/data/songbook/data_source/songbook_version_input_mock_json_reponse.json").readAsString();
      await networkService.mock<SongbookVersionDto?>(response: mockResponse);

      final result = await songbookDataSource.addVersionToSongbook(
          ListType.canPlay.localId, SongbookVersionInputDto.fromDomain(getFakeSongbookVersionInput()));

      final request = verify(() => networkService.execute<SongbookVersionDto?>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<SongbookVersionDto?>;

      expect(request.path, "/v3/user/can-play");
      expect(request.type, NetworkRequestType.post);

      expect(result.isSuccess, true);
      expect(result.get(), songbookVersion);
    });

    test("and request is successful and is cant songbook", () async {
      final networkService = NetworkServiceMock();
      final songbookDataSource = SongbookDataSource(networkService);

      final mockResponse =
          await File("test/data/songbook/data_source/songbook_version_input_mock_json_reponse.json").readAsString();
      await networkService.mock<SongbookVersionDto?>(response: mockResponse);

      final result = await songbookDataSource.addVersionToSongbook(
          ListType.cantPlay.localId, SongbookVersionInputDto.fromDomain(getFakeSongbookVersionInput()));

      final request = verify(() => networkService.execute<SongbookVersionDto?>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<SongbookVersionDto?>;

      expect(request.path, "/v3/user/cannot-play");
      expect(request.type, NetworkRequestType.post);

      expect(result.isSuccess, true);
      expect(result.get(), songbookVersion);
    });

    test("and request is successful and is recent songbook", () async {
      final networkService = NetworkServiceMock();
      final songbookDataSource = SongbookDataSource(networkService);

      await networkService.mock<SongbookVersionDto?>(response: "");

      final result = await songbookDataSource.addVersionToSongbook(
          ListType.recents.localId, SongbookVersionInputDto.fromDomain(getFakeSongbookVersionInput()));

      final request = verify(() => networkService.execute<SongbookVersionDto?>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<SongbookVersionDto?>;

      expect(request.path, "/v3/user/song-view");
      expect(request.type, NetworkRequestType.post);

      expect(result.isSuccess, true);
      expect(result.get(), isNull);
    });

    test("and request fails", () async {
      final networkService = NetworkServiceMock();
      final versionInput = getFakeSongbookVersionInput();

      when(() => networkService.execute<SongbookVersionDto?>(request: captureAny(named: "request"))).thenAnswer(
        (_) => SynchronousFuture(Err(ServerError(statusCode: 404))),
      );

      final songbookDataSource = SongbookDataSource(networkService);
      final result =
          await songbookDataSource.addVersionToSongbook(songbookId, SongbookVersionInputDto.fromDomain(versionInput));

      expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "statusCode", 404));
    });
  });

  group("When getSongbookById is called", () {
    test("and request is successful", () async {
      final networkService = NetworkServiceMock();
      final mockResponse = await File("test/data/songbook/data_source/songbook_mock_json_response.json").readAsString();
      await networkService.mock<SongbookDto>(response: mockResponse);

      final songbookDataSource = SongbookDataSource(networkService);
      final result = await songbookDataSource.getSongbookById(songbookId: 1);

      expect(result.isSuccess, true);
      final songbook = result.get()!;

      expect(songbook.id, 10019906);
      expect(songbook.name, "trstasd");
      expect(songbook.userId, 545320573);
      expect(songbook.userName, "João Gonçalves");
      expect(songbook.createdAt, "2023-05-08 09:12:05");
      expect(songbook.lastUpdated, "2023-07-17 12:10:30");
      expect(songbook.isPublic, true);
      expect(songbook.status, 1);
      expect(songbook.totalSongs, 2);
      expect(songbook.versions?.length, 2);
      expect(songbook.versions?.first.remoteDatabaseId, 136853322);
      expect(songbook.versions?.first.songUrl, "its-my-life");
      expect(songbook.versions?.first.type, 1);
      expect(songbook.versions?.first.key, "D#");
      expect(songbook.versions?.first.name, "It's My Life");
      expect(songbook.versions?.last.remoteDatabaseId, 136853323);
      expect(songbook.versions?.last.songUrl, "livin-on-prayer");
      expect(songbook.versions?.last.type, 1);
      expect(songbook.versions?.last.key, "G");
      expect(songbook.versions?.last.name, "Livin' On A Prayer");
    });

    test("and request fails", () async {
      final networkService = NetworkServiceMock();
      when(() => networkService.execute<SongbookDto>(request: captureAny(named: "request"))).thenAnswer(
        (invocation) => SynchronousFuture(
          Err(ServerError(statusCode: 404)),
        ),
      );

      final songbookDataSource = SongbookDataSource(networkService);
      final result = await songbookDataSource.getSongbookById(songbookId: 1);

      expect(result.isFailure, true);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, 404);
    });
  });

  group("When deleteVersionsFromRecentsAndCanPlay is called", () {
    test("and request is successful and is favorites songbook", () async {
      final networkService = NetworkServiceMock();
      final songbookDataSource = SongbookDataSource(networkService);

      when(() => networkService.execute<void>(request: captureAny(named: "request"))).thenAnswer(
        (_) => SynchronousFuture(const Ok(null)),
      );

      final result = await songbookDataSource.deleteVersionsFromFavoriteAndCanPlay(
        ListType.favorites.localId,
        SongbookVersionInputDto.fromDomain(getFakeSongbookVersionInput()),
      );

      final request = verify(() => networkService.execute<void>(request: captureAny(named: "request"))).captured.first
          as NetworkRequest<void>;

      expect(request.path, "/v3/user/unfavorite-song");
      expect(request.type, NetworkRequestType.post);

      expect(result.isSuccess, true);
    });

    test("and request is successful and is recent can play", () async {
      final networkService = NetworkServiceMock();
      final songbookDataSource = SongbookDataSource(networkService);

      when(() => networkService.execute<void>(request: captureAny(named: "request"))).thenAnswer(
        (_) => SynchronousFuture(const Ok(null)),
      );

      final result = await songbookDataSource.deleteVersionsFromFavoriteAndCanPlay(
        ListType.canPlay.localId,
        SongbookVersionInputDto.fromDomain(getFakeSongbookVersionInput()),
      );

      final request = verify(() => networkService.execute<void>(request: captureAny(named: "request"))).captured.first
          as NetworkRequest<void>;

      expect(request.path, "/v3/user/remove-can-play");
      expect(request.type, NetworkRequestType.post);

      expect(result.isSuccess, true);
    });

    test("and is different songbook type should return a throw", () async {
      final networkService = NetworkServiceMock();
      final songbookDataSource = SongbookDataSource(networkService);

      expect(
        () async => songbookDataSource.deleteVersionsFromFavoriteAndCanPlay(
          ListType.recents.localId,
          SongbookVersionInputDto.fromDomain(getFakeSongbookVersionInput()),
        ),
        throwsException,
      );
    });
  });
}
