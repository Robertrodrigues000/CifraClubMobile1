import 'package:cifraclub/domain/home/models/images_size.dart';
import 'package:faker/faker.dart';

ImagesSize getFakeHomeImage() => ImagesSize(
      small: faker.address.city(),
      medium: faker.address.city(),
      large: faker.address.city(),
    );
