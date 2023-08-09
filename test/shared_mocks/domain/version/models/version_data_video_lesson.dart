import 'package:cifraclub/domain/version/models/version_data_video_lesson.dart';
import 'package:faker/faker.dart';

VersionDataVideoLesson getFakeVersionDataVideoLesson() => VersionDataVideoLesson(
      id: faker.randomGenerator.integer(100),
      youtubeId: faker.address.city(),
      title: faker.address.city(),
      thumb: faker.address.city(),
    );
