import 'package:cifraclub/domain/version/models/instrument_version.dart';
import 'package:faker/faker.dart';

import 'version_data_video_lesson.dart';

InstrumentVersion getFakeInstrumentVersion({String? VersionName}) => InstrumentVersion(
      id: faker.randomGenerator.integer(100),
      versionName: VersionName ?? faker.lorem.word(),
      versionUrl: faker.internet.email(),
      videoLesson: getFakeVersionDataVideoLesson(),
      completePath: faker.internet.httpUrl(),
      isVerified: faker.randomGenerator.boolean(),
    );
