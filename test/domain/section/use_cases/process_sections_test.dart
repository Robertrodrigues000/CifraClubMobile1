import 'package:cifraclub/domain/section/models/section.dart';
import 'package:cifraclub/domain/section/use_cases/process_sections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _SectionMock extends Mock implements Section {}

void main() {
  group('when use case is called,', () {
    test('should update offset and break lines', () {
      final section = _SectionMock();
      when(() => section.updateOffset(any())).thenReturn(null);
      when(() => section.processLineBreak(any())).thenReturn(null);

      ProcessSections().call([section], 10);
      verify(() => section.updateOffset(0)).called(1);
      verify(() => section.processLineBreak(10)).called(1);
    });
  });
}
