import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/app/models/app.dart';
import 'package:cifraclub/domain/app/use_cases/is_app_installed.dart';
import 'package:cifraclub/domain/app/use_cases/open_app_or_store.dart';
import 'package:cifraclub/domain/device/url_launcher/use_cases/open_url.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/logout.dart';
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/screens/more/models/app_item.dart';
import 'package:cifraclub/presentation/screens/more/more_bloc.dart';
import 'package:cifraclub/presentation/screens/more/more_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/user/models/user_mock.dart';

class _LogoutMock extends Mock implements Logout {}

class _GetCredentialStreamMock extends Mock implements GetCredentialStream {}

class _OpenAppOrStoreMock extends Mock implements OpenAppOrStore {}

class _IsAppInstalledMock extends Mock implements IsAppInstalled {}

class _OpenUrlMock extends Mock implements OpenUrl {}

class _OpenLoginPageMock extends Mock implements OpenLoginPage {}

class _OpenUserProfilePageMock extends Mock implements OpenUserProfilePage {}

void main() {
  MoreBloc getBloc({
    _GetCredentialStreamMock? getCredentialStream,
    _OpenAppOrStoreMock? openAppOrStore,
    _LogoutMock? logout,
    _IsAppInstalledMock? isAppInstalled,
    _OpenUrlMock? openUrl,
    _OpenLoginPageMock? openLoginPage,
    _OpenUserProfilePageMock? openUserProfilePage,
  }) =>
      MoreBloc(
          getCredentialStream ?? _GetCredentialStreamMock(),
          openAppOrStore ?? _OpenAppOrStoreMock(),
          logout ?? _LogoutMock(),
          isAppInstalled ?? _IsAppInstalledMock(),
          openUrl ?? _OpenUrlMock(),
          openLoginPage ?? _OpenLoginPageMock(),
          openUserProfilePage ?? _OpenUserProfilePageMock());

  test("When bloc is created, expect user to be null", () {
    final bloc = getBloc();
    expect(bloc.state, isA<MoreState>().having((state) => state.user, "user", isNull));
  });

  group("When init is called", () {
    group("and new user is emitted", () {
      // ignore: close_sinks
      BehaviorSubject<UserCredential> credentialStream =
          BehaviorSubject.seeded(const UserCredential(isUserLoggedIn: false));
      final user = getFakeUser();

      final getCredentialStream = _GetCredentialStreamMock();
      when(getCredentialStream).thenAnswer((_) => credentialStream);

      blocTest(
        "should update state with user from use case",
        build: () => getBloc(getCredentialStream: getCredentialStream),
        act: (bloc) {
          bloc.init([]);
          credentialStream.add(UserCredential(isUserLoggedIn: true, user: user));
        },
        verify: (bloc) => expect(bloc.state.user, user),
      );
    });

    group("with list of apps", () {
      // ignore: close_sinks
      BehaviorSubject<UserCredential> credentialStream =
          BehaviorSubject.seeded(const UserCredential(isUserLoggedIn: false));

      final getCredentialStream = _GetCredentialStreamMock();
      when(getCredentialStream).thenAnswer((_) => credentialStream);

      AppItem item = const AppItem(
        imageAsset: AppWebp.appTuner,
        title: 'legal',
        subtitle: 'olha só',
        app: App.afinador,
      );

      final isAppInstalled = _IsAppInstalledMock();
      when(() => isAppInstalled(item.app)).thenAnswer((_) => SynchronousFuture(true));

      blocTest(
        "should update state with verified installed apps",
        build: () => getBloc(
          getCredentialStream: getCredentialStream,
          isAppInstalled: isAppInstalled,
        ),
        act: (bloc) {
          bloc.init([item]);
        },
        verify: (bloc) => expect(bloc.state.installedApps, [item]),
      );
    });
  });

  group("When logout is called", () {
    final logout = _LogoutMock();
    when(logout.call).thenAnswer((invocation) => SynchronousFuture(null));
    blocTest(
      "should call logout use case",
      build: () => getBloc(logout: logout),
      act: (bloc) {
        bloc.logout();
      },
      verify: (bloc) {
        verify(logout.call).called(1);
      },
    );
  });

  group("When open app or store is called", () {
    final openAppOrStore = _OpenAppOrStoreMock();
    const App app = App.cifraClub;
    when(() => openAppOrStore.call(app)).thenAnswer((invocation) => SynchronousFuture(null));

    blocTest(
      "should call open app or store use case",
      build: () => getBloc(openAppOrStore: openAppOrStore),
      act: (bloc) {
        bloc.openAppOrStore(app);
      },
      verify: (bloc) {
        verify(() => openAppOrStore(app)).called(1);
      },
    );
  });

  group("When open url is called", () {
    final openUrl = _OpenUrlMock();
    String url = "https://stackoverflow.com/";
    when(() => openUrl.call(any())).thenAnswer((_) => SynchronousFuture(const Ok(null)));

    blocTest(
      "should call open url use case",
      build: () => getBloc(openUrl: openUrl),
      act: (bloc) {
        bloc.openUrl(url);
      },
      verify: (bloc) {
        verify(() => openUrl(url)).called(1);
      },
    );
  });

  group("When open login page is called", () {
    final openLoginPage = _OpenLoginPageMock();

    when(openLoginPage.call).thenAnswer((_) => SynchronousFuture(null));

    blocTest(
      "should call open login page use case",
      build: () => getBloc(openLoginPage: openLoginPage),
      act: (bloc) {
        bloc.openLoginPage();
      },
      verify: (bloc) {
        verify(openLoginPage).called(1);
      },
    );
  });

  group("When open user profile page is called", () {
    final openUserProfilePage = _OpenUserProfilePageMock();
    when(openUserProfilePage.call).thenAnswer((_) => SynchronousFuture(null));

    blocTest(
      "should call open user profile page use case",
      build: () => getBloc(openUserProfilePage: openUserProfilePage),
      act: (bloc) {
        bloc.openUserProfilePage();
      },
      verify: (bloc) {
        verify(openUserProfilePage).called(1);
      },
    );
  });
}
