import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook_error.dart';
import 'package:cifraclub/domain/songbook/use_cases/is_version_on_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_data_to_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_to_songbook.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:cifraclub/domain/version/use_cases/get_version_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_version_input_mock.dart';
import '../../../shared_mocks/domain/version/models/version_data_mock.dart';
import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _InsertVersionDataToSongbookMock extends Mock implements InsertVersionDataToSongbook {}

class _GetVersionDataMock extends Mock implements GetVersionData {}

class _GetIsVersionOnListMock extends Mock implements IsVersionOnSongbook {}

class _GetVersionsLimitStateMock extends Mock implements GetVersionsLimitState {}

class _GetVersionsLimitMock extends Mock implements GetVersionsLimit {}

void main() {
  final insertVersionDataToSongbook = _InsertVersionDataToSongbookMock();
  final getVersionData = _GetVersionDataMock();
  final getIsVersionOnList = _GetIsVersionOnListMock();
  final getVersionsLimitState = _GetVersionsLimitStateMock();
  final getVersionsLimit = _GetVersionsLimitMock();

  setUpAll(() {
    registerFallbackValue(ListType.canPlay);
  });

  group("When all requests is successful", () {
    registerFallbackValue(getFakeVersionData());
    final versionData = getFakeVersionData();
    final version = getFakeVersion();

    when(() => getVersionsLimitState(any())).thenAnswer((_) => BehaviorSubject.seeded(ListLimitState.withinLimit));

    when(() => insertVersionDataToSongbook(
          versionData: any(named: "versionData"),
          songbookId: any(named: "songbookId"),
        )).thenAnswer((invocation) => SynchronousFuture(
          Ok((invocation.namedArguments[const Symbol("versionData")]! as VersionData).song.songId),
        ));

    when(() => getVersionData(
          artistUrl: any(named: "artistUrl"),
          songUrl: any(named: "songUrl"),
        )).thenAnswer((_) => Future.value(Ok(versionData)));

    when(() => getIsVersionOnList(any(), any())).thenAnswer((_) => SynchronousFuture(false));

    test("should return success", () async {
      final result = await InsertVersionToSongbook(
        getVersionData,
        insertVersionDataToSongbook,
        getIsVersionOnList,
        getVersionsLimitState,
        getVersionsLimit,
      )(
        artistUrl: version.artist.url,
        songUrl: version.songUrl,
        songbookId: 10,
      );

      verify(() => getVersionsLimitState(any())).called(1);

      verify(() => getVersionData(
            artistUrl: version.artist.url,
            songUrl: version.songUrl,
          )).called(1);
      expect(result.get(), versionData.song.songId);
    });
  });

  test("When call use case and version limit state is reached, should return SongbookVersionsLimitReachedError",
      () async {
    when(() => getVersionsLimitState(any())).thenAnswer((_) => BehaviorSubject.seeded(ListLimitState.reached));
    when(() => getVersionsLimit(any())).thenReturn(100);

    final result = await InsertVersionToSongbook(
      getVersionData,
      insertVersionDataToSongbook,
      getIsVersionOnList,
      getVersionsLimitState,
      getVersionsLimit,
    )(
      artistUrl: "",
      songUrl: "",
      songbookId: 34,
      isPro: false,
    );

    verify(() => getVersionsLimitState(34)).called(1);
    verify(() => getVersionsLimit(false)).called(1);
    expect(result.isFailure, isTrue);
    expect(result.getError(), isA<SongbookVersionsLimitReachedError>());
  });

  test("When call use case and version is favorite already, should return SongbookRepeatedSongError", () async {
    final versionData = getFakeVersionData();

    when(() => getVersionData(
          artistUrl: any(named: "artistUrl"),
          songUrl: any(named: "songUrl"),
        )).thenAnswer((_) => SynchronousFuture(Ok(versionData)));
    when(() => getIsVersionOnList(any(), any())).thenAnswer((_) => SynchronousFuture(true));

    final result = await InsertVersionToSongbook(
      getVersionData,
      insertVersionDataToSongbook,
      getIsVersionOnList,
      getVersionsLimitState,
      getVersionsLimit,
    )(
      artistUrl: versionData.artist!.url,
      songUrl: versionData.song.url,
      songbookId: ListType.favorites.localId,
      isPro: false,
    );

    verify(() => getIsVersionOnList(versionData.versionId, ListType.favorites.localId)).called(1);
    expect(result.isFailure, isTrue);
    expect(result.getError(), isA<SongbookRepeatedSongError>());
  });

  test("When call use case and getVersionData fails should return SongbookRequestError", () async {
    final versionInput = getFakeSongbookVersionInput();

    when(() => getVersionData(
          artistUrl: any(named: "artistUrl"),
          songUrl: any(named: "songUrl"),
        )).thenAnswer((_) => SynchronousFuture(Err(ServerError())));

    final result = await InsertVersionToSongbook(
      getVersionData,
      insertVersionDataToSongbook,
      getIsVersionOnList,
      getVersionsLimitState,
      getVersionsLimit,
    )(
      artistUrl: versionInput.artistUrl!,
      songUrl: versionInput.songUrl!,
      songbookId: ListType.cantPlay.localId,
      isPro: false,
    );

    verify(() => getVersionData(
          artistUrl: versionInput.artistUrl!,
          songUrl: versionInput.songUrl!,
        )).called(1);
    expect(result.isFailure, isTrue);
    expect(result.getError(), isA<SongbookRequestError>());
  });

  test("When call use case and request fails should return SongbookRequestError", () async {
    final versionInput = getFakeSongbookVersionInput();
    final versionData = getFakeVersionData();

    when(() => getVersionsLimitState(any())).thenAnswer((_) => BehaviorSubject.seeded(ListLimitState.withinLimit));

    when(() => getVersionData(
          artistUrl: any(named: "artistUrl"),
          songUrl: any(named: "songUrl"),
        )).thenAnswer((_) => Future.value(Ok(versionData)));

    when(() => getIsVersionOnList(any(), any())).thenAnswer((_) => SynchronousFuture(false));

    when(() => insertVersionDataToSongbook(
          versionData: any(named: "versionData"),
          songbookId: any(named: "songbookId"),
        )).thenAnswer((invocation) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    final result = await InsertVersionToSongbook(
      getVersionData,
      insertVersionDataToSongbook,
      getIsVersionOnList,
      getVersionsLimitState,
      getVersionsLimit,
    )(
      artistUrl: versionInput.artistUrl!,
      songUrl: versionInput.songUrl!,
      songbookId: 10,
      isPro: false,
    );

    verify(() => getVersionData(
          artistUrl: versionInput.artistUrl!,
          songUrl: versionInput.songUrl!,
        )).called(1);
    expect(result.isFailure, isTrue);
    expect(result.getError(), isA<SongbookRequestError>());
  });
}
