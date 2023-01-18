import 'dart:convert';

import 'package:cifraclub/data/remote_config/remote_config_parameter.dart';

class TimeBetweenIntersitialsParameter extends RemoteConfigParameter<List<int>> {
  @override
  String get defaultValue => "[300]";

  @override
  List<int> parseParam(String value) {
    final array = List<int>.from(jsonDecode(value));
    return array;
  }

  @override
  String get remoteConfigKey => "cifraclub_time_between_interstitials";
}
