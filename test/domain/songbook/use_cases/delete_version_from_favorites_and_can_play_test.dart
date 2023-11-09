import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_version_from_favorites_or_can_play.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_version_input_mock.dart';
import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _UserVersionRepositoryMock extends Mock implements UserVersionRepository {}

class _SongbookRepositoryMock extends Mock implements SongbookRepository {}

class _UserSongbookRepositoryMock extends Mock implements UserSongbookRepository {}

void main() {
  late _UserVersionRepositoryMock userVersionRepository;
  late _SongbookRepositoryMock songbookRepository;
  late _UserSongbookRepositoryMock userSongbookRepository;
  final songbookId = ListType.favorites.localId;
  final version = getFakeVersion();

  setUp(() {
    userVersionRepository = _UserVersionRepositoryMock();
    songbookRepository = _SongbookRepositoryMock();
    userSongbookRepository = _UserSongbookRepositoryMock();
    registerFallbackValue(getFakeSongbookVersionInput());
  });

  test("When call use case and request is successful should delete version from favorites list", () async {
    when(() => songbookRepository.deleteVersionsFromFavoriteAndCanPlay(
        songbookId: songbookId,
        versionInput: any(named: "versionInput"))).thenAnswer((_) => Future.value(const Ok(null)));
    when(() => userVersionRepository.deleteVersionsById([version.localDatabaseId!], songbookId))
        .thenAnswer((_) => SynchronousFuture(1));
    when(() => userSongbookRepository.updateTotalSongs(songbookId: songbookId)).thenAnswer((_) => SynchronousFuture(1));

    final result = await DeleteVersionFromFavoritesOrCanPlay(
      userVersionRepository,
      songbookRepository,
      userSongbookRepository,
    )(songbookId: songbookId, version: version);

    expect(result.isSuccess, isTrue);

    verify(() => userVersionRepository.deleteVersionsById([version.localDatabaseId!], songbookId)).called(1);
    verify(() => userSongbookRepository.updateTotalSongs(songbookId: songbookId)).called(1);
  });

  test("When call use case and request fails should return request error", () async {
    when(() => songbookRepository.deleteVersionsFromFavoriteAndCanPlay(
            songbookId: songbookId, versionInput: any(named: "versionInput")))
        .thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    final result = await DeleteVersionFromFavoritesOrCanPlay(
      userVersionRepository,
      songbookRepository,
      userSongbookRepository,
    )(songbookId: songbookId, version: version);

    expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "status code", 404));

    verifyNever(() => userVersionRepository.deleteVersionsById([version.localDatabaseId!], songbookId));
    verifyNever(() => userSongbookRepository.updateTotalSongs(songbookId: songbookId));
  });
}
