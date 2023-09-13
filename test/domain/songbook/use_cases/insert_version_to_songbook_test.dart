import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_data_to_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_to_songbook.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:cifraclub/domain/version/use_cases/get_version_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_version_input_mock.dart';
import '../../../shared_mocks/domain/version/models/version_data_mock.dart';
import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _InsertVersionDataToSongbookMock extends Mock implements InsertVersionDataToSongbook {}

class _GetVersionDataMock extends Mock implements GetVersionData {}

void main() {
  final insertVersionDataToSongbook = _InsertVersionDataToSongbookMock();
  final getVersionData = _GetVersionDataMock();

  setUpAll(() {
    registerFallbackValue(ListType.canPlay);
  });

  group("When all requests is successful", () {
    registerFallbackValue(getFakeVersionData());
    final versionData = getFakeVersionData();
    final version = getFakeVersion();

    when(() => insertVersionDataToSongbook(
          versionData: any(named: "versionData"),
          songbookId: any(named: "songbookId"),
        )).thenAnswer((invocation) => SynchronousFuture(
          Ok((invocation.namedArguments[const Symbol("versionData")]! as VersionData).song.songId),
        ));

    when(() => getVersionData(
          artistUrl: any(named: "artistUrl"),
          songUrl: any(named: "songUrl"),
        )).thenAnswer((_) => Future.value(Ok(versionData)));

    test("should return success", () async {
      final result = await InsertVersionToSongbook(
        getVersionData,
        insertVersionDataToSongbook,
      )(
        artistUrl: version.artist.url,
        songUrl: version.songUrl,
        songbookId: 10,
      );

      verify(() => getVersionData(
            artistUrl: version.artist.url,
            songUrl: version.songUrl,
          )).called(1);
      expect(result.get(), versionData.song.songId);
    });
  });

  test("When call use case and getVersionData fails should return result error", () async {
    final versionInput = getFakeSongbookVersionInput();

    when(() => getVersionData(
          artistUrl: any(named: "artistUrl"),
          songUrl: any(named: "songUrl"),
        )).thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    final result = await InsertVersionToSongbook(
      getVersionData,
      insertVersionDataToSongbook,
    )(
      artistUrl: versionInput.artistUrl!,
      songUrl: versionInput.songUrl!,
      songbookId: ListType.cantPlay.localId,
    );

    verify(() => getVersionData(
          artistUrl: versionInput.artistUrl!,
          songUrl: versionInput.songUrl!,
        )).called(1);
    expect(result.isFailure, isTrue);
    expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "status code", 404));
  });

  test("When call use case and request fails should return result error", () async {
    final versionInput = getFakeSongbookVersionInput();
    final versionData = getFakeVersionData();

    when(() => getVersionData(
          artistUrl: any(named: "artistUrl"),
          songUrl: any(named: "songUrl"),
        )).thenAnswer((_) => Future.value(Ok(versionData)));

    when(() => insertVersionDataToSongbook(
          versionData: any(named: "versionData"),
          songbookId: any(named: "songbookId"),
        )).thenAnswer((invocation) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    final result = await InsertVersionToSongbook(
      getVersionData,
      insertVersionDataToSongbook,
    )(
      artistUrl: versionInput.artistUrl!,
      songUrl: versionInput.songUrl!,
      songbookId: 10,
    );

    verify(() => getVersionData(
          artistUrl: versionInput.artistUrl!,
          songUrl: versionInput.songUrl!,
        )).called(1);
    expect(result.isFailure, isTrue);
    expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "status code", 404));
  });
}
