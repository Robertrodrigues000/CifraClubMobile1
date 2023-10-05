import 'package:cifraclub/data/remote_config/remote_config_parameter.dart';

class ShazamTokenParameter extends RemoteConfigParameter<String> {
  @override
  String get defaultValue => "";

  @override
  String parseParam(String value) => value;

  @override
  String get remoteConfigKey => "shazam_token";
}
