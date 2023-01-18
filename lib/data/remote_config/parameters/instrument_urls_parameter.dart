import 'dart:convert';

import 'package:cifraclub/data/remote_config/remote_config_parameter.dart';
import 'package:cifraclub/domain/remote_config/models/instrument_urls.dart';

class InstrumentUrlsParameter extends RemoteConfigParameter<InstrumentUrls> {
  @override
  String get defaultValue => '''
    {
      "electric_guitar": "",
      "acoustic_guitar": "",
      "ukulele": "/ukulele",
      "viola": "/viola",
      "keyboard": "/keyboard",
      "cavaco": "/cavaco",
      "bass": "/tabs-baixo",
      "harmonica": "/tabs-gaita",
      "drums": "/tabs-bateria"
    }
  ''';

  @override
  InstrumentUrls parseParam(String value) {
    final Map<String, dynamic> map = jsonDecode(value);

    return InstrumentUrls(
        acousticGuitar: map["acoustic_guitar"],
        bass: map["bass"],
        cavaco: map["cavaco"],
        drums: map["drums"],
        electricGuitar: map["electric_guitar"],
        harmonica: map["harmonica"],
        keyboard: map["keyboard"],
        ukulele: map["ukulele"],
        viola: map["viola"]);
  }

  @override
  String get remoteConfigKey => "url_instruments";
}
