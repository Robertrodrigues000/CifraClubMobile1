import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/list_limit/models/list_limit_constants.dart';
import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_list_limit_constants.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/models/songbook_error.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_user_songbooks.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_to_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_artist_image_preview.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:cifraclub/presentation/bottom_sheets/save_version_to_list_bottom_sheet/save_version_to_list_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/bottom_sheets/save_version_to_list_bottom_sheet/save_version_to_list_result.dart';
import 'package:cifraclub/presentation/bottom_sheets/save_version_to_list_bottom_sheet/save_version_to_list_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_mock.dart';
import '../../../shared_mocks/domain/songbook/models/songbook_version_input_mock.dart';
import '../../../shared_mocks/domain/version/models/version_data_mock.dart';

class _GetAllUserSongbooksMock extends Mock implements GetAllUserSongbooks {
  _GetAllUserSongbooksMock(List<Songbook> songbooks) {
    when(call).thenAnswer((_) => BehaviorSubject.seeded(songbooks));
  }
}

class _InsertUserSongbookMock extends Mock implements InsertUserSongbook {}

class _GetListLimitStateStreamMock extends Mock implements GetListLimitState {
  _GetListLimitStateStreamMock({ListLimitState listState = ListLimitState.withinLimit}) {
    when(call).thenAnswer((_) => BehaviorSubject.seeded(listState));
  }
}

class _GetVersionsLimitStateMock extends Mock implements GetVersionsLimitState {
  _GetVersionsLimitStateMock({ListLimitState listState = ListLimitState.withinLimit}) {
    when(() => call(any())).thenAnswer((_) => BehaviorSubject.seeded(listState));
  }
}

class _InsertVersionToSongbookMock extends Mock implements InsertVersionToSongbook {}

class _GetListLimitMock extends Mock implements GetListLimit {}

class _GetVersionsLimitMock extends Mock implements GetVersionsLimit {}

class _ValidateArtistImagePreviewMock extends Mock implements ValidateArtistImagePreview {
  _ValidateArtistImagePreviewMock() {
    when(() => call(any())).thenReturn(["https://solr.co/image"]);
  }
}

class _GetProStatusStreamMock extends Mock implements GetProStatusStream {
  _GetProStatusStreamMock() {
    when(call).thenAnswer((_) => BehaviorSubject.seeded(false));
  }
}

