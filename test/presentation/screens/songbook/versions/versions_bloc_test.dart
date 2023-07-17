import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_versions_stream_by_songbook_id.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_songbook_stream_by_id.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../shared_mocks/domain/songbook/models/songbook_mock.dart';
import '../../../../shared_mocks/domain/version/models/version_mock.dart';

class _GetSongbookStreamByIdMock extends Mock implements GetSongbookStreamById {}

class _ShareLinkMock extends Mock implements ShareLink {}

class _GetCifrasStreamBySongbookIdMock extends Mock implements GetVersionsStreamBySongbookId {}

class _GetVersionsLimitStateMock extends Mock implements GetVersionsLimitState {}

class _GetProStatusStreamMock extends Mock implements GetProStatusStream {}

class _GetVersionsLimitMock extends Mock implements GetVersionsLimit {}

void main() {
  VersionsBloc getBloc({
    _GetSongbookStreamByIdMock? getSongbookStreamByIdMock,
    _ShareLinkMock? shareLinkMock,
    _GetCifrasStreamBySongbookIdMock? getCifrasStreamBySongbookIdMock,
    _GetVersionsLimitStateMock? getTabsLimitStateMock,
    _GetProStatusStreamMock? getProStatusStreamMock,
    _GetVersionsLimitMock? getTabsLimitMock,
  }) =>
      VersionsBloc(
        getSongbookStreamByIdMock ?? _GetSongbookStreamByIdMock(),
        shareLinkMock ?? _ShareLinkMock(),
        getCifrasStreamBySongbookIdMock ?? _GetCifrasStreamBySongbookIdMock(),
        getTabsLimitStateMock ?? _GetVersionsLimitStateMock(),
        getProStatusStreamMock ?? _GetProStatusStreamMock(),
        getTabsLimitMock ?? _GetVersionsLimitMock(),
      );

  group("When call 'init'", () {
    final songbook = getFakeSongbook();
    final cifras = [getFakeVersion(), getFakeVersion()];

    final getSongbookStreamById = _GetSongbookStreamByIdMock();
    when(() => getSongbookStreamById(songbook.id)).thenAnswer((_) => BehaviorSubject.seeded(songbook));
    when(() => getSongbookStreamById(null)).thenAnswer((_) => BehaviorSubject.seeded(null));

    final getProStatus = _GetProStatusStreamMock();
    when(getProStatus).thenAnswer((_) => BehaviorSubject.seeded(true));

    final getCifras = _GetCifrasStreamBySongbookIdMock();
    when(() => getCifras(songbook.id!)).thenAnswer((_) => BehaviorSubject.seeded(cifras));

    final getTabsLimitState = _GetVersionsLimitStateMock();
    when(() => getTabsLimitState(songbook.id!)).thenAnswer((_) => BehaviorSubject.seeded(ListLimitState.withinLimit));

    final getTabsLimit = _GetVersionsLimitMock();
    when(() => getTabsLimit(true)).thenReturn(1000);

    group("and songbook id is not null", () {
      blocTest(
        "should emit correctly states",
        build: () => getBloc(
          getSongbookStreamByIdMock: getSongbookStreamById,
          getProStatusStreamMock: getProStatus,
          getCifrasStreamBySongbookIdMock: getCifras,
          getTabsLimitStateMock: getTabsLimitState,
          getTabsLimitMock: getTabsLimit,
        ),
        act: (bloc) => bloc.init(songbook.id),
        expect: () => [
          isA<VersionsState>()
              .having((state) => state.isPro, "pro", isTrue)
              .having((state) => state.versionsLimit, "tabs limit", 1000),
          isA<VersionsState>().having((state) => state.songbook, "songbook", songbook),
          isA<VersionsState>()
              .having((state) => state.versions, "cifras", cifras)
              .having((state) => state.versionsCount, "count", 2),
          isA<VersionsState>().having((state) => state.versionLimitState, "limit state", ListLimitState.withinLimit),
        ],
      );
    });

    group("and songbook id is null", () {
      blocTest(
        "should emit correctly states",
        build: () => getBloc(
          getSongbookStreamByIdMock: getSongbookStreamById,
          getProStatusStreamMock: getProStatus,
          getCifrasStreamBySongbookIdMock: getCifras,
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
  });

  test("When call 'shareLink' should call sharelink lib", () async {
    final shareLink = _ShareLinkMock();
    when(() => shareLink(link: "https://www.test.com", sharePositionOrigin: null))
        .thenAnswer((_) => SynchronousFuture(const ShareResult("raw", ShareResultStatus.success)));

    final bloc = getBloc(shareLinkMock: shareLink);
    await bloc.shareLink("https://www.test.com", null);

    verify(() => shareLink(link: "https://www.test.com")).called(1);
  });
}
