import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_data_to_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_preview.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_version_input_mock.dart';
import '../../../shared_mocks/domain/version/models/version_data_mock.dart';
import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _SongbookRepositoryMock extends Mock implements SongbookRepository {}

class _UserVersionRepositoryMock extends Mock implements UserVersionRepository {}

class _UserSongbookRepositoryMock extends Mock implements UserSongbookRepository {}

class _UpdateSongbookPreviewMock extends Mock implements UpdateSongbookPreview {}

void main() {
  final songbookRepository = _SongbookRepositoryMock();
  final userVersionRepository = _UserVersionRepositoryMock();
  final userSongbookRepository = _UserSongbookRepositoryMock();
  final updateSongbookPreview = _UpdateSongbookPreviewMock();

  setUpAll(() {
    registerFallbackValue(getFakeSongbookVersionInput());
    registerFallbackValue(ListType.canPlay);
  });

  group("When all requests is successful", () {
    registerFallbackValue(getFakeVersionData());
    final version = getFakeVersion();
    final versionResponse = getFakeVersion();
    final versionData = getFakeVersionData();

    when(() => userVersionRepository.putVersionsToSongbook(any(), any()))
        .thenAnswer((_) => Future.value([version.localDatabaseId!]));

    when(() => userVersionRepository.addVersionData(
          versionData: any(named: "versionData"),
          versionLocalDatabaseId: any(named: "versionLocalDatabaseId"),
          songbookId: any(named: "songbookId"),
        )).thenAnswer((_) => Future.value(versionData.versionId));

    when(() => userSongbookRepository.updateTotalSongs(songbookId: any(named: "songbookId")))
        .thenAnswer((_) => Future.value(1));

    when(() => updateSongbookPreview(any())).thenAnswer((_) => Future.value(null));

    test("should return success", () async {
      when(() => songbookRepository.addVersionToSongbook(
          songbookId: any(named: "songbookId"),
          versionInput: any(named: "versionInput"))).thenAnswer((_) => Future.value(Ok(versionResponse)));

      final result = await InsertVersionDataToSongbook(
        songbookRepository,
        userSongbookRepository,
        userVersionRepository,
        updateSongbookPreview,
      )(
        versionData: versionData,
        songbookId: 10,
      );

      verify(() => songbookRepository.addVersionToSongbook(versionInput: any(named: "versionInput"), songbookId: 10))
          .called(1);
      verify(() => userSongbookRepository.updateTotalSongs(songbookId: any(named: "songbookId"))).called(1);
      verify(() => userVersionRepository.putVersionsToSongbook([versionResponse], 10)).called(1);
      verify(() => userVersionRepository.addVersionData(
            versionData: versionData,
            versionLocalDatabaseId: version.localDatabaseId!,
            songbookId: 10,
          )).called(1);

      verify(() => updateSongbookPreview(10)).called(1);
      expect(result.get(), versionResponse.songId);
    });

    test("and songbook is recents should return success", () async {
      when(() => songbookRepository.addVersionToSongbook(
          songbookId: any(named: "songbookId"),
          versionInput: any(named: "versionInput"))).thenAnswer((_) => Future.value(const Ok(null)));

      final result = await InsertVersionDataToSongbook(
        songbookRepository,
        userSongbookRepository,
        userVersionRepository,
        updateSongbookPreview,
      )(
        versionData: versionData,
        songbookId: 1,
      );

      verify(() => songbookRepository.addVersionToSongbook(
          songbookId: ListType.recents.localId, versionInput: any(named: "versionInput"))).called(1);
      verify(() => userSongbookRepository.updateTotalSongs(songbookId: any(named: "songbookId"))).called(1);
      verify(() => userVersionRepository.putVersionsToSongbook([Version.fromVersionData(versionData)], 1)).called(1);
      verify(() => userVersionRepository.addVersionData(
            versionData: versionData,
            versionLocalDatabaseId: version.localDatabaseId!,
            songbookId: 1,
          )).called(1);

      verify(() => updateSongbookPreview(1)).called(1);
      expect(result.get(), versionData.song.songId);
    });

    test("and songbook is recents and version already exists should overwrite and return success", () async {
      when(() => songbookRepository.addVersionToSongbook(
          songbookId: any(named: "songbookId"),
          versionInput: any(named: "versionInput"))).thenAnswer((_) => Future.value(const Ok(null)));

      final result = await InsertVersionDataToSongbook(
        songbookRepository,
        userSongbookRepository,
        userVersionRepository,
        updateSongbookPreview,
      )(versionData: versionData, songbookId: 1, versionLocalDatabaseId: 42);

      verify(() => songbookRepository.addVersionToSongbook(
          songbookId: ListType.recents.localId, versionInput: any(named: "versionInput"))).called(1);
      verify(() => userSongbookRepository.updateTotalSongs(songbookId: any(named: "songbookId"))).called(1);
      verify(() => userVersionRepository
          .putVersionsToSongbook([Version.fromVersionData(versionData).copyWith(localDatabaseId: 42)], 1)).called(1);
      verify(() => userVersionRepository.addVersionData(
            versionData: versionData,
            versionLocalDatabaseId: version.localDatabaseId!,
            songbookId: 1,
          )).called(1);

      verify(() => updateSongbookPreview(1)).called(1);
      expect(result.get(), versionData.song.songId);
    });
  });

  test("When call use case and request fails should return result error", () async {
    final versionData = getFakeVersionData();

    when(() => songbookRepository.addVersionToSongbook(
        songbookId: any(named: "songbookId"),
        versionInput: any(named: "versionInput"))).thenAnswer((_) => Future.value(Err(ServerError(statusCode: 404))));

    final result = await InsertVersionDataToSongbook(
      songbookRepository,
      userSongbookRepository,
      userVersionRepository,
      updateSongbookPreview,
    )(
      versionData: versionData,
      songbookId: 10,
    );

    verifyNever(() => userSongbookRepository.updateTotalSongs(songbookId: any(named: "songbookId")));

    verifyNever(() => updateSongbookPreview.call(any()));

    expect(result.isFailure, isTrue);
    expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "status code", 404));
  });
}
