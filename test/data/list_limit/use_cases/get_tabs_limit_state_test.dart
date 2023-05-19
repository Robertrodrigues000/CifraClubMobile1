import 'dart:async';

import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/models/tabs_limit_constants.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_tabs_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_tabs_limit_state.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_tabs_limit_constants.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbook_cifras.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _GetTabsLimitConstantsMock extends Mock implements GetTabsLimitConstants {}

class _GetTotalSongbookCifrasMock extends Mock implements GetTotalSongbookCifras {}

class _GetTabsLimitMock extends Mock implements GetTabsLimit {}

class _GetProStatusStreamMock extends Mock implements GetProStatusStream {}

void main() {
  const defaultTabsLimitConstants = TabsLimitConstants(
    maxTabsForFree: 100,
    maxTabsForPro: 1000,
    tabsWarningCountThreshold: 10,
  );

  late _GetTabsLimitConstantsMock getTabsLimitConstantsMock;

  setUp(() {
    getTabsLimitConstantsMock = _GetTabsLimitConstantsMock();
    when(getTabsLimitConstantsMock.call).thenAnswer((_) => defaultTabsLimitConstants);
  });

  test('when getTabsLimitState is called should return correct limit state', () async {
    final totalSongbookCifrasStream = Stream.fromIterable([85, 95, 100]);
    final getTotalSongbookCifras = _GetTotalSongbookCifrasMock();
    final getTabsLimit = _GetTabsLimitMock();
    final getProStatusStream = _GetProStatusStreamMock();

    when(() => getTotalSongbookCifras(any())).thenAnswer((_) => totalSongbookCifrasStream);
    when(getProStatusStream.call).thenAnswer((_) => Stream.value(false));
    when(() => getTabsLimit.call(any())).thenAnswer((invocation) => defaultTabsLimitConstants.maxTabsForFree);

    final getTabsLimitState =
        GetTabsLimitState(getTotalSongbookCifras, getTabsLimit, getProStatusStream, getTabsLimitConstantsMock);

    final listStateStream = getTabsLimitState(1);

    expect(
        listStateStream,
        emitsInOrder([
          ListLimitState.withinLimit,
          ListLimitState.atWarning,
          ListLimitState.reached,
        ]));
  });
}
