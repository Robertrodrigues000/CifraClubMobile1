import 'package:cifraclub/data/home/models/highlight/highlight_dto.dart';
import 'package:cifraclub/data/home/models/highlight/photos_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/home/models/images_size_mock.dart';

class _PhotosDtoMock extends Mock implements PhotosDto {}

void main() {
  test("when `toDomain` is called, should correctly convert to Highlight", () {
    final photosDto = _PhotosDtoMock();
    final homeImage = getFakeHomeImage();
    when(photosDto.toDomain).thenReturn(homeImage);

    final highlightDto = HighlightDto(
      url: "/url",
      title: "Melhores artistas",
      description: "Melhores artistas de 2022",
      imageDescription: "Foto de 3 artistas",
      photos: photosDto,
      subtitle: 'Purple Haze',
    );

    final highlight = highlightDto.toDomain();

    verify(photosDto.toDomain).called(1);

    expect(highlight.subtitle, highlightDto.subtitle);
    expect(highlight.url, highlightDto.url);
    expect(highlight.title, highlightDto.title);
    expect(highlight.description, highlightDto.description);
    expect(highlight.contentDescription, highlightDto.imageDescription);
  });
}
