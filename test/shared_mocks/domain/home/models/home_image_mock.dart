import 'package:cifraclub/domain/home/models/home_image.dart';
import 'package:faker/faker.dart';

HomeImage getFakeHomeImage() => HomeImage(
      small: faker.address.city(),
      medium: faker.address.city(),
      large: faker.address.city(),
    );
