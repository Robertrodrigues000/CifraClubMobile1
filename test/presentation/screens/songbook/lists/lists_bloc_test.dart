import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/logout.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../shared_mocks/domain/user/models/user_mock.dart';

class _LogoutMock extends Mock implements Logout {
  static _LogoutMock newDummy() {
    final mock = _LogoutMock();
    when(mock.call).thenAnswer((_) => SynchronousFuture(null));
    return mock;
  }
}

class _OpenLoginPageMock extends Mock implements OpenLoginPage {
  static _OpenLoginPageMock newDummy() {
    final mock = _OpenLoginPageMock();
    when(mock.call).thenAnswer((_) => SynchronousFuture(null));
    return mock;
  }
}

class _OpenUserProfileMock extends Mock implements OpenUserProfilePage {
  static _OpenUserProfileMock newDummy() {
    final mock = _OpenUserProfileMock();
    when(mock.call).thenAnswer((_) => SynchronousFuture(null));
    return mock;
  }
}

class _GetCredentialStreamMock extends Mock implements GetCredentialStream {
  static _GetCredentialStreamMock newDummy(
      [UserCredential credentials = const UserCredential(isUserLoggedIn: false, user: null)]) {
    final mock = _GetCredentialStreamMock();
    when(mock.call).thenAnswer((_) => BehaviorSubject.seeded(credentials));
    return mock;
  }
}

void main() {
  ListsBloc getBloc({
    _LogoutMock? logoutMock,
    _GetCredentialStreamMock? getCredentialStreamMock,
    _OpenLoginPageMock? openLoginPageMock,
    _OpenUserProfileMock? openUserProfileMock,
  }) =>
      ListsBloc(getCredentialStreamMock ?? _GetCredentialStreamMock(), logoutMock ?? _LogoutMock(),
          openLoginPageMock ?? _OpenLoginPageMock(), openUserProfileMock ?? _OpenUserProfileMock());

  test("When logout should call 'Logout' use case", () async {
    final logout = _LogoutMock.newDummy();

    final bloc = getBloc(logoutMock: logout);

    await bloc.logout();

    verify(logout).called(1);
  });

  test("When login page should call 'OpenLoginPage' use case", () async {
    final loginPage = _OpenLoginPageMock.newDummy();

    final bloc = getBloc(openLoginPageMock: loginPage);

    bloc.openLoginPage();

    verify(loginPage).called(1);
  });

  test("When profile page should call 'OpenUserProfilePage' use case", () async {
    final userProfilePage = _OpenUserProfileMock.newDummy();

    final bloc = getBloc(openUserProfileMock: userProfilePage);

    bloc.openUserProfilePage();

    verify(userProfilePage).called(1);
  });

  group("When credential stream is updated", () {
    group("When user login", () {
      final user = getFakeUser();
      final credentialStream = _GetCredentialStreamMock.newDummy(UserCredential(isUserLoggedIn: true, user: user));

      blocTest(
        "should update user state to not null",
        build: () => getBloc(getCredentialStreamMock: credentialStream),
        act: (bloc) => bloc.init(),
        expect: () => [
          isA<ListsState>().having((state) => state.user, "user not null", user),
        ],
      );
    });

    group("When is not login", () {
      final credentialStream = _GetCredentialStreamMock.newDummy();

      blocTest(
        "should update user state to null",
        build: () => getBloc(getCredentialStreamMock: credentialStream),
        act: (bloc) => bloc.init(),
        expect: () => [
          isA<ListsState>().having((state) => state.user, "user null", null),
        ],
      );
    });
  });
}
