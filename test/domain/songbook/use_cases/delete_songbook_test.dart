import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_songbook.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

class _SongbookRepositoryMock extends Mock implements SongbookRepository {}

class _UserSongbookRepositoryMock extends Mock implements UserSongbookRepository {}

class _UserVersionRepositoryMock extends Mock implements UserVersionRepository {}

void main() {
  group("When DeleteSongbook is called", () {
    test("and request is successful should delete local songbook", () async {
      final songbookRepository = _SongbookRepositoryMock();
      final userSongbookRepository = _UserSongbookRepositoryMock();
      final userVersionRepository = _UserVersionRepositoryMock();

      when(() => songbookRepository.deleteSongbook(any())).thenAnswer((_) => SynchronousFuture(const Ok(null)));
      when(() => userSongbookRepository.deleteUserSongbook(any())).thenAnswer((_) => SynchronousFuture(true));
      when(() => userVersionRepository.deleteVersionsBySongbookId(any())).thenAnswer((_) => SynchronousFuture(2));

      final request = await DeleteSongbook(songbookRepository, userSongbookRepository, userVersionRepository)(1000);

      expect(request.isSuccess, isTrue);
      verify(() => songbookRepository.deleteSongbook(any())).called(1);
      verify(() => userSongbookRepository.deleteUserSongbook(any())).called(1);
      verify(() => userVersionRepository.deleteVersionsBySongbookId(any())).called(1);
    });

    test("and request fails should return request error", () async {
      final songbookRepository = _SongbookRepositoryMock();
      final userSongbookRepository = _UserSongbookRepositoryMock();
      final userVersionRepository = _UserVersionRepositoryMock();

      when(() => songbookRepository.deleteSongbook(any())).thenAnswer((_) => SynchronousFuture(Err(ConnectionError())));
      when(() => userSongbookRepository.deleteUserSongbook(any())).thenAnswer((_) => SynchronousFuture(true));
      when(() => userVersionRepository.deleteVersionsBySongbookId(any())).thenAnswer((_) => SynchronousFuture(2));

      final request = await DeleteSongbook(songbookRepository, userSongbookRepository, userVersionRepository)(1000);

      expect(request.isFailure, isTrue);
      expect(request.getError(), isA<ConnectionError>());
      verify(() => songbookRepository.deleteSongbook(any())).called(1);
      verifyNever(() => userSongbookRepository.deleteUserSongbook(any()));
      verifyNever(() => userVersionRepository.deleteVersionsBySongbookId(any()));
    });
  });
}
