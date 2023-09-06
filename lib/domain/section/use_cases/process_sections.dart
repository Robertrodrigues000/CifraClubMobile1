import 'package:cifraclub/domain/section/models/section.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProcessSections {
  void call(List<Section> sections, int maxChar) {
    for (var section in sections) {
      section.updateOffset(0);
      section.processLineBreak(maxChar);
    }
  }
}
