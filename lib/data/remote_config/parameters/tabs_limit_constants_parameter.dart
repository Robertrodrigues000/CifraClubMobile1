// coverage:ignore-file
import 'dart:convert';

import 'package:cifraclub/data/remote_config/remote_config_parameter.dart';
import 'package:cifraclub/domain/list_limit/models/tabs_limit_constants.dart';

class TabsLimitConstantsParameter extends RemoteConfigParameter<TabsLimitConstants> {
  @override
  String get defaultValue => r'''
    {
        "maxTabsForFree": 100,
        "maxTabsForPro": 1000,
        "tabsWarningCountThreshold":10
  }
  ''';

  @override
  TabsLimitConstants parseParam(String value) {
    final Map<String, dynamic> map = jsonDecode(value);

    return TabsLimitConstants(
      maxTabsForFree: map["maxTabsForFree"] as int,
      maxTabsForPro: map["maxTabsForPro"] as int,
      tabsWarningCountThreshold: map["tabsWarningCountThreshold"] as int,
    );
  }

  @override
  String get remoteConfigKey => "tabs_limit_constants";
}
