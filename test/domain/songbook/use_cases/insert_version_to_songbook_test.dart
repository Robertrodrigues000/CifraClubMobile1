import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_to_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_preview.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:cifraclub/domain/version/use_cases/get_version_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_version_input_mock.dart';
import '../../../shared_mocks/domain/version/models/version_data_mock.dart';
import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _SongbookRepositoryMock extends Mock implements SongbookRepository {}

class _UserVersionRepositoryMock extends Mock implements UserVersionRepository {}

class _UserSongbookRepositoryMock extends Mock implements UserSongbookRepository {}

class _GetVersionDataMock extends Mock implements GetVersionData {}

class _UpdateSongbookPreviewMock extends Mock implements UpdateSongbookPreview {}

void main() {
  final songbookRepository = _SongbookRepositoryMock();
  final userVersionRepository = _UserVersionRepositoryMock();
  final getVersionData = _GetVersionDataMock();
  final userSongbookRepository = _UserSongbookRepositoryMock();
  final updateSongbookPreview = _UpdateSongbookPreviewMock();

  setUpAll(() {
    registerFallbackValue(getFakeSongbookVersionInput());
    registerFallbackValue(ListType.canPlay);
  });

  group("When all requests is successful", () {
    registerFallbackValue(getFakeVersionData());
    final version = getFakeVersion();
    final versionInput = getFakeSongbookVersionInput();
    final versionResponse = getFakeVersion();
    final versionData = getFakeVersionData();

    when(() => userVersionRepository.addVersionsToSongbook(any(), any()))
        .thenAnswer((_) => Future.value([version.localDatabaseId!]));

    when(() => getVersionData(
          artistDns: any(named: "artistDns"),
          songDns: any(named: "songDns"),
        )).thenAnswer((_) => Future.value(Ok(versionData)));

    when(() => userVersionRepository.addVersionData(
          versionData: any(named: "versionData"),
          versionLocalDatabaseId: any(named: "versionLocalDatabaseId"),
          songbookId: any(named: "songbookId"),
        )).thenAnswer((_) => Future.value(versionData.versionId));

    when(() => userSongbookRepository.incrementTotalSongs(
          songbookId: any(named: "songbookId"),
          quantity: any(named: "quantity"),
        )).thenAnswer((_) => Future.value(1));

    when(() => updateSongbookPreview(10)).thenAnswer((_) => Future.value(2));

    test("should return success", () async {
      when(() => songbookRepository.addVersionToSongbook(
          songbookId: any(named: "songbookId"),
          versionInput: any(named: "versionInput"))).thenAnswer((_) => SynchronousFuture(Ok(versionResponse)));

      final result = await InsertVersionToSongbook(
        songbookRepository,
        userVersionRepository,
        getVersionData,
        userSongbookRepository,
        updateSongbookPreview,
      )(
        artistUrl: versionInput.artistUrl!,
        songUrl: versionInput.songUrl!,
        songbookId: 10,
      );

      verify(() => getVersionData(
            artistDns: versionInput.artistUrl!,
            songDns: versionInput.songUrl!,
          )).called(1);
      verify(() => songbookRepository.addVersionToSongbook(versionInput: any(named: "versionInput"), songbookId: 10))
          .called(1);
      verify(() => userSongbookRepository.incrementTotalSongs(
          songbookId: any(named: "songbookId"), quantity: any(named: "quantity"))).called(1);
      verify(() => userVersionRepository.addVersionsToSongbook([versionResponse], 10)).called(1);
      verify(() => userVersionRepository.addVersionData(
          versionData: versionData, versionLocalDatabaseId: version.localDatabaseId!, songbookId: 10)).called(1);
      verify(() => updateSongbookPreview(10)).called(1);
      expect(result.get(), versionResponse.songId);
    });
  });

  test("When call use case and getVersionData fails should return result error", () async {
    final versionInput = getFakeSongbookVersionInput();

    when(() => getVersionData(
          artistDns: any(named: "artistDns"),
          songDns: any(named: "songDns"),
        )).thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    final result = await InsertVersionToSongbook(
      songbookRepository,
      userVersionRepository,
      getVersionData,
      userSongbookRepository,
      updateSongbookPreview,
    )(
      artistUrl: versionInput.artistUrl!,
      songUrl: versionInput.songUrl!,
      songbookId: ListType.cantPlay.localId,
    );

    verify(() => getVersionData(
          artistDns: versionInput.artistUrl!,
          songDns: versionInput.songUrl!,
        )).called(1);
    expect(result.isFailure, isTrue);
    expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "status code", 404));
  });

  test("When call use case and request fails should return result error", () async {
    final versionInput = getFakeSongbookVersionInput();
    final versionData = getFakeVersionData();

    when(() => getVersionData(
          artistDns: any(named: "artistDns"),
          songDns: any(named: "songDns"),
        )).thenAnswer((_) => Future.value(Ok(versionData)));

    when(() => songbookRepository.addVersionToSongbook(
        songbookId: any(named: "songbookId"),
        versionInput: any(named: "versionInput"))).thenAnswer((_) => Future.value(Err(ServerError(statusCode: 404))));

    final result = await InsertVersionToSongbook(
      songbookRepository,
      userVersionRepository,
      getVersionData,
      userSongbookRepository,
      updateSongbookPreview,
    )(
      artistUrl: versionInput.artistUrl!,
      songUrl: versionInput.songUrl!,
      songbookId: 10,
    );

    verify(() => getVersionData(
          artistDns: versionInput.artistUrl!,
          songDns: versionInput.songUrl!,
        )).called(1);
    verifyNever(() => userSongbookRepository.incrementTotalSongs(
        songbookId: any(named: "songbookId"), quantity: any(named: "quantity")));
    expect(result.isFailure, isTrue);
    expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "status code", 404));
  });
}
