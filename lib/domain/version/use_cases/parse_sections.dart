import 'package:cifraclub/domain/version/models/section.dart';
import 'package:injectable/injectable.dart';

@injectable
class ParseSections {
  List<Section> call(String content) {
    return content.split("\n").map(Section.new).toList(growable: false);
  }
}
