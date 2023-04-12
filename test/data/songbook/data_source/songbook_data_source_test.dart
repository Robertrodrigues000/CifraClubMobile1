import 'dart:io';

import 'package:cifraclub/data/songbook/data_source/songbook_data_source.dart';
import 'package:cifraclub/data/songbook/models/songbook_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/data/clients/http/network_service_mock.dart';

void main() {
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
      expect(songbooks.first.cifras?.length, 2);
      expect(songbooks.first.cifras?.first.id, 122674888);
      expect(songbooks.first.cifras?.first.songUrl, "lindo-testemunho");
      expect(songbooks.first.cifras?.first.type, 1);
      expect(songbooks.first.cifras?.first.tone, "F");
      expect(songbooks.first.cifras?.first.name, "Lindo Testemunho");
      expect(songbooks.first.cifras?.last.id, 128668178);
      expect(songbooks.first.cifras?.last.songUrl, "we-are-the-world");
      expect(songbooks.first.cifras?.last.type, 1);
      expect(songbooks.first.cifras?.last.tone, "E");
      expect(songbooks.first.cifras?.last.name, "We Are The World");
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
}
