import 'package:cifraclub/domain/home/models/highlight.dart';
import 'package:faker/faker.dart';

import 'home_image_mock.dart';

Highlight getFakeHighlight() => Highlight(
      url: faker.internet.httpUrl(),
      title: faker.company.position(),
      subtitle: faker.animal.name(),
      icon: faker.internet.domainName(),
      description: faker.geo.latitude().toStringAsExponential(),
      contentDescription: faker.geo.latitude().toStringAsExponential(),
      images: getFakeHomeImage(),
    );
