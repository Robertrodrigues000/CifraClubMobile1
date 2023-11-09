import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/songbook/use_cases/favorite_unfavorite_version.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_is_favorite_version_by_song_id.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet_state.dart';
import 'package:cifraclub/domain/songbook/models/version_options_result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_plus/share_plus.dart';

import '../../../shared_mocks/domain/user/models/user_mock.dart';

class _GetIsFavoriteVersionBySongIdMock extends Mock implements GetIsFavoriteVersionBySongId {}

class _GetCredentialStreamMock extends Mock implements GetCredentialStream {}

class _FavoriteUnfavoriteVersionMock extends Mock implements FavoriteUnfavoriteVersion {}

class _OpenLoginPageMock extends Mock implements OpenLoginPage {
  static _OpenLoginPageMock newDummy() {
    final mock = _OpenLoginPageMock();
    when(mock.call).thenAnswer((_) => SynchronousFuture(null));
    return mock;
  }
}

class _ShareLinkMock extends Mock implements ShareLink {}

void main() {
  VersionOptionsBottomSheetBloc getBloc({
    _GetIsFavoriteVersionBySongIdMock? getIsFavoriteVersionBySongIdMock,
    _GetCredentialStreamMock? getCredentialStreamMock,
    _OpenLoginPageMock? openLoginPageMock,
    _ShareLinkMock? shareLinkMock,
    _FavoriteUnfavoriteVersionMock? favoriteUnfavoriteVersionMock,
    int? songId,
  }) =>
      VersionOptionsBottomSheetBloc(
        getIsFavoriteVersionBySongIdMock ?? _GetIsFavoriteVersionBySongIdMock(),
        getCredentialStreamMock ?? _GetCredentialStreamMock(),
        openLoginPageMock ?? _OpenLoginPageMock(),
        shareLinkMock ?? _ShareLinkMock(),
        favoriteUnfavoriteVersionMock ?? _FavoriteUnfavoriteVersionMock(),
        songId ?? 1,
      );

  group("when init is called", () {
// ignore: close_sinks
    BehaviorSubject<UserCredential> credentialStream =
        BehaviorSubject.seeded(UserCredential(isUserLoggedIn: true, user: getFakeUser()));

    final getCredentialStream = _GetCredentialStreamMock();
    when(getCredentialStream).thenAnswer((_) => credentialStream);

    final getIsFavoriteVersion = _GetIsFavoriteVersionBySongIdMock();
    when(() => getIsFavoriteVersion(any())).thenAnswer((_) => BehaviorSubject.seeded(false));

    blocTest(
      "should update state if user is logged in",
      build: () =>
          getBloc(getCredentialStreamMock: getCredentialStream, getIsFavoriteVersionBySongIdMock: getIsFavoriteVersion),
      act: (bloc) => bloc.init(),
      expect: () => [
        isA<VersionOptionsBottomSheetState>()
            .having((state) => state.isLoggedIn, "user is logged in", isTrue)
            .having((state) => state.isFavorite, "is version favorite", isFalse)
      ],
    );
  });

  group("when onFavorite is called", () {
    test("and state isFavorite is false", () async {
      final favoriteUnfavoriteVersion = _FavoriteUnfavoriteVersionMock();
      when(() => favoriteUnfavoriteVersion(
            artistUrl: any(named: 'artistUrl'),
            songUrl: any(named: 'songUrl'),
            isFavorite: any(named: "isFavorite"),
            songId: any(named: "songId"),
          )).thenAnswer((_) => SynchronousFuture(FavoriteVersionSuccess()));

      final bloc = getBloc(favoriteUnfavoriteVersionMock: favoriteUnfavoriteVersion, songId: 2);
      final result = await bloc.onFavorite('artistUrl', 'songUrl');

      verify(() => favoriteUnfavoriteVersion(
            artistUrl: 'artistUrl',
            songUrl: 'songUrl',
            isFavorite: false,
            songId: 2,
          )).called(1);
      expect(result, isA<FavoriteVersionSuccess>());
    });

    test("and state isFavorite is true", () async {
      final favoriteUnfavoriteVersion = _FavoriteUnfavoriteVersionMock();
      when(() => favoriteUnfavoriteVersion(
            artistUrl: any(named: 'artistUrl'),
            songUrl: any(named: 'songUrl'),
            isFavorite: any(named: "isFavorite"),
            songId: any(named: "songId"),
          )).thenAnswer((_) => SynchronousFuture(UnFavoriteVersionSuccess()));

      final bloc = getBloc(
        favoriteUnfavoriteVersionMock: favoriteUnfavoriteVersion,
        songId: 1,
      );
      bloc.emit(const VersionOptionsBottomSheetState(isFavorite: true));
      final result = await bloc.onFavorite('artistUrl', 'songUrl');

      expect(result, isA<UnFavoriteVersionSuccess>());
      verify(() => favoriteUnfavoriteVersion(
            artistUrl: 'artistUrl',
            songUrl: 'songUrl',
            isFavorite: true,
            songId: 1,
          )).called(1);
    });
  });

  test("when shareLink is called", () async {
    final shareLink = _ShareLinkMock();
    when(() => shareLink(link: "https://www.test.com", sharePositionOrigin: null))
        .thenAnswer((_) => SynchronousFuture(const ShareResult("raw", ShareResultStatus.success)));

    final bloc = getBloc(shareLinkMock: shareLink);
    await bloc.shareLink("https://www.test.com", null);

    verify(() => shareLink(link: "https://www.test.com")).called(1);
  });

  test("When openLoginPage is called should call openLoginPage use case", () async {
    final openLoginPage = _OpenLoginPageMock.newDummy();

    final bloc = getBloc(openLoginPageMock: openLoginPage);
    bloc.openLoginPage();
    verify(openLoginPage).called(1);
  });
}
