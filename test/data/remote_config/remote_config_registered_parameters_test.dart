import 'package:cifraclub/data/remote_config/remote_config_registered_parameters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Parse all default values with no exceptions being thrown', () {
    final parameters = RemoteConfigRegisteredParameters();
    for (final param in parameters.registeredParams) {
      param.parseParam(param.defaultValue);
    }
  });
}
