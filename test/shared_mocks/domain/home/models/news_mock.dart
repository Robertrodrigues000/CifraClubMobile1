import 'package:cifraclub/domain/home/models/news.dart';
import 'package:faker/faker.dart';

import 'home_image_mock.dart';

News getFakeNews() => News(
      url: faker.internet.httpUrl(),
      image: faker.internet.httpUrl(),
      thumb: getFakeHomeImage(),
      headline: faker.animal.name(),
      publishDate: faker.date.random.toString(),
    );
