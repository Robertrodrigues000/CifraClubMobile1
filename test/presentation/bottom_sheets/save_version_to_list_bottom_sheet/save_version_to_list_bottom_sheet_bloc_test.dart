import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_user_songbooks.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_to_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_artist_image_preview.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
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
        "",
        "",
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
    final insertUserSongbook = _InsertUserSongbookMock();
    final insertVersionToSongbook = _InsertVersionToSongbookMock();
    final getListLimitState = _GetListLimitStateStreamMock(listState: ListLimitState.withinLimit);

    when(() => insertUserSongbook(name: any(named: "name")))
        .thenAnswer((_) => SynchronousFuture(Ok(getFakeSongbook())));

    when(() => insertVersionToSongbook(
        songbookId: any(named: "songbookId"),
        artistUrl: any(named: "artistUrl"),
        songUrl: any(named: "songUrl"))).thenAnswer((_) => SynchronousFuture(const Ok(1)));

    final bloc = getBloc(
        insertUserSongbookMock: insertUserSongbook,
        getListLimitStateMock: getListLimitState,
        insertVersionToSongbookMock: insertVersionToSongbook);
    await bloc.createNewSongbook("testando");

    verify(() => insertUserSongbook.call(name: any(named: "name"))).called(1);
    verify(() => insertVersionToSongbook.call(
        songbookId: any(named: "songbookId"),
        artistUrl: any(named: "artistUrl"),
        songUrl: any(named: "songUrl"))).called(1);
    verify(getListLimitState.call).called(2);
  });

  test("When `createNewSongbook` is called and ListLimit is reached, should return error result", () async {
    final insertUserSongbook = _InsertUserSongbookMock();
    final insertVersionToSongbook = _InsertVersionToSongbookMock();
    final getListLimitState = _GetListLimitStateStreamMock(listState: ListLimitState.reached);

    when(() => insertUserSongbook(name: any(named: "name")))
        .thenAnswer((_) => SynchronousFuture(Ok(getFakeSongbook())));

    when(() => insertVersionToSongbook(
          songbookId: any(named: "songbookId"),
          artistUrl: any(named: "artistUrl"),
          songUrl: any(named: "songUrl"),
        )).thenAnswer((_) => SynchronousFuture(const Ok(1)));

    final bloc = getBloc(
        insertUserSongbookMock: insertUserSongbook,
        getListLimitStateMock: getListLimitState,
        insertVersionToSongbookMock: insertVersionToSongbook);
    final result = await bloc.createNewSongbook("testando");

    verify(getListLimitState.call).called(1);
    expect(result, isA<SaveToListError>());
  });

  test("When `addSongToSongbook` is called, should call use case", () async {
    final insertVersionToSongbook = _InsertVersionToSongbookMock();
    final getVersionsLimitState = _GetVersionsLimitStateMock(listState: ListLimitState.withinLimit);

    when(() => insertVersionToSongbook(
        songbookId: any(named: "songbookId"),
        artistUrl: any(named: "artistUrl"),
        songUrl: any(named: "songUrl"))).thenAnswer((_) => SynchronousFuture(const Ok(1)));

    final bloc =
        getBloc(getVersionsLimitStateMock: getVersionsLimitState, insertVersionToSongbookMock: insertVersionToSongbook);
    await bloc.addSongToSongbook(songbookId: 1, name: "Testando");

    verify(() => insertVersionToSongbook.call(
        songbookId: any(named: "songbookId"),
        artistUrl: any(named: "artistUrl"),
        songUrl: any(named: "songUrl"))).called(1);
    verify(() => getVersionsLimitState.call(any())).called(2);
  });

  test("When `addSongToSongbook` is called and versions limit state is reached, should return correct result",
      () async {
    final insertVersionToSongbook = _InsertVersionToSongbookMock();
    final getVersionsLimitState = _GetVersionsLimitStateMock(listState: ListLimitState.reached);
    final getVersionsLimit = _GetVersionsLimitMock();

    when(() => insertVersionToSongbook(
        songbookId: any(named: "songbookId"),
        artistUrl: any(named: "artistUrl"),
        songUrl: any(named: "songUrl"))).thenAnswer((_) => SynchronousFuture(const Ok(1)));

    when(() => getVersionsLimit(any())).thenAnswer((_) => 100);

    final bloc = getBloc(
        getVersionsLimitStateMock: getVersionsLimitState,
        insertVersionToSongbookMock: insertVersionToSongbook,
        getVersionsLimitMock: getVersionsLimit);

    final result = await bloc.addSongToSongbook(songbookId: 1, name: "Testando");

    verify(() => getVersionsLimitState.call(any())).called(1);
    expect(result, isA<VersionListLimitStateReached>());
  });

  test("When `addSongToSongbook` is called and songbookId is null, should return error result", () async {
    final insertVersionToSongbook = _InsertVersionToSongbookMock();
    final getVersionsLimitState = _GetVersionsLimitStateMock(listState: ListLimitState.reached);
    final getVersionsLimit = _GetVersionsLimitMock();

    when(() => insertVersionToSongbook(
        songbookId: any(named: "songbookId"),
        artistUrl: any(named: "artistUrl"),
        songUrl: any(named: "songUrl"))).thenAnswer((_) => SynchronousFuture(const Ok(1)));

    when(() => getVersionsLimit(any())).thenAnswer((_) => 100);

    final bloc = getBloc(
        getVersionsLimitStateMock: getVersionsLimitState,
        insertVersionToSongbookMock: insertVersionToSongbook,
        getVersionsLimitMock: getVersionsLimit);

    final result = await bloc.addSongToSongbook(songbookId: null, name: "Testando");

    expect(result, isA<SaveToListError>());
  });

  test("When `addSongToSongbook` is called and request error occurs should return error result", () async {
    final insertVersionToSongbook = _InsertVersionToSongbookMock();
    final getVersionsLimitState = _GetVersionsLimitStateMock(listState: ListLimitState.withinLimit);

    when(() => insertVersionToSongbook(
        songbookId: any(named: "songbookId"),
        artistUrl: any(named: "artistUrl"),
        songUrl: any(named: "songUrl"))).thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    final bloc =
        getBloc(getVersionsLimitStateMock: getVersionsLimitState, insertVersionToSongbookMock: insertVersionToSongbook);
    final result = await bloc.addSongToSongbook(songbookId: 1, name: "Testando");

    verify(() => insertVersionToSongbook.call(
        songbookId: any(named: "songbookId"),
        artistUrl: any(named: "artistUrl"),
        songUrl: any(named: "songUrl"))).called(1);
    verify(() => getVersionsLimitState.call(any())).called(1);
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
