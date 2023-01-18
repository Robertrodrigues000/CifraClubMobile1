import 'package:cifraclub/data/remote_config/remote_config_parameter.dart';

class IntTestParam extends RemoteConfigParameter<int> {
  @override
  String get defaultValue => '2';

  @override
  int parseParam(String value) => int.parse(value);

  @override
  String get remoteConfigKey => 'intRemoteConfigKey';
}
