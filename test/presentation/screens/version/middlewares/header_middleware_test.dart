import 'dart:async';

import 'package:cifraclub/domain/songbook/models/version_options_result.dart';
import 'package:cifraclub/domain/songbook/use_cases/favorite_unfavorite_version.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_is_favorite_version_by_song_id.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/header_middleware.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../shared_mocks/domain/user/models/run_if_user_is_logged_in_mock.dart';
import '../../../../shared_mocks/domain/version/models/version_data_mock.dart';

class _GetIsFavoriteVersionBySongIdMock extends Mock implements GetIsFavoriteVersionBySongId {}

class _FavoriteUnfavoriteVersionMock extends Mock implements FavoriteUnfavoriteVersion {}

class _CompositeSubscriptionMock extends Mock implements CompositeSubscription {}

void main() {
  group("When action is OnTapFavoriteButton", () {
    final favoriteUnfavoriteVersion = _FavoriteUnfavoriteVersionMock();
    final middleware = HeaderMiddleware(
      _GetIsFavoriteVersionBySongIdMock(),
      favoriteUnfavoriteVersion,
      RunIfUserIsLoggedInMock.getDummy(),
    );

    test("and use case return success should change is favorite status", () async {
      when(() => favoriteUnfavoriteVersion(
            artistUrl: any(named: "artistUrl"),
            isFavorite: any(named: "isFavorite"),
            songId: any(named: "songId"),
            songUrl: any(named: "songUrl"),
          )).thenAnswer((invocation) => SynchronousFuture(FavoriteVersionSuccess()));
      final version = getFakeVersionData();
      final actionStream = PublishSubject<VersionAction>();

      expectLater(
        actionStream.stream,
        emitsInOrder([isA<OnFavoriteChange>().having((action) => action.isFavorite, "isFavorite", true)]),
      );

      middleware.onAction(
        OnTapFavoriteButton(),
        VersionState(versionHeaderState: const VersionHeaderState(isFavorite: false), version: version),
        actionStream.add,
      );

      verify(() => favoriteUnfavoriteVersion(
            artistUrl: version.artist!.url,
            isFavorite: false,
            songId: version.song.songId,
            songUrl: version.song.url,
          )).called(1);
      await actionStream.close();
    });

    test("and use case fails should not change is favorite status", () async {
      when(() => favoriteUnfavoriteVersion(
            artistUrl: any(named: "artistUrl"),
            isFavorite: any(named: "isFavorite"),
            songId: any(named: "songId"),
            songUrl: any(named: "songUrl"),
          )).thenAnswer((invocation) => SynchronousFuture(FavoriteVersionError()));
      final version = getFakeVersionData();
      final actionStream = PublishSubject<VersionAction>();

      expectLater(
        actionStream.stream,
        emitsInOrder([
          isA<OnFavoriteChange>().having((action) => action.isFavorite, "isFavorite", true),
          isA<OnFavoriteChange>().having((action) => action.isFavorite, "isFavorite", false),
        ]),
      );

      middleware.onAction(
        OnTapFavoriteButton(),
        VersionState(versionHeaderState: const VersionHeaderState(isFavorite: false), version: version),
        actionStream.add,
      );

      verify(() => favoriteUnfavoriteVersion(
            artistUrl: version.artist!.url,
            isFavorite: false,
            songId: version.song.songId,
            songUrl: version.song.url,
          )).called(1);
      await actionStream.close();
    });
  });

  group("When action is OnVersionLoaded", () {
    final getIsFavoriteVersionBySongId = _GetIsFavoriteVersionBySongIdMock();
    final middleware = HeaderMiddleware(
      getIsFavoriteVersionBySongId,
      _FavoriteUnfavoriteVersionMock(),
      RunIfUserIsLoggedInMock.getDummy(),
    );

    test("change favorite status if emited value is a new value", () async {
      final completer = Completer<VersionAction>();
      when(() => getIsFavoriteVersionBySongId(any())).thenAnswer((_) => BehaviorSubject.seeded(true));

      middleware.onAction(
        OnVersionLoaded(getFakeVersionData(songId: 1)),
        VersionState(
          versionHeaderState: const VersionHeaderState(isFavorite: false),
          version: getFakeVersionData(songId: 2),
        ),
        completer.complete,
      );

      final versionAction = await completer.future;
      expect(versionAction, isA<OnFavoriteChange>().having((value) => value.isFavorite, "isFavorite", true));
    });
  });

  test("When call close should cancel subscriptions", () {
    final middleware = HeaderMiddleware(
      _GetIsFavoriteVersionBySongIdMock(),
      _FavoriteUnfavoriteVersionMock(),
      RunIfUserIsLoggedInMock.getDummy(),
    );
    final compositeSubscription = _CompositeSubscriptionMock();
    middleware.compositeSubscription = compositeSubscription;

    when(compositeSubscription.cancel).thenAnswer((_) => SynchronousFuture(null));

    middleware.close();
    verify(middleware.compositeSubscription.cancel).called(1);

    compositeSubscription.cancel();
  });
}
