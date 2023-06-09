import 'package:cifraclub/domain/home/models/news.dart';
import 'package:faker/faker.dart';

import 'images_size_mock.dart';

News getFakeNews() => News(
      url: faker.internet.httpUrl(),
      image: faker.internet.httpUrl(),
      thumb: getFakeHomeImage(),
      headline: faker.animal.name(),
      publishDate: '2023-03-16 14:03:00',
    );
