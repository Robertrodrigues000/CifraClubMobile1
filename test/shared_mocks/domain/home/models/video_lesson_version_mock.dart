import 'package:cifraclub/domain/home/models/video_lesson_version.dart';
import 'package:faker/faker.dart';

VideoLessonVersion getFakeVideoLessonVersion() => VideoLessonVersion(
      id: faker.randomGenerator.integer(1000),
      type: faker.randomGenerator.integer(10),
      label: faker.animal.name(),
    );
