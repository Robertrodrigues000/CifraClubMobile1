import 'dart:async';

import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/models/versions_limit_constants.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_versions_limit_constants.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbook_versions.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _GetVersionsLimitConstantsMock extends Mock implements GetVersionsLimitConstants {}

class _GetTotalSongbookVersionsMock extends Mock implements GetTotalSongbookVersions {}

class _GetVersionsLimitMock extends Mock implements GetVersionsLimit {}

class _GetProStatusStreamMock extends Mock implements GetProStatusStream {}

void main() {
  const defaultVersionsLimitConstants = VersionsLimitConstants(
    maxVersionsForFree: 100,
    maxVersionsForPro: 1000,
    versionsWarningCountThreshold: 10,
  );

  late _GetVersionsLimitConstantsMock getVersionsLimitConstantsMock;

  setUp(() {
    getVersionsLimitConstantsMock = _GetVersionsLimitConstantsMock();
    when(getVersionsLimitConstantsMock.call).thenAnswer((_) => defaultVersionsLimitConstants);
  });

  test('when getVersionsLimitState is called should return correct limit state', () async {
    final totalSongbookVersionsStream = Stream.fromIterable([85, 95, 100]);
    final getTotalSongbookVersions = _GetTotalSongbookVersionsMock();
    final getVersionsLimit = _GetVersionsLimitMock();
    final getProStatusStream = _GetProStatusStreamMock();

    when(() => getTotalSongbookVersions(any())).thenAnswer((_) => totalSongbookVersionsStream);
    when(getProStatusStream.call).thenAnswer((_) => Stream.value(false));
    when(() => getVersionsLimit.call(any()))
        .thenAnswer((invocation) => defaultVersionsLimitConstants.maxVersionsForFree);

    final getVersionsLimitState = GetVersionsLimitState(
        getTotalSongbookVersions, getVersionsLimit, getProStatusStream, getVersionsLimitConstantsMock);

    final listStateStream = getVersionsLimitState(1);

    expect(
        listStateStream,
        emitsInOrder([
          ListLimitState.withinLimit,
          ListLimitState.atWarning,
          ListLimitState.reached,
        ]));
  });
}
