import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state.dart';
import 'package:cifraclub/domain/preferences/use_cases/get_list_order_type_preference.dart';
import 'package:cifraclub/domain/preferences/use_cases/set_list_order_type_preference.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_versions.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_versions_stream_by_songbook_id.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_songbook_stream_by_id.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:cifraclub/domain/version/use_cases/get_ordered_versions.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_state.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/list_order_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_plus/share_plus.dart';
import 'package:typed_result/typed_result.dart';

import '../../../../shared_mocks/domain/songbook/models/songbook_mock.dart';
import '../../../../shared_mocks/domain/version/models/version_mock.dart';

class _GetSongbookStreamByIdMock extends Mock implements GetSongbookStreamById {}

class _ShareLinkMock extends Mock implements ShareLink {}

class _GetVersionsStreamBySongbookIdMock extends Mock implements GetVersionsStreamBySongbookId {}

class _GetVersionsLimitStateMock extends Mock implements GetVersionsLimitState {}

class _GetProStatusStreamMock extends Mock implements GetProStatusStream {}

class _GetVersionsLimitMock extends Mock implements GetVersionsLimit {}

class _GetOrderFilterPreferencesMock extends Mock implements GetListOrderTypePreferences {}

class _SetOrderFilterPreferencesMock extends Mock implements SetListOrderTypePreferences {}

class _GetOrderedVersionsMock extends Mock implements GetOrderedVersions {}

class _DeleteVersions extends Mock implements DeleteVersions {}

