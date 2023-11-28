import 'package:cifraclub/domain/version/models/capo.dart';
import 'package:cifraclub/domain/version/models/chord.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/instrument_version.dart';
import 'package:cifraclub/domain/version/models/tuning.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:cifraclub/domain/version/models/version_data_video_lesson.dart';
import 'package:cifraclub/domain/version/models/version_status.dart';
import 'package:faker/faker.dart';

import '../../artist/models/artist_mock.dart';
import 'instrument_version_mock.dart';
import 'music_mock.dart';

VersionData getFakeVersionData({
  List<({Instrument instrument, List<InstrumentVersion> versions})>? instrumentVersions,
  VersionDataVideoLesson? videoLesson,
  Instrument? instrument,
  int? songId,
  VersionStatus? status,
  String? key,
}) {
  final label = faker.food.restaurant();
  return VersionData(
    videoLesson: videoLesson,
    versionId: faker.randomGenerator.integer(100),
    status: status ?? VersionStatus.normal,
    instrument: instrument ?? Instrument.bass,
    content: faker.food.restaurant(),
    versionName: label,
    versionUrl: faker.food.restaurant(),
    completePath: faker.food.restaurant(),
    siteUrl: faker.food.restaurant(),
    key: key ?? faker.food.restaurant(),
    shapeKey: faker.food.restaurant(),
    stdKey: key ?? faker.food.restaurant(),
    stdShapeKey: faker.food.restaurant(),
    tuning: Tuning.c,
    capo: Capo.getCapoById(faker.randomGenerator.integer(12)),
    composers: faker.food.restaurant(),
    isVerified: faker.randomGenerator.boolean(),
    blocked: faker.randomGenerator.boolean(),
    reason: faker.food.restaurant(),
    instrumentVersions: instrumentVersions ??
        [
          (versions: [getFakeInstrumentVersion()], instrument: Instrument.bass)
        ],
    song: getFakeSong(songId: songId),
    artist: getFakeArtist(),
    chords: List.generate(
      faker.randomGenerator.integer(5, min: 1),
      (index) => Chord(
        name: faker.person.name()[0],
        shapeName: faker.person.name()[0],
        guitar: [
          "X 0 2 0 1 0",
          "X 0 2 0 1 3",
          "5 3 5 5 X X",
          "5 3 5 2 X X",
        ],
        cavaco: ["7 P5 5 5"],
        keyboard: ["10 1 5 8"],
        ukulele: [
          "0 0 0 0",
          "2 4 3 3",
          "0 4 5 3",
          "5 4 3 0",
        ],
        viola: ["X 7 6 7 5"],
        violaMi: ["X 5 4 5 3", "X 5 4 8 0"],
        violaRa: ["X 7 5 5 5"],
      ),
    ),
  );
}
