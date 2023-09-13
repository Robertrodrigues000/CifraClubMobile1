import 'package:cifraclub/data/home/models/highlight/highlight_dto.dart';
import 'package:cifraclub/data/home/models/highlight/highlights_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../shared_mocks/domain/home/models/highlight_mock.dart';

class _HighlightDtoMock extends Mock implements HighlightDto {}

void main() {
  test("when `toDomain` is called, should correctly convert to Highlight list", () {
    final highlightDto = _HighlightDtoMock();
    final highlight = getFakeHighlight();
    when(highlightDto.toDomain).thenReturn(highlight);

    final highlightsDto = HighlightsDto(highlights: [highlightDto]);

    final highlights = highlightsDto.toDomain();

    verify(highlightDto.toDomain).called(1);

    expect(highlights?.length, 1);
    expect(highlights?.first, highlight);
  });
}
