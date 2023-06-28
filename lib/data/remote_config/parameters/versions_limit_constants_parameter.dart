// coverage:ignore-file
import 'dart:convert';

import 'package:cifraclub/data/remote_config/remote_config_parameter.dart';
import 'package:cifraclub/domain/list_limit/models/versions_limit_constants.dart';

class VersionsLimitConstantsParameter extends RemoteConfigParameter<VersionsLimitConstants> {
  @override
  String get defaultValue => r'''
    {
        "maxTabsForFree": 100,
        "maxTabsForPro": 1000,
        "tabsWarningCountThreshold":10
  }
  ''';

  @override
  VersionsLimitConstants parseParam(String value) {
    final Map<String, dynamic> map = jsonDecode(value);

    return VersionsLimitConstants(
      maxVersionsForFree: map["maxTabsForFree"] as int,
      maxVersionsForPro: map["maxTabsForPro"] as int,
      versionsWarningCountThreshold: map["tabsWarningCountThreshold"] as int,
    );
  }

  @override
  String get remoteConfigKey => "tabs_limit_constants";
}
