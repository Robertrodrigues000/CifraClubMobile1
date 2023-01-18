import 'package:flutter_test/flutter_test.dart';

import '../../shared_mocks/data/remote_config/int_test_param.dart';

void main() {
  group('when value is set', () {
    test('check if remote value was set after setting default value', () {
      final parameter = IntTestParam();

      expect(parameter.value, equals(2));

      parameter.setRemoteData('5');

      expect(parameter.value, equals(5));
    });

    test('set default value if parse throws an exception', () async {
      final parameter = IntTestParam();
      parameter.setRemoteData('🤡🧨');

      expect(parameter.value, equals(2));
    });

    test('check if value is updated after new remote value was set', () {
      final parameter = IntTestParam();

      expect(parameter.value, equals(2));

      parameter.setRemoteData('5');

      expect(parameter.value, equals(5));

      parameter.setRemoteData('10');

      expect(parameter.value, equals(10));
    });
  });
}
