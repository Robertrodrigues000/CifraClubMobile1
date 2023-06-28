import 'package:cifraclub/data/home/models/highlight/photo_dto.dart';
import 'package:cifraclub/data/home/models/highlight/photos_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../shared_mocks/domain/home/models/images_size_mock.dart';

class _PhotoDtoMock extends Mock implements PhotoDto {}

void main() {
  test("when `toDomain` is called, should correctly convert to HomeImage", () {
    final photoDto = _PhotoDtoMock();
    final fakeHomeImage = getFakeHomeImage();
    when(photoDto.toDomain).thenReturn(fakeHomeImage);

    final photosDto = PhotosDto(app: photoDto);

    final homeImage = photosDto.toDomain();

    verify(photoDto.toDomain).called(1);

    expect(homeImage, fakeHomeImage);
  });
}
