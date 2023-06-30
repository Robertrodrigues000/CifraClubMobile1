// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

enum Instrument {
  guitar("", 1),
  ukulele("ukulele", 12),
  keyboard("keyboard", 9),
  cavaco("cavaco", 10),
  violaCaipira("viola", 13),
  bass("tabs-baixo", 2),
  drums("tabs-bateria", 3),
  harmonica("tabs-gaita", 5);

  final String instrumentUrl;
  final int apiType;

  const Instrument(this.instrumentUrl, this.apiType);

  bool get isCifraInstrument => this != Instrument.bass || this != Instrument.drums || this != Instrument.harmonica;

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
}