void main() {
  VersionsBloc getBloc({
    _GetSongbookStreamByIdMock? getSongbookStreamByIdMock,
    _ShareLinkMock? shareLinkMock,
    _GetVersionsStreamBySongbookIdMock? getVersionsStreamBySongbookIdMock,
    _GetVersionsLimitStateMock? getTabsLimitStateMock,
    _GetProStatusStreamMock? getProStatusStreamMock,
    _GetVersionsLimitMock? getTabsLimitMock,
    _GetOrderFilterPreferencesMock? getOrderFilterPreferences,
    _SetOrderFilterPreferencesMock? setOrderFilterPreferences,
    _GetOrderedVersionsMock? getOrderedVersions,
    _DeleteVersions? deleteVersions,
  }) =>
      VersionsBloc(
        getSongbookStreamByIdMock ?? _GetSongbookStreamByIdMock(),
        shareLinkMock ?? _ShareLinkMock(),
        getVersionsStreamBySongbookIdMock ?? _GetVersionsStreamBySongbookIdMock(),
        getTabsLimitStateMock ?? _GetVersionsLimitStateMock(),
        getProStatusStreamMock ?? _GetProStatusStreamMock(),
        getTabsLimitMock ?? _GetVersionsLimitMock(),
        getOrderFilterPreferences ?? _GetOrderFilterPreferencesMock(),
        setOrderFilterPreferences ?? _SetOrderFilterPreferencesMock(),
        getOrderedVersions ?? _GetOrderedVersionsMock(),
        deleteVersions ?? _DeleteVersions(),
      );

  setUpAll(() {
    registerFallbackValue(ListOrderType.alphabeticOrder);
    registerFallbackValue(ListType.user);
  });

  group("When call 'init'", () {
    final songbook = getFakeSongbook();
    final versions = [getFakeVersion(), getFakeVersion()];

    final getSongbookStreamById = _GetSongbookStreamByIdMock();
    // ignore: close_sinks
    final songbookBehaviorSubject = BehaviorSubject.seeded(songbook);
    when(() => getSongbookStreamById(songbook.id)).thenAnswer((_) => songbookBehaviorSubject);
    when(() => getSongbookStreamById(null)).thenAnswer((_) => BehaviorSubject.seeded(null));

    final getProStatus = _GetProStatusStreamMock();
    when(getProStatus).thenAnswer((_) => BehaviorSubject.seeded(true));

    final getVersionsStream = _GetVersionsStreamBySongbookIdMock();
    // ignore: close_sinks
    final versionsBehaviorSubject = BehaviorSubject.seeded(versions);
    when(() => getVersionsStream(songbook.id!)).thenAnswer((_) => versionsBehaviorSubject);

    final getTabsLimitState = _GetVersionsLimitStateMock();
    when(() => getTabsLimitState(any())).thenAnswer((_) => BehaviorSubject.seeded(ListLimitState.withinLimit));

    final getTabsLimit = _GetVersionsLimitMock();
    when(() => getTabsLimit(true)).thenReturn(1000);

    final getOrderFilterPreferences = _GetOrderFilterPreferencesMock();
    when(getOrderFilterPreferences).thenReturn(ListOrderType.custom.key);

    registerFallbackValue(ListOrderType.alphabeticOrder);
    registerFallbackValue(ListType.user);
    final getOrderedVersions = _GetOrderedVersionsMock();
    when(() => getOrderedVersions(any(), any(), any())).thenReturn(versions);

    group("and songbook id is not null", () {
      blocTest(
        "should emit correctly states",
        build: () => getBloc(
          getSongbookStreamByIdMock: getSongbookStreamById,
          getProStatusStreamMock: getProStatus,
          getVersionsStreamBySongbookIdMock: getVersionsStream,
          getTabsLimitStateMock: getTabsLimitState,
          getTabsLimitMock: getTabsLimit,
          getOrderFilterPreferences: getOrderFilterPreferences,
          getOrderedVersions: getOrderedVersions,
        ),
        act: (bloc) => bloc.init(songbook.id),
        expect: () => [
          isA<VersionsState>()
              .having((state) => state.isPro, "pro", isTrue)
              .having((state) => state.versionsLimit, "tabs limit", 1000),
          isA<VersionsState>()
              .having((state) => state.songbook, "songbook", songbook)
              .having((state) => state.versions, "versions", versions)
              .having((state) => state.versionsCount, "count", 2),
          isA<VersionsState>()
              .having((state) => state.selectedListOrderType, "ordered capsule", ListOrderType.custom)
              .having((state) => state.versions.length, "ordered version list", versions.length),
          isA<VersionsState>().having((state) => state.versionLimitState, "limit state", ListLimitState.withinLimit),
        ],
      );
    });

    group("and emit new songbook on stream", () {
      final newSongbook = getFakeSongbook();
      blocTest(
        "should emit correctly states",
        build: () => getBloc(
          getSongbookStreamByIdMock: getSongbookStreamById,
          getProStatusStreamMock: getProStatus,
          getVersionsStreamBySongbookIdMock: getVersionsStream,
          getTabsLimitStateMock: getTabsLimitState,
          getTabsLimitMock: getTabsLimit,
          getOrderFilterPreferences: getOrderFilterPreferences,
          getOrderedVersions: getOrderedVersions,
        ),
        act: (bloc) async {
          await bloc.init(songbook.id);
          songbookBehaviorSubject.add(newSongbook);
        },
        expect: () => [
          isA<VersionsState>()
              .having((state) => state.isPro, "pro", isTrue)
              .having((state) => state.versionsLimit, "tabs limit", 1000),
          isA<VersionsState>()
              .having((state) => state.songbook, "songbook", songbook)
              .having((state) => state.versions, "versions", versions)
              .having((state) => state.versionsCount, "count", 2),
          isA<VersionsState>()
              .having((state) => state.selectedListOrderType, "ordered capsule", ListOrderType.custom)
              .having((state) => state.versions.length, "ordered version list", versions.length),
          isA<VersionsState>().having((state) => state.versionLimitState, "limit state", ListLimitState.withinLimit),
          isA<VersionsState>().having((state) => state.songbook, "new songbook", newSongbook)
        ],
      );
    });

    group("and emit new list of version on stream", () {
      final newVersions = [getFakeVersion(), getFakeVersion(), getFakeVersion()];

      blocTest(
        "should emit correctly states",
        build: () => getBloc(
          getSongbookStreamByIdMock: getSongbookStreamById,
          getProStatusStreamMock: getProStatus,
          getVersionsStreamBySongbookIdMock: getVersionsStream,
          getTabsLimitStateMock: getTabsLimitState,
          getTabsLimitMock: getTabsLimit,
          getOrderFilterPreferences: getOrderFilterPreferences,
          getOrderedVersions: getOrderedVersions,
        ),
        act: (bloc) async {
          await bloc.init(songbook.id);
          when(() => getOrderedVersions(any(), any(), any())).thenReturn(newVersions);
          versionsBehaviorSubject.add(newVersions);
        },
        expect: () => [
          isA<VersionsState>()
              .having((state) => state.isPro, "pro", isTrue)
              .having((state) => state.versionsLimit, "tabs limit", 1000),
          isA<VersionsState>()
              .having((state) => state.versions, "versions", versions)
              .having((state) => state.versionsCount, "count", 2),
          isA<VersionsState>()
              .having((state) => state.selectedListOrderType, "ordered capsule", ListOrderType.custom)
              .having((state) => state.versions.length, "ordered version list", versions.length),
          isA<VersionsState>().having((state) => state.versionLimitState, "limit state", ListLimitState.withinLimit),
          isA<VersionsState>()
              .having((state) => state.versions, "new versions", newVersions)
              .having((state) => state.versions.length, "new versions ordered", 3)
              .having((state) => state.versionsCount, "new versions count", 3)
        ],
      );
    });

    group("and songbook id is null", () {
      blocTest(
        "should emit correctly states",
        build: () => getBloc(
          getSongbookStreamByIdMock: getSongbookStreamById,
          getProStatusStreamMock: getProStatus,
          getVersionsStreamBySongbookIdMock: getVersionsStream,
          getTabsLimitStateMock: getTabsLimitState,
          getTabsLimitMock: getTabsLimit,
        ),
        act: (bloc) => bloc.init(null),
        expect: () => [
          isA<VersionsState>()
              .having((state) => state.isPro, "pro", isTrue)
              .having((state) => state.versionsLimit, "tabs limit", 1000),
        ],
      );
    });

    group("and songbook id is not null and is recent songbook", () {
      final recentSongbook = getFakeSongbook(listType: ListType.recents);

      when(() => getSongbookStreamById(recentSongbook.id)).thenAnswer((_) => BehaviorSubject.seeded(recentSongbook));
      when(() => getVersionsStream(recentSongbook.id!)).thenAnswer((_) => BehaviorSubject.seeded(versions));
      when(() => getTabsLimitState(recentSongbook.id!))
          .thenAnswer((_) => BehaviorSubject.seeded(ListLimitState.withinLimit));

      final getOrderedVersions = _GetOrderedVersionsMock();
      when(() => getOrderedVersions(any(), any(), any())).thenReturn(versions);

      blocTest(
        "should emit correctly states",
        build: () => getBloc(
          getSongbookStreamByIdMock: getSongbookStreamById,
          getProStatusStreamMock: getProStatus,
          getVersionsStreamBySongbookIdMock: getVersionsStream,
          getTabsLimitStateMock: getTabsLimitState,
          getTabsLimitMock: getTabsLimit,
          getOrderFilterPreferences: getOrderFilterPreferences,
          getOrderedVersions: getOrderedVersions,
        ),
        act: (bloc) => bloc.init(recentSongbook.id),
        expect: () => [
          isA<VersionsState>()
              .having((state) => state.isPro, "pro", isTrue)
              .having((state) => state.versionsLimit, "tabs limit", 1000),
          isA<VersionsState>()
              .having((state) => state.songbook, "songbook", recentSongbook)
              .having((state) => state.versions, "versions", versions)
              .having((state) => state.versionsCount, "count", 2),
          isA<VersionsState>()
              .having((state) => state.selectedListOrderType, "ordered capsule", ListOrderType.recent)
              .having((state) => state.versions.length, "ordered version list", versions.length),
          isA<VersionsState>().having((state) => state.versionLimitState, "limit state", ListLimitState.withinLimit),
        ],
      );
    });
  });

  test("When call 'shareLink' should call sharelink lib", () async {
    final shareLink = _ShareLinkMock();
    when(() => shareLink(link: "https://www.test.com", sharePositionOrigin: null))
        .thenAnswer((_) => SynchronousFuture(const ShareResult("raw", ShareResultStatus.success)));

    final bloc = getBloc(shareLinkMock: shareLink);
    await bloc.shareLink("https://www.test.com", null);

    verify(() => shareLink(link: "https://www.test.com")).called(1);
  });

  group("When 'onSelectedOrderType' is called", () {
    final versions = [getFakeVersion(), getFakeVersion()];

    final getOrderedVersions = _GetOrderedVersionsMock();
    when(() => getOrderedVersions(any(), any(), any())).thenReturn(versions);

    final setOrderPreferences = _SetOrderFilterPreferencesMock();
    when(() => setOrderPreferences(any())).thenAnswer((_) => SynchronousFuture(false));

    blocTest(
      "should emit correctly states",
      build: () => getBloc(
        getOrderedVersions: getOrderedVersions,
        setOrderFilterPreferences: setOrderPreferences,
      )..emit(VersionsState(versions: versions, songbook: getFakeSongbook())),
      act: (bloc) => bloc.onSelectedOrderType(ListOrderType.recent),
      expect: () => [
        isA<VersionsState>()
            .having((state) => state.selectedListOrderType, "list order type", ListOrderType.recent)
            .having((state) => state.versions, "versions", versions),
      ],
      verify: (bloc) {
        verify(() => setOrderPreferences(ListOrderType.recent)).called(1);
        verify(() => getOrderedVersions(ListOrderType.recent, versions, ListType.user)).called(1);
      },
    );
  });

  group("When 'deleteVersion' is called", () {
    final version = getFakeVersion();
    final deleteVersions = _DeleteVersions();

    when(() => deleteVersions(songbookId: any(named: "songbookId"), versions: any(named: "versions")))
        .thenAnswer((_) => SynchronousFuture(const Ok(null)));

    blocTest(
      "should call use case",
      build: () => getBloc(
        deleteVersions: deleteVersions,
      ),
      act: (bloc) => bloc.deleteVersion(1, version),
      verify: (bloc) {
        verify(() => deleteVersions(songbookId: any(named: "songbookId"), versions: any(named: "versions"))).called(1);
      },
    );
  });

  group("When 'deleteVersion' is called and songbookId is null", () {
    final version = getFakeVersion();
    final deleteVersions = _DeleteVersions();

    when(() => deleteVersions(songbookId: any(named: "songbookId"), versions: any(named: "versions")))
        .thenAnswer((_) => SynchronousFuture(const Ok(null)));

    blocTest(
      "should not call use case",
      build: () => getBloc(
        deleteVersions: deleteVersions,
      ),
      act: (bloc) => bloc.deleteVersion(null, version),
      verify: (bloc) {
        verifyNever(() => deleteVersions(songbookId: any(named: "songbookId"), versions: any(named: "versions")));
      },
    );
  });
}
