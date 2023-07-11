// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

enum Instrument {
  guitar("", 1, [1, 2]),
  ukulele("ukulele", 12, [11]),
  keyboard("keyboard", 9, [5]),
  cavaco("cavaco", 10, [10]),
  violaCaipira("viola", 13, [9]),
  bass("tabs-baixo", 2, [3]),
  drums("tabs-bateria", 3, [4]),
  harmonica("tabs-gaita", 5, []);

  final String instrumentUrl;
  final int apiType;
  final List<int> videoLessonInstrumentIds;
  const Instrument(this.instrumentUrl, this.apiType, this.videoLessonInstrumentIds);

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
    }
  }

  static Instrument getInstrumentByType(int? apiType) {
    return Instrument.values.singleWhere((element) => element.apiType == apiType, orElse: () => Instrument.guitar);
  }

  static Instrument getInstrumentByVideoLessonId(int? instrumentId) {
    return Instrument.values.singleWhere((element) => element.videoLessonInstrumentIds.contains(instrumentId),
        orElse: () => Instrument.guitar);
  }
}
