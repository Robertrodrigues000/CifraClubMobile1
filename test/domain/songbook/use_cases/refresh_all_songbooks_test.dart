import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/refresh_all_songbooks.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_preview.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_versions_mock.dart';
import '../../../shared_mocks/domain/songbook/models/songbook_mock.dart';

class _SongbookRepositoryMock extends Mock implements SongbookRepository {}

class _UserSongbookRepositoryMock extends Mock implements UserSongbookRepository {}

class _UserVersionRepositoryMock extends Mock implements UserVersionRepository {}

class _UpdateSongbookPreviewMock extends Mock implements UpdateSongbookPreview {}

void main() {
  registerFallbackValue([getFakeSongbook()]);

  group("When request is successful", () {
    test("should replicate to local repository", () async {
      final songbookRepository = _SongbookRepositoryMock();
      final userSongbookRepository = _UserSongbookRepositoryMock();
      final userVersionRepository = _UserVersionRepositoryMock();
      final updateSongbookPreview = _UpdateSongbookPreviewMock();
      final songbookVersion = [
        getFakeSongbookVersions(),
        getFakeSongbookVersions(),
        getFakeSongbookVersions(listType: ListType.cantPlay),
        getFakeSongbookVersions(listType: ListType.recents),
      ];
      final songbooks = songbookVersion.map((e) => e.songbook).toList();

      when(songbookRepository.getAllSongbooks).thenAnswer((_) => Future.value(Ok(songbookVersion)));
      when(() => userSongbookRepository.setUserSongbooks(songbooks))
          .thenAnswer((_) => Future.value(songbooks.map((e) => e.id!).toList(growable: false)));
      when(() => userVersionRepository.addVersionsToSongbook(captureAny(), captureAny()))
          .thenAnswer((_) => Future.value([]));
      when(() => userVersionRepository.addVersionsToRecentSongbook(captureAny())).thenAnswer((_) => Future.value([]));
      when(userVersionRepository.clearAllVersions).thenAnswer((_) => Future.value(null));
      when(() => updateSongbookPreview(any())).thenAnswer((_) => Future.value(1));

      final result = await RefreshAllSongbooks(
          songbookRepository, userSongbookRepository, userVersionRepository, updateSongbookPreview)();

      expect(result.isSuccess, isTrue);

      expect(result.getOrThrow(), songbooks);
      verify(() => userSongbookRepository.setUserSongbooks(songbooks)).called(1);
      verify(userVersionRepository.clearAllVersions).called(1);
      verify(() => updateSongbookPreview(any())).called(2);

      final songbookParams =
          verify(() => userVersionRepository.addVersionsToSongbook(captureAny(), captureAny())).captured;

      expect(songbookParams, [
        songbookVersion[0].versions,
        songbookVersion[0].songbook.id,
        songbookVersion[1].versions,
        songbookVersion[1].songbook.id,
        songbookVersion[2].versions,
        songbookVersion[2].songbook.type.localId,
      ]);

      final recentSongbookParams =
          verify(() => userVersionRepository.addVersionsToRecentSongbook(captureAny())).captured;

      expect(recentSongbookParams, [songbookVersion[3].versions]);
    });
  });

  group("When request fails", () {
    test("should not replicate to local repository", () async {
      final songbookRepository = _SongbookRepositoryMock();
      final userSongbookRepository = _UserSongbookRepositoryMock();
      final userVersionRepository = _UserVersionRepositoryMock();
      final updateSongbookPreview = _UpdateSongbookPreviewMock();

      when(songbookRepository.getAllSongbooks).thenAnswer((_) => Future.value(Err(ConnectionError())));

      final result = await RefreshAllSongbooks(
          songbookRepository, userSongbookRepository, userVersionRepository, updateSongbookPreview)();

      expect(result.isFailure, isTrue);
      verifyNever(() => userSongbookRepository.setUserSongbooks(any()));
    });
  });
}
