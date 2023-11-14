import 'package:cifraclub/domain/chord/models/instrument_chord.dart';
import 'package:faker/faker.dart';

InstrumentChord getFakeInstrumentChord() => InstrumentChord(
      name: faker.animal.name(),
      fretDiagram: faker.address.person.name(),
      shapeName: faker.sport.name(),
    );