class _ValidateSongbookNameMock extends Mock implements ValidateSongbookName {
  _ValidateSongbookNameMock([SongbookNameValidation songbookNameValidation = SongbookNameValidation.validInput]) {
    when(() => call(any())).thenAnswer((invocation) => SynchronousFuture(songbookNameValidation));
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
  SaveVersionToListBottomSheetBloc getBloc({
    _GetAllUserSongbooksMock? getAllUserSongbooksMock,
    _InsertUserSongbookMock? insertUserSongbookMock,
    _GetListLimitStateStreamMock? getListLimitStateMock,
    _GetVersionsLimitStateMock? getVersionsLimitStateMock,
    _InsertVersionToSongbookMock? insertVersionToSongbookMock,
    _GetListLimitMock? getListLimitMock,
    _GetVersionsLimitMock? getVersionsLimitMock,
    _GetProStatusStreamMock? getProStatusStreamMock,
    _ValidateSongbookNameMock? validateSongbookNameMock,
    _ValidateArtistImagePreviewMock? validateArtistImagePreviewMock,
    _GetListLimitConstantsMock? getListLimitConstants,
    VersionData? versionData,
  }) =>
      SaveVersionToListBottomSheetBloc(
        getAllUserSongbooksMock ?? _GetAllUserSongbooksMock([]),
        insertUserSongbookMock ?? _InsertUserSongbookMock(),
        getListLimitStateMock ?? _GetListLimitStateStreamMock(),
        getVersionsLimitStateMock ?? _GetVersionsLimitStateMock(),
        insertVersionToSongbookMock ?? _InsertVersionToSongbookMock(),
        validateSongbookNameMock ?? _ValidateSongbookNameMock(),
        getListLimitMock ?? _GetListLimitMock(),
        getVersionsLimitMock ?? _GetVersionsLimitMock(),
        getProStatusStreamMock ?? _GetProStatusStreamMock(),
        validateArtistImagePreviewMock ?? _ValidateArtistImagePreviewMock(),
        getListLimitConstants ?? _GetListLimitConstantsMock(),
        "artistUrl",
        "songUrl",
        versionData,
      );

  group("When init is called", () {
    registerFallbackValue(getFakeSongbook());
    registerFallbackValue(getFakeSongbookVersionInput());
    final songbooks = [
      getFakeSongbook(),
      getFakeSongbook(),
      getFakeSongbook(),
      getFakeSongbook(listType: ListType.cantPlay)
    ];
    final getAllUserSongbooks = _GetAllUserSongbooksMock(songbooks);
    final getListLimitState = _GetListLimitStateStreamMock(listState: ListLimitState.withinLimit);
    blocTest(
      "should update state with info from use cases",
      build: () => getBloc(
        getAllUserSongbooksMock: getAllUserSongbooks,
        getListLimitStateMock: getListLimitState,
      ),
      act: (bloc) => bloc.init(),
      expect: () => [
        isA<SaveVersionToListState>()
            .having((state) => state.userLists.length, "user lists", 3)
            .having((state) => state.specialLists.length, "special lists", 1)
            .having((state) => state.isPro, "is pro", false)
      ],
    );
  });

  test("When `createNewSongbook` is called should call use case", () async {
    registerFallbackValue(InsertUserSongbookWithName(name: "name"));

    final insertUserSongbook = _InsertUserSongbookMock();
    final getListLimitState = _GetListLimitStateStreamMock(listState: ListLimitState.withinLimit);

    when(() => insertUserSongbook(params: captureAny(named: "params")))
        .thenAnswer((_) => SynchronousFuture(Ok(getFakeSongbook())));

    final bloc = getBloc(
      insertUserSongbookMock: insertUserSongbook,
      getListLimitStateMock: getListLimitState,
    );

    await bloc.createNewSongbook("testando");

    final params = verify(() => insertUserSongbook.call(params: captureAny(named: "params"))).captured.first
        as InsertUserSongbookWithUrl;

    expect(params.artistUrl, "artistUrl");
    expect(params.songUrl, "songUrl");
    expect(params.name, "testando");
    verify(getListLimitState.call).called(2);
  });

  test("When `createNewSongbook` and have version data is called should call use case", () async {
    registerFallbackValue(InsertUserSongbookWithName(name: "name"));
    final versionData = getFakeVersionData();

    final insertUserSongbook = _InsertUserSongbookMock();
    final getListLimitState = _GetListLimitStateStreamMock(listState: ListLimitState.withinLimit);

    when(() => insertUserSongbook(params: captureAny(named: "params")))
        .thenAnswer((_) => SynchronousFuture(Ok(getFakeSongbook())));

    final bloc = getBloc(
      insertUserSongbookMock: insertUserSongbook,
      getListLimitStateMock: getListLimitState,
      versionData: versionData,
    );

    await bloc.createNewSongbook("testando");

    final params = verify(() => insertUserSongbook.call(params: captureAny(named: "params"))).captured.first
        as InsertUserSongbookWithVersionData;

    expect(params.versionData, versionData);
    expect(params.name, "testando");
    verify(getListLimitState.call).called(2);
  });

  test("When `createNewSongbook` is called and request error should return error result", () async {
    registerFallbackValue(InsertUserSongbookWithName(name: "name"));

    final insertUserSongbook = _InsertUserSongbookMock();
    final getListLimitState = _GetListLimitStateStreamMock(listState: ListLimitState.withinLimit);

    when(() => insertUserSongbook(params: captureAny(named: "params")))
        .thenAnswer((_) => SynchronousFuture(Err(ConnectionError())));

    final bloc = getBloc(
      insertUserSongbookMock: insertUserSongbook,
      getListLimitStateMock: getListLimitState,
    );

    final result = await bloc.createNewSongbook("testando");

    verify(() => insertUserSongbook.call(params: captureAny(named: "params"))).called(1);
    verify(getListLimitState.call).called(1);
    expect(result, isA<SaveToListError>());
  });

  test("When `createNewSongbook` is called and ListLimit is reached, should return error result", () async {
    registerFallbackValue(InsertUserSongbookWithName(name: "name"));

    final insertUserSongbook = _InsertUserSongbookMock();
    final insertVersionToSongbook = _InsertVersionToSongbookMock();
    final getListLimitState = _GetListLimitStateStreamMock(listState: ListLimitState.reached);
    final getListLimit = _GetListLimitMock();

    when(() => getListLimit.call(any())).thenAnswer((_) => 10);

    when(() => insertUserSongbook(params: any(named: "params")))
        .thenAnswer((_) => SynchronousFuture(Ok(getFakeSongbook())));

    when(() => insertVersionToSongbook(
          songbookId: any(named: "songbookId"),
          artistUrl: any(named: "artistUrl"),
          songUrl: any(named: "songUrl"),
          isPro: any(named: "isPro"),
        )).thenAnswer((_) => SynchronousFuture(const Ok(1)));

    final bloc = getBloc(
        insertUserSongbookMock: insertUserSongbook,
        getListLimitStateMock: getListLimitState,
        insertVersionToSongbookMock: insertVersionToSongbook,
        getListLimitMock: getListLimit);
    final result = await bloc.createNewSongbook("testando");

    verify(getListLimitState.call).called(1);
    expect(result, isA<ListLimitStateReached>());
  });

  test("When `createNewSongbook` is called and fails, should return error result", () async {
    final insertUserSongbook = _InsertUserSongbookMock();
    final getListLimitState = _GetListLimitStateStreamMock(listState: ListLimitState.withinLimit);
    final getListLimit = _GetListLimitMock();
    final insertVersionToSongbook = _InsertVersionToSongbookMock();
    when(() => getListLimit.call(any())).thenAnswer((_) => 10);
    when(() => insertUserSongbook(params: any(named: "params")))
        .thenAnswer((_) => SynchronousFuture(Err(ServerError())));

    final bloc = getBloc(
        insertUserSongbookMock: insertUserSongbook,
        getListLimitStateMock: getListLimitState,
        getListLimitMock: getListLimit);
    final result = await bloc.createNewSongbook("testando");

    verify(getListLimitState.call).called(1);
    verifyNever(() => insertVersionToSongbook.call(
        songbookId: any(named: "songbookId"),
        artistUrl: any(named: "artistUrl"),
        songUrl: any(named: "songUrl"),
        isPro: any(named: "isPro")));
    expect(result, isA<SaveToListError>());
  });

  test("When `addSongToSongbook` is called, should call use case", () async {
    final insertVersionToSongbook = _InsertVersionToSongbookMock();

    when(() => insertVersionToSongbook(
        songbookId: any(named: "songbookId"),
        artistUrl: any(named: "artistUrl"),
        songUrl: any(named: "songUrl"),
        isPro: any(named: "isPro"))).thenAnswer((_) => SynchronousFuture(const Ok(1)));

    final bloc = getBloc(insertVersionToSongbookMock: insertVersionToSongbook);
    await bloc.addSongToSongbook(songbookId: 1, name: "Testando");

    verify(() => insertVersionToSongbook.call(
        songbookId: any(named: "songbookId"),
        artistUrl: any(named: "artistUrl"),
        songUrl: any(named: "songUrl"),
        isPro: any(named: "isPro"))).called(1);
  });

  test("When `addSongToSongbook` is called and versions limit state is reached, should return correct result",
      () async {
    final insertVersionToSongbook = _InsertVersionToSongbookMock();
    final getVersionsLimit = _GetVersionsLimitMock();

    when(() => insertVersionToSongbook(
        songbookId: any(named: "songbookId"),
        artistUrl: any(named: "artistUrl"),
        songUrl: any(named: "songUrl"),
        isPro: any(named: "isPro"))).thenAnswer((_) => SynchronousFuture(Err(SongbookVersionsLimitReachedError(100))));

    when(() => getVersionsLimit(any())).thenAnswer((_) => 100);

    final bloc = getBloc(insertVersionToSongbookMock: insertVersionToSongbook, getVersionsLimitMock: getVersionsLimit);

    final result = await bloc.addSongToSongbook(songbookId: 1, name: "Testando");

    expect(result, isA<VersionListLimitStateReached>());
  });

  test("When `addSongToSongbook` is called and versions limit state is atWarning, should return correct result",
      () async {
    final insertVersionToSongbook = _InsertVersionToSongbookMock();
    final getVersionsLimitState = _GetVersionsLimitStateMock(listState: ListLimitState.atWarning);
    final getVersionsLimit = _GetVersionsLimitMock();

    when(() => insertVersionToSongbook(
        songbookId: any(named: "songbookId"),
        artistUrl: any(named: "artistUrl"),
        songUrl: any(named: "songUrl"),
        isPro: any(named: "isPro"))).thenAnswer((_) => SynchronousFuture(const Ok(1)));

    when(() => getVersionsLimit(any())).thenAnswer((_) => 100);

    final bloc = getBloc(
        getVersionsLimitStateMock: getVersionsLimitState,
        insertVersionToSongbookMock: insertVersionToSongbook,
        getVersionsLimitMock: getVersionsLimit);

    final result = await bloc.addSongToSongbook(
      songbookId: 1,
      name: "Testando",
    );

    verify(() => getVersionsLimitState.call(any())).called(1);
    expect(
        result,
        isA<SaveVersionToListCompleted>()
            .having((result) => result.showListsLimitWarning, "shouldShowLimitToast", true)
            .having((result) => result.limitWarning?.limit, "limit", 10)
            .having((result) => result.limitWarning?.proLimit, "proLimit", 1000));
  });

  test("When `addSongToSongbook` is called and songbookId is null, should return error result", () async {
    final insertVersionToSongbook = _InsertVersionToSongbookMock();
    final getVersionsLimit = _GetVersionsLimitMock();

    when(() => insertVersionToSongbook(
        songbookId: any(named: "songbookId"),
        artistUrl: any(named: "artistUrl"),
        songUrl: any(named: "songUrl"),
        isPro: any(named: "isPro"))).thenAnswer((_) => SynchronousFuture(Err(SongbookRepeatedSongError())));

    when(() => getVersionsLimit(any())).thenAnswer((_) => 100);

    final bloc = getBloc(insertVersionToSongbookMock: insertVersionToSongbook, getVersionsLimitMock: getVersionsLimit);

    final result = await bloc.addSongToSongbook(songbookId: 1, name: "Testando");
    expect(result, isA<VersionIsAlreadyOnListError>());
  });

  test("When `addSongToSongbook` is called and songbookId is null, should return error result", () async {
    final bloc = getBloc();

    final result = await bloc.addSongToSongbook(songbookId: null, name: "Testando");

    expect(result, isA<SaveToListError>());
  });

  test("When `addSongToSongbook` is called and request error occurs should return error result", () async {
    final insertVersionToSongbook = _InsertVersionToSongbookMock();
    final getVersionsLimitState = _GetVersionsLimitStateMock(listState: ListLimitState.withinLimit);

    when(() => insertVersionToSongbook(
            songbookId: any(named: "songbookId"),
            artistUrl: any(named: "artistUrl"),
            songUrl: any(named: "songUrl"),
            isPro: any(named: "isPro")))
        .thenAnswer((_) => SynchronousFuture(Err(SongbookRequestError(ServerError(statusCode: 404)))));

    final bloc =
        getBloc(getVersionsLimitStateMock: getVersionsLimitState, insertVersionToSongbookMock: insertVersionToSongbook);
    final result = await bloc.addSongToSongbook(songbookId: 1, name: "Testando");

    verify(() => insertVersionToSongbook.call(
        songbookId: any(named: "songbookId"),
        artistUrl: any(named: "artistUrl"),
        songUrl: any(named: "songUrl"),
        isPro: any(named: "isPro"))).called(1);
    expect(result, isA<SaveToListError>());
  });

  test("When `isValidSongbookName` is called and songbook name is repeated should return false", () async {
    final validateSongbookNameMock = _ValidateSongbookNameMock(SongbookNameValidation.existingName);

    final bloc = getBloc(validateSongbookNameMock: validateSongbookNameMock);
    final result = await bloc.isValidSongbookName("teste");

    expect(result, false);
  });
  test("When `isValidSongbookName` is called and songbook name is repeated should return false", () async {
    final validateSongbookNameMock = _ValidateSongbookNameMock(SongbookNameValidation.validInput);

    final bloc = getBloc(validateSongbookNameMock: validateSongbookNameMock);
    final result = await bloc.isValidSongbookName("teste");

    expect(result, true);
  });

  test("When `getListLimit` is called and should return use case value", () async {
    final getListLimit = _GetListLimitMock();
    when(() => getListLimit.call(any())).thenAnswer((_) => 10);
    final bloc = getBloc(getListLimitMock: getListLimit);
    final listLimit = bloc.getListLimit();

    expect(listLimit, 10);
  });

  test("When `getListLimit` is called and should return use case value", () async {
    final getVersionsLimit = _GetVersionsLimitMock();
    when(() => getVersionsLimit.call(any())).thenAnswer((_) => 100);
    final bloc = getBloc(getVersionsLimitMock: getVersionsLimit);
    final versionsLimit = bloc.getVersionsLimit();

    expect(versionsLimit, 100);
  });

  test("When `validatePreview` is called return the image url list", () async {
    final bloc = getBloc();
    final result = bloc.validatePreview(["image"]);

    expect(result, ["https://solr.co/image"]);
  });
}
