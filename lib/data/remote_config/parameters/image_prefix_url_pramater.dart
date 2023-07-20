// coverage:ignore-file

import 'package:cifraclub/data/remote_config/remote_config_parameter.dart';

class ImagePrefixUrlParameter extends RemoteConfigParameter<String> {
  @override
  String get defaultValue => "https://akamai.sscdn.co/";

  @override
  String parseParam(String value) => value;

  @override
  String get remoteConfigKey => "images_cdn_prefix";
}
