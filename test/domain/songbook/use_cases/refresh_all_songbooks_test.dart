import 'package:cifraclub/domain/cifra/repository/user_cifra_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/refresh_all_songbooks.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_cifras_mock.dart';
import '../../../shared_mocks/domain/songbook/models/songbook_mock.dart';

class _SongbookRepositoryMock extends Mock implements SongbookRepository {}

class _UserSongbookRepositoryMock extends Mock implements UserSongbookRepository {}

class _UserCifraRepositoryMock extends Mock implements UserCifraRepository {}

class _UpdateSongbookPreviewMock extends Mock implements UpdateSongbookPreview {}

void main() {
  registerFallbackValue([getFakeSongbook()]);

  group("When request is successful", () {
    test("should replicate to local repository", () async {
      final songbookRepository = _SongbookRepositoryMock();
      final userSongbookRepository = _UserSongbookRepositoryMock();
      final userCifraRepository = _UserCifraRepositoryMock();
      final updateSongbookPreview = _UpdateSongbookPreviewMock();
      final songbookCifra = [
        getFakeSongbookCifras(),
        getFakeSongbookCifras(),
        getFakeSongbookCifras(listType: ListType.cantPlay)
      ];
      final songbooks = songbookCifra.map((e) => e.songbook).toList();

      when(songbookRepository.getAllSongbooks).thenAnswer((_) => SynchronousFuture(Ok(songbookCifra)));
      when(() => userSongbookRepository.setUserSongbooks(songbooks))
          .thenAnswer((_) => SynchronousFuture(songbooks.map((e) => e.id!).toList(growable: false)));
      when(() => userCifraRepository.addCifrasToSongbook(captureAny(), captureAny()))
          .thenAnswer((_) => SynchronousFuture([]));
      when(userCifraRepository.clearAllCifras).thenAnswer((_) => SynchronousFuture(null));
      when(() => updateSongbookPreview(any())).thenAnswer((_) => SynchronousFuture(1));

      final result = await RefreshAllSongbooks(
          songbookRepository, userSongbookRepository, userCifraRepository, updateSongbookPreview)();

      expect(result.isSuccess, isTrue);

      expect(result.getOrThrow(), songbooks);
      verify(() => userSongbookRepository.setUserSongbooks(songbooks)).called(1);
      verify(userCifraRepository.clearAllCifras).called(1);
      verify(() => updateSongbookPreview(any())).called(2);

      final songbookParams = verify(() => userCifraRepository.addCifrasToSongbook(captureAny(), captureAny())).captured;

      expect(songbookParams, [
        songbookCifra[0].cifras,
        songbookCifra[0].songbook.id,
        songbookCifra[1].cifras,
        songbookCifra[1].songbook.id,
        songbookCifra[2].cifras,
        songbookCifra[2].songbook.type.localId,
      ]);
    });
  });

  group("When request fails", () {
    test("should not replicate to local repository", () async {
      final songbookRepository = _SongbookRepositoryMock();
      final userSongbookRepository = _UserSongbookRepositoryMock();
      final userCifraRepository = _UserCifraRepositoryMock();
      final updateSongbookPreview = _UpdateSongbookPreviewMock();

      when(songbookRepository.getAllSongbooks).thenAnswer((_) => SynchronousFuture(Err(ConnectionError())));

      final result = await RefreshAllSongbooks(
          songbookRepository, userSongbookRepository, userCifraRepository, updateSongbookPreview)();

      expect(result.isFailure, isTrue);
      verifyNever(() => userSongbookRepository.setUserSongbooks(any()));
    });
  });
}
