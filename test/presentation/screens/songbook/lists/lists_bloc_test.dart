import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/list_limit/models/list_limit_constants.dart';
import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit_state.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_list_limit_constants.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbooks.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_user_songbooks.dart';
import 'package:cifraclub/domain/songbook/use_cases/refresh_all_songbooks.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_artist_image_preview.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
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

class _GetListLimitMock extends Mock implements GetListLimit {
  _GetListLimitMock({int listLimit = 10}) {
    when(() => call(any())).thenAnswer((_) => listLimit);
  }
}

class _GetProStatusStreamMock extends Mock implements GetProStatusStream {
  _GetProStatusStreamMock() {
    when(call).thenAnswer((_) => BehaviorSubject.seeded(false));
  }
}

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
  _GetCredentialStreamMock([
    UserCredential credentials = const UserCredential(isUserLoggedIn: false, user: null),
  ]) {
    when(call).thenAnswer((_) => BehaviorSubject.seeded(credentials));
  }
}

class _GetListLimitStateStreamMock extends Mock implements GetListLimitState {
  _GetListLimitStateStreamMock({ListLimitState listState = ListLimitState.withinLimit}) {
    when(call).thenAnswer((_) => BehaviorSubject.seeded(listState));
  }
}

class _GetTotalSongbooksStreamMock extends Mock implements GetTotalSongbooks {
  _GetTotalSongbooksStreamMock({int total = 5}) {
    when(call).thenAnswer((_) => BehaviorSubject.seeded(total));
  }
}

class _ValidateSongbookNameMock extends Mock implements ValidateSongbookName {
  _ValidateSongbookNameMock([SongbookNameValidation songbookNameValidation = SongbookNameValidation.validInput]) {
    when(() => call(any())).thenAnswer((invocation) => SynchronousFuture(songbookNameValidation));
  }
}

class _ValidateArtistImagePreviewMock extends Mock implements ValidateArtistImagePreview {
  _ValidateArtistImagePreviewMock() {
    when(() => call(any())).thenReturn(["https://solr.co/image"]);
  }
}

class _GetListLimitConstantsMock extends Mock implements GetListLimitConstants {
  _GetListLimitConstantsMock() {
    when(call).thenReturn(const ListLimitConstants(
      maxListsForFree: 10,
      maxListsForPro: 1000,
      listWarningCountThreshold: 2,
    ));
  }
}

