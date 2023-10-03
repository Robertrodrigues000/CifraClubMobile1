import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_version_from_favorites.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

class _UserVersionRepositoryMock extends Mock implements UserVersionRepository {}

class _SongbookRepositoryMock extends Mock implements SongbookRepository {}

class _UserSongbookRepositoryMock extends Mock implements UserSongbookRepository {}

void main() {
  late _UserVersionRepositoryMock userVersionRepository;
  late _SongbookRepositoryMock songbookRepository;
  late _UserSongbookRepositoryMock userSongbookRepository;

  setUp(() {
    userVersionRepository = _UserVersionRepositoryMock();
    songbookRepository = _SongbookRepositoryMock();
    userSongbookRepository = _UserSongbookRepositoryMock();
  });

  test("When call use case and request is successful should delete version from favorites list", () async {
    final songbookId = ListType.favorites.localId;
    when(() => songbookRepository.deleteVersions(songbookId: songbookId, versionsId: [1]))
        .thenAnswer((_) => Future.value(const Ok(null)));
    when(() => userVersionRepository.deleteVersionBySongId(1, songbookId)).thenAnswer((_) => SynchronousFuture(true));
    when(() => userSongbookRepository.updateTotalSongs(songbookId: songbookId)).thenAnswer((_) => SynchronousFuture(1));

    final result =
        await DeleteVersionFromFavorites(userVersionRepository, songbookRepository, userSongbookRepository)(songId: 1);

    expect(result.isSuccess, isTrue);

    verify(() => userVersionRepository.deleteVersionBySongId(1, songbookId)).called(1);
    verify(() => userSongbookRepository.updateTotalSongs(songbookId: songbookId)).called(1);
  });

  test("When call use case and request fails should return request error", () async {
    final songbookId = ListType.favorites.localId;
    when(() => songbookRepository.deleteVersions(versionsId: [1], songbookId: songbookId))
        .thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    final result =
        await DeleteVersionFromFavorites(userVersionRepository, songbookRepository, userSongbookRepository)(songId: 1);

    expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "status code", 404));

    verifyNever(() => userVersionRepository.deleteVersionBySongId(1, songbookId));
    verifyNever(() => userSongbookRepository.updateTotalSongs(songbookId: songbookId));
  });
}
