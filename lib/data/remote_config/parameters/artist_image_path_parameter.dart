// coverage:ignore-file

import 'package:cifraclub/data/remote_config/remote_config_parameter.dart';

class ArtistImagePathParameter extends RemoteConfigParameter<String> {
  @override
  String get defaultValue => "letras/50x50/fotos/";

  @override
  String parseParam(String value) => value;

  @override
  String get remoteConfigKey => "artist_50x50_image_path";
}
