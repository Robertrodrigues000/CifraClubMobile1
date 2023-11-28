import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/app/models/app.dart';
import 'package:cifraclub/domain/app/use_cases/is_app_installed.dart';
import 'package:cifraclub/domain/app/use_cases/open_app_or_store.dart';
import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/songbook/use_cases/favorite_unfavorite_version.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_is_favorite_version_by_song_id.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/domain/version/models/musical_scale.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet_state.dart';
import 'package:cifraclub/domain/songbook/models/version_options_result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_plus/share_plus.dart';

import '../../../shared_mocks/domain/user/models/user_mock.dart';
import '../../../shared_mocks/domain/version/models/version_data_mock.dart';

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

class _OpenAppOrStoreMock extends Mock implements OpenAppOrStore {}

class _IsAppInstalledMock extends Mock implements IsAppInstalled {}

void main() {
  VersionOptionsBottomSheetBloc getBloc({
    _GetIsFavoriteVersionBySongIdMock? getIsFavoriteVersionBySongIdMock,
    _GetCredentialStreamMock? getCredentialStreamMock,
    _OpenLoginPageMock? openLoginPageMock,
    _ShareLinkMock? shareLinkMock,
    _OpenAppOrStoreMock? openAppOrStoreMock,
    _IsAppInstalledMock? isAppInstalledMock,
    _FavoriteUnfavoriteVersionMock? favoriteUnfavoriteVersionMock,
    int? songId,
    VersionData? versionData,
    bool? isPro,
  }) =>
      VersionOptionsBottomSheetBloc(
        getIsFavoriteVersionBySongIdMock ?? _GetIsFavoriteVersionBySongIdMock(),
        getCredentialStreamMock ?? _GetCredentialStreamMock(),
        openLoginPageMock ?? _OpenLoginPageMock(),
        shareLinkMock ?? _ShareLinkMock(),
        openAppOrStoreMock ?? _OpenAppOrStoreMock(),
        isAppInstalledMock ?? _IsAppInstalledMock(),
        favoriteUnfavoriteVersionMock ?? _FavoriteUnfavoriteVersionMock(),
        songId ?? 1,
        versionData,
        isPro ?? false,
      );

  group("when init is called and versionData is null", () {
// ignore: close_sinks
    BehaviorSubject<UserCredential> credentialStream =
        BehaviorSubject.seeded(UserCredential(isUserLoggedIn: true, user: getFakeUser()));

    final getCredentialStream = _GetCredentialStreamMock();
    when(getCredentialStream).thenAnswer((_) => credentialStream);

    final getIsFavoriteVersion = _GetIsFavoriteVersionBySongIdMock();
    when(() => getIsFavoriteVersion(any())).thenAnswer((_) => BehaviorSubject.seeded(false));

    blocTest(
      "should update state if user is logged in",
      build: () => getBloc(
          getCredentialStreamMock: getCredentialStream,
          getIsFavoriteVersionBySongIdMock: getIsFavoriteVersion,
          versionData: null),
      act: (bloc) => bloc.init(),
      expect: () => [
        isA<VersionOptionsBottomSheetState>()
            .having((state) => state.isLoggedIn, "user is logged in", isTrue)
            .having((state) => state.isFavorite, "is version favorite", isFalse)
      ],
    );
  });

  group("when init is called and versionData is not null", () {
// ignore: close_sinks
    BehaviorSubject<UserCredential> credentialStream =
        BehaviorSubject.seeded(UserCredential(isUserLoggedIn: true, user: getFakeUser()));

    registerFallbackValue(App.afinador);

    final getCredentialStream = _GetCredentialStreamMock();
    when(getCredentialStream).thenAnswer((_) => credentialStream);

    final getIsFavoriteVersion = _GetIsFavoriteVersionBySongIdMock();
    when(() => getIsFavoriteVersion(any())).thenAnswer((_) => BehaviorSubject.seeded(false));

    final isAppInstalled = _IsAppInstalledMock();
    when(() => isAppInstalled(App.afinador)).thenAnswer((_) => SynchronousFuture(true));

    final versionData = getFakeVersionData(key: "F");

    blocTest(
      "should update state with user and versionData info",
      build: () => getBloc(
        getCredentialStreamMock: getCredentialStream,
        getIsFavoriteVersionBySongIdMock: getIsFavoriteVersion,
        isAppInstalledMock: isAppInstalled,
        versionData: versionData,
        isPro: false,
      ),
      act: (bloc) => bloc.init(),
      expect: () => [
        isA<VersionOptionsBottomSheetState>()
            .having((state) => state.isLoggedIn, "user is logged in", isFalse)
            .having((state) => state.isFavorite, "is version favorite", isFalse),
        isA<VersionOptionsBottomSheetState>()
            .having((state) => state.isPro, "is user pro", isFalse)
            .having((state) => state.isTunerInstalled, "is tuner installed", isTrue)
            .having((state) => state.originalKey, "version key", versionData.key)
            .having((state) => state.selectedKey, "selected key", versionData.stdKey)
            .having(
                (state) => state.musicalScale, "musical scale", MusicalScale.getMusicalScaleByKey(versionData.stdKey))
            .having((state) => state.selectedVersion, "version name", versionData.versionName)
            .having((state) => state.instrument, "instrument", versionData.instrument)
            .having((state) => state.tuning, "tuning", versionData.tuning?.value)
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

  test("When openAppOrStore is called should call openAppOrStore use case", () async {
    final openAppOrStore = _OpenAppOrStoreMock();
    when(() => openAppOrStore.call(any())).thenAnswer((_) => Future.value());

    final bloc = getBloc(openAppOrStoreMock: openAppOrStore);
    await bloc.openAppOrStore();

    verify(() => openAppOrStore(any())).called(1);
  });

  test("when toggleBeatVisibility is called should switch", () async {
    final bloc = getBloc();
    expect(bloc.state.isBeatVisible, isTrue);

    bloc.toggleBeatVisibility();
    expect(bloc.state.isBeatVisible, isFalse);
  });

  test("when toggleTabsVisibility is called should switch", () async {
    final bloc = getBloc();
    expect(bloc.state.isTabVisible, isTrue);

    bloc.toggleTabsVisibility();
    expect(bloc.state.isTabVisible, isFalse);
  });

  test("when toggleLeftHanded is called should switch", () async {
    final bloc = getBloc();
    expect(bloc.state.isLeftHanded, isFalse);

    bloc.toggleLeftHanded();
    expect(bloc.state.isLeftHanded, isTrue);
  });
}
