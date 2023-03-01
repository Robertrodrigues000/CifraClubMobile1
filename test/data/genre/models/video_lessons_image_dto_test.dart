import 'package:cifraclub/data/home/models/video_lessons/video_lessons_image_dto.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("when `toDomain` is called, should correctly convert to HomeImage", () {
    final videoLessonsImageDto = VideoLessonsImageDto(
      image: faker.image.image(),
      imagemq: faker.image.image(),
      imagesd: faker.image.image(),
    );

    final homeImage = videoLessonsImageDto.toDomain();

    expect(homeImage.small, videoLessonsImageDto.imagesd);
    expect(homeImage.medium, videoLessonsImageDto.imagemq);
    expect(homeImage.large, videoLessonsImageDto.image);
  });
}
