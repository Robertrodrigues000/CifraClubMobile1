import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook_error.dart';
import 'package:cifraclub/domain/songbook/models/version_options_result.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_version_from_favorites_or_can_play.dart';
import 'package:cifraclub/domain/songbook/use_cases/favorite_unfavorite_version.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_to_songbook.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _InsertVersionToSongbookMock extends Mock implements InsertVersionToSongbook {}

class _DeleteVersionFromFavoritesAndCanPlayMock extends Mock implements DeleteVersionFromFavoritesOrCanPlay {}

class _UserVersionRepositoryMock extends Mock implements UserVersionRepository {}

void main() {
  FavoriteUnfavoriteVersion getUseCase({
    _InsertVersionToSongbookMock? insertVersionToSongbookMock,
    _DeleteVersionFromFavoritesAndCanPlayMock? deleteVersionFromFavoritesOrCanPlayMock,
    _UserVersionRepositoryMock? userVersionRepositoryMock,
  }) =>
      FavoriteUnfavoriteVersion(
        insertVersionToSongbookMock ?? _InsertVersionToSongbookMock(),
        deleteVersionFromFavoritesOrCanPlayMock ?? _DeleteVersionFromFavoritesAndCanPlayMock(),
        userVersionRepositoryMock ?? _UserVersionRepositoryMock(),
      );

  setUpAll(() {
    registerFallbackValue(getFakeVersion());
  });

  test("When is to add version from favorite songbook should return FavoriteVersionSuccess", () async {
    final insertVersionToSongbook = _InsertVersionToSongbookMock();

    when(() => insertVersionToSongbook(
          artistUrl: any(named: "artistUrl"),
          songUrl: any(named: "songUrl"),
          songbookId: any(named: "songbookId"),
          isPro: any(named: "isPro"),
        )).thenAnswer((_) => SynchronousFuture(const Ok(1)));

    final result = await getUseCase(insertVersionToSongbookMock: insertVersionToSongbook)(
      artistUrl: "marilia",
      songUrl: "novo",
      isFavorite: false,
      songId: 10,
    );

    expect(result, isA<FavoriteVersionSuccess>());
    verify(() => insertVersionToSongbook(songbookId: ListType.favorites.localId, artistUrl: "marilia", songUrl: "novo"))
        .called(1);
  });

  test("When is to add version from favorite songbook and request fails should return FavoriteVersionError", () async {
    final insertVersionToSongbook = _InsertVersionToSongbookMock();

    when(() => insertVersionToSongbook(
          artistUrl: any(named: "artistUrl"),
          songUrl: any(named: "songUrl"),
          songbookId: any(named: "songbookId"),
          isPro: any(named: "isPro"),
        )).thenAnswer((_) => SynchronousFuture(Err(SongbookRequestError(ConnectionError()))));

    final result = await getUseCase(insertVersionToSongbookMock: insertVersionToSongbook)(
      artistUrl: "marilia",
      songUrl: "novo",
      isFavorite: false,
      songId: 10,
    );

    expect(result, isA<FavoriteVersionError>());
    verify(() => insertVersionToSongbook(songbookId: ListType.favorites.localId, artistUrl: "marilia", songUrl: "novo"))
        .called(1);
  });

  test("When is to remove version from favorite songbook should return UnFavoriteVersionSuccess", () async {
    final deleteVersionFromFavoritesOrCanPlay = _DeleteVersionFromFavoritesAndCanPlayMock();
    final userVersionRepository = _UserVersionRepositoryMock();
    final version = getFakeVersion();

    when(() => userVersionRepository.getVersionBySongId(any(), any())).thenAnswer((_) => SynchronousFuture(version));
    when(() => deleteVersionFromFavoritesOrCanPlay(
          songbookId: any(named: "songbookId"),
          version: any(named: "version"),
        )).thenAnswer((_) => SynchronousFuture(const Ok(null)));

    final result = await getUseCase(
      userVersionRepositoryMock: userVersionRepository,
      deleteVersionFromFavoritesOrCanPlayMock: deleteVersionFromFavoritesOrCanPlay,
    )(
      artistUrl: "marilia",
      songUrl: "novo",
      isFavorite: true,
      songId: 10,
    );

    expect(result, isA<UnFavoriteVersionSuccess>());
    verify(() => userVersionRepository.getVersionBySongId(ListType.favorites.localId, 10)).called(1);
    verify(() => deleteVersionFromFavoritesOrCanPlay(
          songbookId: ListType.favorites.localId,
          version: version,
        )).called(1);
  });

  test("When is to remove version from favorite and fails to get version songbook should return UnFavoriteVersionError",
      () async {
    final userVersionRepository = _UserVersionRepositoryMock();

    when(() => userVersionRepository.getVersionBySongId(any(), any())).thenAnswer((_) => SynchronousFuture(null));

    final result = await getUseCase(
      userVersionRepositoryMock: userVersionRepository,
    )(
      artistUrl: "marilia",
      songUrl: "novo",
      isFavorite: true,
      songId: 10,
    );

    expect(result, isA<UnFavoriteVersionError>());
    verify(() => userVersionRepository.getVersionBySongId(ListType.favorites.localId, 10)).called(1);
  });

  test("When is to remove version from favorite songbook and request fails should return UnFavoriteVersionError",
      () async {
    final deleteVersionFromFavoritesOrCanPlay = _DeleteVersionFromFavoritesAndCanPlayMock();
    final userVersionRepository = _UserVersionRepositoryMock();
    final version = getFakeVersion();

    when(() => userVersionRepository.getVersionBySongId(any(), any())).thenAnswer((_) => SynchronousFuture(version));
    when(() => deleteVersionFromFavoritesOrCanPlay(
          songbookId: any(named: "songbookId"),
          version: any(named: "version"),
        )).thenAnswer((_) => SynchronousFuture(Err(ConnectionError())));

    final result = await getUseCase(
      userVersionRepositoryMock: userVersionRepository,
      deleteVersionFromFavoritesOrCanPlayMock: deleteVersionFromFavoritesOrCanPlay,
    )(
      artistUrl: "marilia",
      songUrl: "novo",
      isFavorite: true,
      songId: 10,
    );

    expect(result, isA<UnFavoriteVersionError>());
    verify(() => userVersionRepository.getVersionBySongId(ListType.favorites.localId, 10)).called(1);
    verify(() => deleteVersionFromFavoritesOrCanPlay(
          songbookId: ListType.favorites.localId,
          version: version,
        )).called(1);
  });
}
