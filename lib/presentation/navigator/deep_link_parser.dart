import 'package:cifraclub/presentation/navigator/screen_entry.dart';
import 'package:cifraclub/presentation/screens/dev/dev_entry.dart';

abstract class DeepLinkParser {
  List<ScreenEntry>? parseUriSegments(List<String> uriSegments);

  static DeepLinkParser getDefault() => _DeepLinkParserImpl();
}

class _DeepLinkParserImpl extends DeepLinkParser {
  /// ⚠️ Create new tests in deep_link_parser_test.dart file for ANY modification in this function
  @override
  List<ScreenEntry>? parseUriSegments(List<String> uriSegments) {
    return [DevScreenEntry({})];
  }
}
