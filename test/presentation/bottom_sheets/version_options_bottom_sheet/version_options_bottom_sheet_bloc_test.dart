import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_version_from_favorites.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_is_favorite_version_by_song_id.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_to_songbook.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet_state.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_plus/share_plus.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/user/models/user_mock.dart';

class _InsertVersionToSongbookMock extends Mock implements InsertVersionToSongbook {}

class _GetIsFavoriteVersionBySongIdMock extends Mock implements GetIsFavoriteVersionBySongId {}

class _DeleteVersionFromFavoritesMock extends Mock implements DeleteVersionFromFavorites {}

class _GetCredentialStreamMock extends Mock implements GetCredentialStream {}

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
    _InsertVersionToSongbookMock? insertVersionToSongbookMock,
    _GetIsFavoriteVersionBySongIdMock? getIsFavoriteVersionBySongIdMock,
    _DeleteVersionFromFavoritesMock? deleteVersionFromFavoritesMock,
    _GetCredentialStreamMock? getCredentialStreamMock,
    _OpenLoginPageMock? openLoginPageMock,
    _ShareLinkMock? shareLinkMock,
    int? songId,
  }) =>
      VersionOptionsBottomSheetBloc(
        insertVersionToSongbookMock ?? _InsertVersionToSongbookMock(),
        getIsFavoriteVersionBySongIdMock ?? _GetIsFavoriteVersionBySongIdMock(),
        deleteVersionFromFavoritesMock ?? _DeleteVersionFromFavoritesMock(),
        getCredentialStreamMock ?? _GetCredentialStreamMock(),
        openLoginPageMock ?? _OpenLoginPageMock(),
        shareLinkMock ?? _ShareLinkMock(),
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
      final insertVersionToSongbook = _InsertVersionToSongbookMock();
      when(() => insertVersionToSongbook(
          artistUrl: any(named: 'artistUrl'),
          songUrl: any(named: 'songUrl'),
          songbookId: any(named: 'songbookId'))).thenAnswer((_) => SynchronousFuture(const Ok(1)));

      final bloc = getBloc(insertVersionToSongbookMock: insertVersionToSongbook);
      final result = await bloc.onFavorite('artistUrl', 'songUrl');

      verify(() => insertVersionToSongbook.call(
          songbookId: any(named: "songbookId"),
          artistUrl: any(named: "artistUrl"),
          songUrl: any(named: "songUrl"))).called(1);
      expect(result, isA<FavoriteVersionSuccess>());
    });
    test("and state isFavorite is true", () async {
      final deleteVersionFromSongbook = _DeleteVersionFromFavoritesMock();
      when(() => deleteVersionFromSongbook(songId: any(named: 'songId')))
          .thenAnswer((_) => SynchronousFuture(const Ok(null)));

      final bloc = getBloc(
        deleteVersionFromFavoritesMock: deleteVersionFromSongbook,
        songId: 2,
      );
      bloc.emit(const VersionOptionsBottomSheetState(isFavorite: true));
      final result = await bloc.onFavorite('artistUrl', 'songUrl');

      expect(result, isA<UnFavoriteVersionSuccess>());
      verify(() => deleteVersionFromSongbook.call(songId: any(named: 'songId'))).called(1);
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
