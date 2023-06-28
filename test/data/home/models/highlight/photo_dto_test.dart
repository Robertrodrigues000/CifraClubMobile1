import 'package:cifraclub/data/home/models/highlight/photo_dto.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("when `toDomain` is called, should correctly convert to HomeImage", () {
    final photoDto = PhotoDto(
      small: faker.image.image(),
      medium: faker.image.image(),
      large: faker.image.image(),
    );

    final homeImage = photoDto.toDomain();

    expect(homeImage.small, photoDto.small);
    expect(homeImage.medium, photoDto.medium);
    expect(homeImage.large, photoDto.large);
  });
}
