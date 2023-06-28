import 'dart:async';

import 'package:cifraclub/domain/list_limit/models/list_limit_constants.dart';
import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit_state.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_list_limit_constants.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbooks.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _GetListLimitConstantsMock extends Mock implements GetListLimitConstants {}

class _GetTotalSongbooksMock extends Mock implements GetTotalSongbooks {}

class _GetListLimitMock extends Mock implements GetListLimit {}

class _GetProStatusStreamMock extends Mock implements GetProStatusStream {}

void main() {
  const defaultListLimitConstants = ListLimitConstants(
    maxListsForFree: 10,
    maxListsForPro: 1000,
    listWarningCountThreshold: 2,
  );

  late _GetListLimitConstantsMock getListLimitConstantsMock;

  setUp(() {
    getListLimitConstantsMock = _GetListLimitConstantsMock();
    when(getListLimitConstantsMock.call).thenAnswer((_) => defaultListLimitConstants);
  });
  test('when getListLimitState is called should return correct limit state', () async {
    final totalSongbooksStream = Stream.fromIterable([7, 9, 10]);
    final getTotalSongbooks = _GetTotalSongbooksMock();
    final getListLimit = _GetListLimitMock();
    final getProStatusStream = _GetProStatusStreamMock();

    when(getTotalSongbooks.call).thenAnswer((_) => totalSongbooksStream);
    when(getProStatusStream.call).thenAnswer((_) => Stream.value(false));
    when(() => getListLimit.call(any())).thenAnswer((invocation) => 10);

    final getListLimitState =
        GetListLimitState(getTotalSongbooks, getProStatusStream, getListLimit, getListLimitConstantsMock);

    final listStateStream = getListLimitState();

    expect(
        listStateStream,
        emitsInOrder([
          ListLimitState.withinLimit,
          ListLimitState.atWarning,
          ListLimitState.reached,
        ]));
  });
}
