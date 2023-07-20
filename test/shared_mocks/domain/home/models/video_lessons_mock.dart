import 'package:cifraclub/domain/home/models/video_lesson.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:faker/faker.dart';

import '../../artist/models/artist_mock.dart';
import 'images_size_mock.dart';
import 'video_lesson_version_mock.dart';

VideoLesson getFakeVideoLessons() => VideoLesson(
    id: faker.randomGenerator.integer(1000),
    youtubeId: faker.internet.email(),
    title: faker.food.cuisine(),
    url: faker.internet.httpUrl(),
    views: faker.randomGenerator.integer(1000),
    duration: faker.randomGenerator.integer(1000),
    urlApi: faker.internet.httpUrl(),
    images: getFakeHomeImage(),
    instrument: Instrument.guitar,
    artist: getFakeArtist(),
    version: getFakeVideoLessonVersion());
