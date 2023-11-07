import 'package:cifraclub/domain/version/models/instrument.dart';

enum Tuning {
  defaultTuning("E A D G B E", "E A D G B E", 0, 0, Instrument.guitar),
  eb("Eb Ab Db Gb Bb Eb", "Eb Ab Db Gb Bb Eb", -1, 1, Instrument.guitar),
  d("D G C F A D", "D G C F A D", -2, 2, Instrument.guitar),
  dB("Db Gb B E Ab Db", "Db Gb B E Ab Db", -3, 3, Instrument.guitar),
  c("C F Bb Eb G C", "C F Bb Eb G C", -4, 4, Instrument.guitar),
  violaCaipiraCebolaoD("Cebolão em D", "A D F# A D", 0, 0, Instrument.violaCaipira),
  violaCaipiraCebolaoE("Cebolão em E", "B E G# B E", 0, 1, Instrument.violaCaipira),
  violaCaipiraCebolaoRioAbaixo("Rio Abaixo", "G D G B D", 0, 2, Instrument.violaCaipira);

  final String name;
  final String value;
  final int tuningVariation;
  final int orderPosition;
  final Instrument instrument;

  const Tuning(this.name, this.value, this.tuningVariation, this.orderPosition, this.instrument);

  static Tuning getTuningByValue(String? value) {
    return Tuning.values.firstWhere((tuning) => tuning.value == value, orElse: () => Tuning.defaultTuning);
  }

  static List<Tuning> getTuningsByInstrument(Instrument instrument) =>
      Tuning.values.where((tuning) => tuning.instrument == instrument).toList();
}
