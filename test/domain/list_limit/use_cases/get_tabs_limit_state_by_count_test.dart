import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/models/tabs_limit_constants.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_tabs_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_tabs_limit_state_by_count.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_tabs_limit_constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _GetTabsLimitMock extends Mock implements GetTabsLimit {}

class _GetTabsLimitConstantsMock extends Mock implements GetTabsLimitConstants {}

void main() {
  late _GetTabsLimitConstantsMock getTabsLimitConstants;
  const defaultListLimitConstants = TabsLimitConstants(
    maxTabsForFree: 100,
    maxTabsForPro: 1000,
    tabsWarningCountThreshold: 10,
  );

  setUp(() {
    getTabsLimitConstants = _GetTabsLimitConstantsMock();
    when(getTabsLimitConstants).thenReturn(defaultListLimitConstants);
  });

  test("When is not pro and counter is below then thresholder should return withinLimit state", () {
    final getTabsLimit = _GetTabsLimitMock();

    when(() => getTabsLimit.call(any())).thenAnswer((invocation) => defaultListLimitConstants.maxTabsForFree);

    final getLimitState = GetTabLimitStateByCount(getTabsLimit, getTabsLimitConstants)(false, 89);

    expect(getLimitState, ListLimitState.withinLimit);
  });

  test("When is not pro and counter is over then thresholder and less then limit should return atWarning state", () {
    final getTabsLimit = _GetTabsLimitMock();

    when(() => getTabsLimit.call(any())).thenAnswer((invocation) => defaultListLimitConstants.maxTabsForFree);

    final getLimitState = GetTabLimitStateByCount(getTabsLimit, getTabsLimitConstants)(false, 99);

    expect(getLimitState, ListLimitState.atWarning);
  });

  test("When is not pro and counter is equals then limit should return reached state", () {
    final getTabsLimit = _GetTabsLimitMock();

    when(() => getTabsLimit.call(any())).thenAnswer((invocation) => defaultListLimitConstants.maxTabsForFree);

    final getLimitState = GetTabLimitStateByCount(getTabsLimit, getTabsLimitConstants)(false, 100);

    expect(getLimitState, ListLimitState.reached);
  });

  test("When user is pro and the counter is below the threshold it should return withinLimit state", () {
    final getTabsLimit = _GetTabsLimitMock();

    when(() => getTabsLimit.call(any())).thenAnswer((invocation) => defaultListLimitConstants.maxTabsForPro);

    final getLimitState = GetTabLimitStateByCount(getTabsLimit, getTabsLimitConstants)(true, 989);

    expect(getLimitState, ListLimitState.withinLimit);
  });

  test("When user is pro and the counter is over the threshold and below the limit it should return atWarning state",
      () {
    final getTabsLimit = _GetTabsLimitMock();

    when(() => getTabsLimit.call(any())).thenAnswer((invocation) => defaultListLimitConstants.maxTabsForPro);

    final getLimitState = GetTabLimitStateByCount(getTabsLimit, getTabsLimitConstants)(true, 999);

    expect(getLimitState, ListLimitState.atWarning);
  });

  test("When user is not pro and the counter is equal to the limit it should return reached state", () {
    final getTabsLimit = _GetTabsLimitMock();

    when(() => getTabsLimit.call(any())).thenAnswer((invocation) => defaultListLimitConstants.maxTabsForPro);

    final getLimitState = GetTabLimitStateByCount(getTabsLimit, getTabsLimitConstants)(true, 1000);

    expect(getLimitState, ListLimitState.reached);
  });
}
