import 'package:cifraclub/data/home/models/highlight/photo_dto.dart';
import 'package:cifraclub/data/home/models/news/news_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../shared_mocks/domain/home/models/images_size_mock.dart';

class _PhotoDtoMock extends Mock implements PhotoDto {}

void main() {
  test("when `toDomain` is called, should correctly convert to News", () {
    final photoDto = _PhotoDtoMock();
    final homeImage = getFakeHomeImage();
    when(photoDto.toDomain).thenReturn(homeImage);

    final newsDto = NewsDto(
      url: "/image",
      image: "image",
      thumb: photoDto,
      headline: "headline",
      publishDate: "23/07/98",
    );

    final news = newsDto.toDomain();

    verify(photoDto.toDomain).called(1);

    expect(news.url, newsDto.url);
    expect(news.image, newsDto.image);
    expect(news.thumb, homeImage);
    expect(news.headline, newsDto.headline);
    expect(news.publishDate, newsDto.publishDate);
  });
}
