// coverage:ignore-file
import 'dart:convert';

import 'package:cifraclub/data/remote_config/remote_config_parameter.dart';
import 'package:cifraclub/domain/list_limit/models/list_limit_constants.dart';

class ListLimitConstantsParameter extends RemoteConfigParameter<ListLimitConstants> {
  @override
  String get defaultValue => r'''
    {
        "maxListsForFree": 10,
        "maxListsForPro": 1000,
        "listWarningCountThreshold": 2
  }
  ''';

  @override
  ListLimitConstants parseParam(String value) {
    final Map<String, dynamic> map = jsonDecode(value);

    return ListLimitConstants(
      maxListsForFree: map["maxListsForFree"] as int,
      maxListsForPro: map["maxListsForPro"] as int,
      listWarningCountThreshold: map["listWarningCountThreshold"] as int,
    );
  }

  @override
  String get remoteConfigKey => "list_limit_constants";
}
