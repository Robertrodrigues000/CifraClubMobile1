import 'package:cifraclub/domain/home/models/video_lessons.dart';
import 'package:faker/faker.dart';

import 'home_image_mock.dart';

VideoLessons getFakeVideoLessons() => VideoLessons(
      id: faker.randomGenerator.integer(1000),
      youtubeId: faker.internet.email(),
      title: faker.food.cuisine(),
      url: faker.internet.httpUrl(),
      views: faker.randomGenerator.integer(1000),
      duration: faker.randomGenerator.integer(1000),
      urlApi: faker.internet.httpUrl(),
      images: getFakeHomeImage(),
      instrumentsId: [faker.food.cuisine()],
    );
