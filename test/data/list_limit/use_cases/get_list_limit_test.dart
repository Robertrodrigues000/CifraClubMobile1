import 'package:cifraclub/domain/list_limit/models/limit_constants.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit.dart';
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

  group("when getListLimit is called", () {
    test('if user is not pro should return free limit', () async {
      const isPro = false;
      final getListLimit = GetListLimit(defaultListLimitConstants);

      final limit = getListLimit(isPro);

      expect(limit, 10);
    });

    test('if user is pro should return pro limit', () async {
      const isPro = true;
      final getListLimit = GetListLimit(defaultListLimitConstants);

      final limit = getListLimit(isPro);

      expect(limit, 1000);
    });
  });
}
