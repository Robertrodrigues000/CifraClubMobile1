import 'package:cifraclub/domain/list_limit/models/versions_limit_constants.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_versions_limit_constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _GetVersionsLimitConstantsMock extends Mock implements GetVersionsLimitConstants {}

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
  group("when getTabsLimit is called", () {
    test('if user is not pro should return free limit', () async {
      const isPro = false;
      final getVersionsLimit = GetVersionsLimit(getVersionsLimitConstantsMock);

      final limit = getVersionsLimit(isPro);

      expect(limit, 100);
    });

    test('if user is pro should return pro limit', () async {
      const isPro = true;
      final getVersionsLimit = GetVersionsLimit(getVersionsLimitConstantsMock);

      final limit = getVersionsLimit(isPro);

      expect(limit, 1000);
    });
  });
}
