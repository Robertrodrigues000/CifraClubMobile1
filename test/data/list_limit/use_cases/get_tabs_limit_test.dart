import 'package:cifraclub/domain/list_limit/models/limit_constants.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_tabs_limit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final defaultListLimitConstants = ListLimitConstants(
    maxListsForFree: 10,
    maxListsForPro: 1000,
    maxTabsForFree: 100,
    maxTabsForPro: 1000,
    listWarningCountThreshold: 2,
    tabsWarningCountThreshold: 10,
  );

  group("when getTabsLimit is called", () {
    test('if user is not pro should return free limit', () async {
      const isPro = false;
      final getTabsLimit = GetTabsLimit(defaultListLimitConstants);

      final limit = getTabsLimit(isPro);

      expect(limit, 100);
    });

    test('if user is pro should return pro limit', () async {
      const isPro = true;
      final getTabsLimit = GetTabsLimit(defaultListLimitConstants);

      final limit = getTabsLimit(isPro);

      expect(limit, 1000);
    });
  });
}
