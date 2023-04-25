import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_user_songbooks.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/refresh_all_songbooks.dart';
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
import 'package:typed_result/typed_result.dart';

import '../../../../shared_mocks/domain/songbook/models/songbook_mock.dart';
import '../../../../shared_mocks/domain/user/models/user_mock.dart';

class _InsertUserSongbookMock extends Mock implements InsertUserSongbook {}

class _RefreshAllSongbooksMock extends Mock implements RefreshAllSongbooks {
  _RefreshAllSongbooksMock(Result<List<Songbook>, RequestError> response) {
    when(call).thenAnswer((_) => SynchronousFuture(response));
  }
}

class _GetAllUserSongbooksMock extends Mock implements GetAllUserSongbooks {
  _GetAllUserSongbooksMock(List<Songbook> songbooks) {
    when(call).thenAnswer((_) => BehaviorSubject.seeded(songbooks));
  }
}

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
  static _GetCredentialStreamMock newDummy([
    UserCredential credentials = const UserCredential(isUserLoggedIn: false, user: null),
  ]) {
    final mock = _GetCredentialStreamMock();
    when(mock.call).thenAnswer((_) => BehaviorSubject.seeded(credentials));
    return mock;
  }
}

void main() {
  ListsBloc getBloc({
    _InsertUserSongbookMock? insertUserSongbookMock,
    _RefreshAllSongbooksMock? refreshAllSongbooksMock,
    _GetAllUserSongbooksMock? getAllUserSongbooksMock,
    _LogoutMock? logoutMock,
    _GetCredentialStreamMock? getCredentialStreamMock,
    _OpenLoginPageMock? openLoginPageMock,
    _OpenUserProfileMock? openUserProfileMock,
  }) =>
      ListsBloc(
        insertUserSongbookMock ?? _InsertUserSongbookMock(),
        refreshAllSongbooksMock ?? _RefreshAllSongbooksMock(Err(ConnectionError())),
        getAllUserSongbooksMock ?? _GetAllUserSongbooksMock([]),
        getCredentialStreamMock ?? _GetCredentialStreamMock.newDummy(),
        logoutMock ?? _LogoutMock(),
        openLoginPageMock ?? _OpenLoginPageMock(),
        openUserProfileMock ?? _OpenUserProfileMock(),
      );

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

  group("When bloc is created", () {
    group("with songbooks created", () {
      final songbooks = ListType.values.map((type) => getFakeSongbook().copyWith(type: type)).toList(growable: false);

      blocTest(
        "should update user and special lists",
        build: () => getBloc(getAllUserSongbooksMock: _GetAllUserSongbooksMock(songbooks)),
        act: (bloc) => bloc.init(),
        verify: (bloc) {
          expect(bloc.state.userLists.length, 1);
          expect(bloc.state.specialLists.length, ListType.values.length - 1);
        },
      );
    });

    group("with logged in user", () {
      final user = getFakeUser();
      final credentialStream = _GetCredentialStreamMock.newDummy(UserCredential(isUserLoggedIn: true, user: user));

      blocTest(
        "should update user state to not null",
        build: () => getBloc(getCredentialStreamMock: credentialStream),
        act: (bloc) => bloc.init(),
        verify: (bloc) => expect(bloc.state.user, user),
      );
    });

    group("with logged out user", () {
      final credentialStream = _GetCredentialStreamMock.newDummy();

      blocTest(
        "should update user state to null",
        build: () => getBloc(getCredentialStreamMock: credentialStream),
        act: (bloc) => bloc.init(),
        verify: (bloc) => expect(bloc.state.user, isNull),
      );
    });

    group("when syncing", () {
      final refreshAllSongbooksMock = _RefreshAllSongbooksMock(const Ok([]));

      blocTest(
        "should call use case and emit syncing states",
        build: () => getBloc(refreshAllSongbooksMock: refreshAllSongbooksMock),
        act: (bloc) => bloc.syncList(),
        expect: () => [
          isA<ListsState>().having((state) => state.isSyncing, "isSyncing", isTrue),
          isA<ListsState>().having((state) => state.isSyncing, "isSyncing", isFalse)
        ],
        verify: (bloc) {
          verify(refreshAllSongbooksMock.call).called(1);
        },
      );
    });

    group("when creating new songbook", () {
      final insertUserSongbookMock = _InsertUserSongbookMock();
      when(() => insertUserSongbookMock(name: any(named: "name")))
          .thenAnswer((_) => SynchronousFuture(Ok(getFakeSongbook())));

      blocTest(
        "should call use case",
        build: () => getBloc(insertUserSongbookMock: insertUserSongbookMock),
        act: (bloc) => bloc.createNewSongbook("name"),
        verify: (bloc) {
          verify(() => insertUserSongbookMock(name: "name")).called(1);
        },
      );
    });
  });
}
