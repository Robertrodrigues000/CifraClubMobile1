import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/instrument_version.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllInstrumentVersions {
  List<({Instrument instrument, List<InstrumentVersion> versions})> call(
      List<({Instrument instrument, List<InstrumentVersion> versions})> instrumentVersions) {
    final instrumentVersionGuitar =
        instrumentVersions.firstWhereOrNull((element) => element.instrument == Instrument.guitar);

    final stringInstruments = instrumentVersionGuitar != null
        ? [Instrument.violaCaipira, Instrument.ukulele, Instrument.keyboard, Instrument.cavaco]
            .map((e) => (
                  instrument: e,
                  versions: instrumentVersionGuitar.versions.map((e) => e.copyWith(videoLesson: null)).toList()
                ))
            .toList()
        : List<({Instrument instrument, List<InstrumentVersion> versions})>.empty();

    final result =
        (instrumentVersions + stringInstruments).sorted((a, b) => a.instrument.index.compareTo(b.instrument.index));
    return result;
  }
}
