// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

enum Instrument {
  guitar("cifras", 1, ["guitar", "electric-guitar"], [1, 2]),
  ukulele("ukulele", 12, ["ukulele"], [11]),
  keyboard("keyboard", 9, ["keyboard"], [5]),
  cavaco("cavaco", 10, ["cavaco"], [10]),
  violaCaipira("viola", 13, ["viola"], [9]),
  bass("tabs-baixo", 2, ["bass"], [3]),
  drums("tabs-bateria", 3, ["drums"], [4]),
  harmonica("tabs-gaita", 5, [], []),
  unknown("unknown", 0, [], []);

  final String instrumentUrl;
  final int apiType;
  final List<String> videoLessonInstrumentNames;
  final List<int> videoLessonInstrumentIds;
  const Instrument(this.instrumentUrl, this.apiType, this.videoLessonInstrumentNames, this.videoLessonInstrumentIds);

  String getInstrumentName(BuildContext context) {
    switch (this) {
      case guitar:
        return context.text.instrumentGuitar;
      case ukulele:
        return context.text.instrumentUkulele;
      case keyboard:
        return context.text.instrumentKeyboard;
      case cavaco:
        return context.text.instrumentCavaco;
      case violaCaipira:
        return context.text.instrumentViola;
      case bass:
        return context.text.instrumentBass;
      case drums:
        return context.text.instrumentDrums;
      case harmonica:
        return context.text.instrumentHarmonica;
      case unknown:
        return "";
    }
  }

  static Instrument? getInstrumentByType(int? apiType) {
    return Instrument.values.firstWhereOrNull((element) => element.apiType == apiType);
  }

  static Instrument getInstrumentByVideoLessonId(int? instrumentId) {
    return Instrument.values.singleWhere((element) => element.videoLessonInstrumentIds.contains(instrumentId),
        orElse: () => Instrument.guitar);
  }
}
