import 'dart:io';

import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/version/data_source/version_data_source.dart';
import 'package:cifraclub/data/version/models/version/version_data_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/data/clients/http/network_service_mock.dart';

void main() {
  group("When getVersionData is called", () {
    test("and request is successful", () async {
      final networkService = NetworkServiceMock();
      final mockResponse = await File("test/data/version/data_source/version_data_json_response.json").readAsString();
      await networkService.mock<VersionDataDto>(response: mockResponse);

      final versionDataSource = VersionDataSource(networkService);
      final result = await versionDataSource.getVersionData("artistUrl", "songUrl", "instrument", "version");
      final request = verify(() => networkService.execute<VersionDataDto>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<VersionDataDto>;

      expect(result.isSuccess, true);
      expect(request.path, "/v3/version/artistUrl/songUrl/instrument/version");
      expect(request.type, NetworkRequestType.get);
      final versionData = result.getOrThrow();

      _versionDataJsonResponseExpects(versionData);
    });

    test("and request fails", () async {
      final networkService = NetworkServiceMock();
      when(() => networkService.execute<VersionDataDto>(request: captureAny(named: "request"))).thenAnswer(
        (_) => SynchronousFuture(Err(ServerError(statusCode: 404))),
      );

      final versionDataSource = VersionDataSource(networkService);
      final result = await versionDataSource.getVersionData("", "");
      expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "statusCode", 404));
    });
  });

  group("When getVersionDataByVersionId is called", () {
    test("and request is successful", () async {
      final networkService = NetworkServiceMock();
      final mockResponse = await File("test/data/version/data_source/version_data_json_response.json").readAsString();
      await networkService.mock<VersionDataDto>(response: mockResponse);

      final versionDataSource = VersionDataSource(networkService);
      final result = await versionDataSource.getVersionDataByVersionId(1251421, 1);
      final request = verify(() => networkService.execute<VersionDataDto>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<VersionDataDto>;

      expect(result.isSuccess, true);
      expect(request.path, "/v3/cifra/1251421/1");
      expect(request.type, NetworkRequestType.get);
      final versionData = result.getOrThrow();

      _versionDataJsonResponseExpects(versionData);
    });

    test("and request fails", () async {
      final networkService = NetworkServiceMock();
      when(() => networkService.execute<VersionDataDto>(request: captureAny(named: "request"))).thenAnswer(
        (_) => SynchronousFuture(Err(ServerError(statusCode: 404))),
      );

      final versionDataSource = VersionDataSource(networkService);
      final result = await versionDataSource.getVersionDataByVersionId(1251421, 1);
      expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "statusCode", 404));
    });
  });
}

void _versionDataJsonResponseExpects(VersionDataDto versionData) {
  expect(versionData.versionId, 3219);
  expect(versionData.type, 1);
  expect(versionData.content, "letra da musica");
  expect(versionData.label, "Principal");
  expect(versionData.versionUrl, "principal");
  expect(versionData.completePath, "/version/legiao-urbana/tempo-perdido/cifras/principal");
  expect(versionData.siteUrl, "/legiao-urbana/tempo-perdido/");
  expect(versionData.key, "G");
  expect(versionData.shapeKey, "G");
  expect(versionData.stdKey, "Em");
  expect(versionData.stdShapeKey, "Em");
  expect(versionData.tuning, "E A D G B E");
  expect(versionData.capo, 0);
  expect(versionData.composers, "Renato Russo");
  expect(versionData.isVerified, true);
  expect(versionData.blocked, true);
  expect(versionData.type, 1);
  expect(versionData.chords?.first.chord, "Am7");
  expect(versionData.chords?.first.alt, "Am7");
  expect(versionData.chords?.first.guitar, ["X 0 2 0 1 0"]);
  expect(versionData.chords?.first.cavaco, ["7 P5 5 5"]);
  expect(versionData.chords?.first.keyboard, ["10 1 5 8"]);
  expect(versionData.chords?.first.ukulele, ["0 0 0 0"]);
  expect(versionData.chords?.first.viola, ["X 7 6 7 5"]);
  expect(versionData.chords?.first.violaMi, ["X 5 4 5 3"]);
  expect(versionData.chords?.first.violaRa, ["X 7 5 5 5"]);
  expect(versionData.song.songId, 3219);
  expect(versionData.song.lyricsId, 22489);
  expect(versionData.song.name, "Tempo Perdido");
  expect(versionData.song.url, "tempo-perdido");
  expect(versionData.song.description, "Somos tão jovens / Tão jovens / Tão jovens");
  expect(versionData.artist?.id, 19);
  expect(versionData.artist?.name, "Legião Urbana");
  expect(versionData.artist?.url, "legiao-urbana");
  expect(versionData.videoLesson?.id, 1573);
  expect(versionData.videoLesson?.youtubeId, "Pt9elq3DYNM");
  expect(versionData.videoLesson?.title, "Tempo Perdido (aula de violão completa)");
  expect(versionData.videoLesson?.thumb, "https://i3.ytimg.com/vi/Pt9elq3DYNM/mqdefault.jpg");
  expect(versionData.contributors?.first.name, "Gustavo Cunha");
  expect(versionData.contributors?.first.id, 2337985);
  expect(versionData.contributors?.first.type, 2);
  expect(versionData.contributors?.first.url, "/musico/2337985/");
  expect(versionData.instrumentVersions?.first.label, "Violão e guitarra");
  expect(versionData.instrumentVersions?.first.type, 1);
  expect(versionData.instrumentVersions?.first.versions?.first.versionId, 3219);
  expect(versionData.instrumentVersions?.first.versions?.first.label, "Principal");
  expect(versionData.instrumentVersions?.first.versions?.first.versionUrl, "principal");
  expect(versionData.instrumentVersions?.first.versions?.first.isVerified, true);
  expect(versionData.instrumentVersions?.first.versions?.first.completePath,
      "/version/legiao-urbana/tempo-perdido/cifras/principal");
}
