import 'package:cifraclub/domain/list_limit/models/tabs_limit_constants.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_tabs_limit.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_tabs_limit_constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _GetTabsLimitConstantsMock extends Mock implements GetTabsLimitConstants {}

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
  group("when getTabsLimit is called", () {
    test('if user is not pro should return free limit', () async {
      const isPro = false;
      final getTabsLimit = GetTabsLimit(getTabsLimitConstantsMock);

      final limit = getTabsLimit(isPro);

      expect(limit, 100);
    });

    test('if user is pro should return pro limit', () async {
      const isPro = true;
      final getTabsLimit = GetTabsLimit(getTabsLimitConstantsMock);

      final limit = getTabsLimit(isPro);

      expect(limit, 1000);
    });
  });
}