void main() {
  ListsBloc getBloc({
    _GetListLimitStateStreamMock? getListLimitStateMock,
    _GetTotalSongbooksStreamMock? getTotalSongbooksMock,
    _InsertUserSongbookMock? insertUserSongbookMock,
    _GetListLimitMock? getListLimitMock,
    _LogoutMock? logoutMock,
    _GetCredentialStreamMock? getCredentialStreamMock,
    _OpenLoginPageMock? openLoginPageMock,
    _OpenUserProfileMock? openUserProfileMock,
    _RefreshAllSongbooksMock? refreshAllSongbooksMock,
    _GetAllUserSongbooksMock? getAllUserSongbooksMock,
    _GetProStatusStreamMock? getProStatusStreamMock,
    _ValidateSongbookNameMock? validateSongbookNameMock,
    _ValidateArtistImagePreviewMock? validateArtistImagePreview,
    _GetListLimitConstantsMock? getListLimitConstantsMock,
  }) =>
      ListsBloc(
        getListLimitStateMock ?? _GetListLimitStateStreamMock(),
        getTotalSongbooksMock ?? _GetTotalSongbooksStreamMock(),
        insertUserSongbookMock ?? _InsertUserSongbookMock(),
        getListLimitMock ?? _GetListLimitMock(),
        getCredentialStreamMock ?? _GetCredentialStreamMock(),
        logoutMock ?? _LogoutMock(),
        openLoginPageMock ?? _OpenLoginPageMock(),
        openUserProfileMock ?? _OpenUserProfileMock(),
        refreshAllSongbooksMock ?? _RefreshAllSongbooksMock(Err(ConnectionError())),
        getAllUserSongbooksMock ?? _GetAllUserSongbooksMock([]),
        getProStatusStreamMock ?? _GetProStatusStreamMock(),
        validateSongbookNameMock ?? _ValidateSongbookNameMock(),
        validateArtistImagePreview ?? _ValidateArtistImagePreviewMock(),
        getListLimitConstantsMock ?? _GetListLimitConstantsMock(),
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
        build: () => getBloc(
          getAllUserSongbooksMock: _GetAllUserSongbooksMock(songbooks),
        ),
        act: (bloc) => bloc.init(),
        verify: (bloc) {
          expect(bloc.state.userLists.length, 1);
          expect(bloc.state.specialLists.length, ListType.values.length - 1);
        },
      );
    });

    group("with logged in user", () {
      final user = getFakeUser();
      final credentialStream = _GetCredentialStreamMock(UserCredential(isUserLoggedIn: true, user: user));
      blocTest(
        "should update user state to not null",
        build: () => getBloc(
          getCredentialStreamMock: credentialStream,
        ),
        act: (bloc) => bloc.init(),
        verify: (bloc) => expect(bloc.state.user, user),
      );
    });

    group("with logged out user", () {
      final credentialStream = _GetCredentialStreamMock();
      blocTest(
        "should update user state to null",
        build: () => getBloc(
          getCredentialStreamMock: credentialStream,
        ),
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
      registerFallbackValue(InsertUserSongbookWithName(name: "name"));

      final insertUserSongbookMock = _InsertUserSongbookMock();
      when(() => insertUserSongbookMock(params: any(named: "params")))
          .thenAnswer((_) => SynchronousFuture(Ok(getFakeSongbook())));

      blocTest(
        "should call use case",
        build: () => getBloc(insertUserSongbookMock: insertUserSongbookMock),
        act: (bloc) => bloc.createNewSongbook("name"),
        verify: (bloc) {
          verify(() => insertUserSongbookMock(params: any(named: "params"))).called(1);
        },
      );
    });
  });

  group("When initListLimitStreams is called", () {
    final getTotalSongbooks = _GetTotalSongbooksStreamMock(total: 8);
    final getListLimitState = _GetListLimitStateStreamMock(listState: ListLimitState.atWarning);

    blocTest(
      "should update listLimit and listCount state",
      build: () => getBloc(getListLimitStateMock: getListLimitState, getTotalSongbooksMock: getTotalSongbooks),
      act: (bloc) => bloc.initListLimitStreams(),
      expect: () => [
        isA<ListsState>().having((state) => state.listState, "List State", ListLimitState.atWarning),
        isA<ListsState>().having((state) => state.listCount, "List Count", 8)
      ],
    );
  });

  test("When `isValidSongbookName` is called and songbook name is valid should return true", () async {
    final validateSongbookNameMock = _ValidateSongbookNameMock(SongbookNameValidation.validInput);

    final bloc = getBloc(validateSongbookNameMock: validateSongbookNameMock);
    final result = await bloc.isValidSongbookName("teste");

    expect(result, true);
  });

  test("When `isValidSongbookName` is called and songbook name is repeated should return false", () async {
    final validateSongbookNameMock = _ValidateSongbookNameMock(SongbookNameValidation.existingName);

    final bloc = getBloc(validateSongbookNameMock: validateSongbookNameMock);
    final result = await bloc.isValidSongbookName("teste");

    expect(result, false);
  });

  test("When `validatePreview` is called return the image url list", () async {
    final bloc = getBloc();
    final result = bloc.validatePreview(["image"]);

    expect(result, ["https://solr.co/image"]);
  });

  test("When `setShouldShowLimitToast` is called should update state with bew value", () async {
    final bloc = getBloc();
    bloc.setShouldShowLimitToast(true);

    expect(bloc.state.shouldShowLimitToast, true);
  });
}
