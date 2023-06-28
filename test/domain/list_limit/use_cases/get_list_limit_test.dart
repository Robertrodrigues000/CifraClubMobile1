import 'package:cifraclub/domain/list_limit/models/list_limit_constants.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_list_limit_constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _GetListLimitConstantsMock extends Mock implements GetListLimitConstants {}

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

  group("when getListLimit is called", () {
    test('if user is not pro should return free limit', () async {
      const isPro = false;
      final getListLimit = GetListLimit(getListLimitConstantsMock);

      final limit = getListLimit(isPro);

      expect(limit, 10);
    });

    test('if user is pro should return pro limit', () async {
      const isPro = true;
      final getListLimit = GetListLimit(getListLimitConstantsMock);

      final limit = getListLimit(isPro);

      expect(limit, 1000);
    });
  });
}
