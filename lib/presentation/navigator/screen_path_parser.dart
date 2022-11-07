import 'dart:developer';

import 'package:cifraclub/presentation/navigator/routes.dart';
import 'package:cifraclub/presentation/navigator/screen_entry.dart';

abstract class ScreenPathParser {
  static const pathPrefix = "@";
  static const screensDivider = "/";
  static const queryDivider = "?";
  static const paramDivider = "&";
  static const keyValueDivider = "=";

  ScreenEntry? getScreenFromPathSegment(String segment, [Map<String, String> params = const {}, Object? objectParam]);

  List<ScreenEntry>? parsePath(List<String> urlSegments);

  static ScreenPathParser getDefault(List<ScreenEntryBuilder> appNavigatorRoutes) => _ScreenPathParserImpl(appNavigatorRoutes);
}

class _ScreenPathParserImpl implements ScreenPathParser {
  final List<ScreenEntryBuilder> appNavigatorRoutes;

  const _ScreenPathParserImpl(this.appNavigatorRoutes);

  @override
  List<ScreenEntry>? parsePath(List<String> urlSegments) {
    List<ScreenEntry> screens = [];
    for (final segment in urlSegments) {
      final screen = getScreenFromPathSegment(segment.split(ScreenPathParser.queryDivider).first, _getParams(segment));
      if (screen != null) {
        screens.add(screen);
      }
    }
    return screens.isEmpty ? null : screens;
  }

  @override
  ScreenEntry? getScreenFromPathSegment(String screenName, [Map<String, String> params = const {}, Object? objectParam]) {
    for (final route in appNavigatorRoutes) {
      if (screenName.toLowerCase() == route.screenName.toLowerCase()) {
        return route.builder.call(params, objectParam);
      }
    }
    return null;
  }

  Map<String, String> _getParams(String urlSegment) {
    final startIndex = urlSegment.lastIndexOf(ScreenPathParser.queryDivider) + 1;
    if (startIndex < 1 || urlSegment.length <= startIndex) {
      return {};
    }
    final Map<String, String> paramsMap = {};
    final params = urlSegment.substring(startIndex).split(ScreenPathParser.paramDivider);
    for (final param in params) {
      final paramContainsEqualCharacter = param.contains(ScreenPathParser.keyValueDivider);
      final paramContainsAKey = !param.startsWith(ScreenPathParser.keyValueDivider);
      final paramContainsAValue = !param.endsWith(ScreenPathParser.keyValueDivider);

      debugger(
        when: !paramContainsEqualCharacter || !paramContainsAKey || !paramContainsAValue,
        message: "$param is not a valid param",
      );
      if (paramContainsEqualCharacter && paramContainsAKey && paramContainsAValue) {
        paramsMap[param.substring(0, param.indexOf(ScreenPathParser.keyValueDivider))] = param.substring(param.indexOf(ScreenPathParser.keyValueDivider) + 1);
      }
    }
    return paramsMap;
  }
}
