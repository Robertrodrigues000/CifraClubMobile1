import 'package:cifraclub/di/inherited_widget_dependencies.dart';
import 'package:cifraclub/presentation/navigator/screen_entry.dart';
import 'package:cifraclub/presentation/navigator/screen_path_parser.dart';
import 'package:flutter/material.dart';

abstract class AppNavigator with ChangeNotifier {
  static AppNavigator of(BuildContext context) {
    return InheritedDependenciesWidget.of(context).appNavigator;
  }

  /// List of screen entries that are currently in the Navigation's stack
  List<ScreenEntry> get screens;

  /// [screenName] will be used by ScreenPathParser to parse the path and generate navigation route.
  ///
  /// [params] will be placed in the path segment of the screen.
  ///
  /// [volatileParam] will NOT be restored when the O.S. tries to recreate the app process
  void push({required String screenName, Map<String, String> params, Object? volatileParam});

  ScreenEntry? pop();

  bool canPop();

  /// Dispose and discard all [screens] and replace them by [navigationEntries]
  void setNewState(List<ScreenEntry> navigationEntries);

  void popUntil(String screenName);

  static AppNavigator getDefaultImplementation(ScreenPathParser screenPathParser) {
    return _AppNavigator(screenPathParser);
  }
}

class _AppNavigator extends ChangeNotifier implements AppNavigator {
  final ScreenPathParser screenPathParser;
  @override
  List<ScreenEntry> screens = [];

  _AppNavigator(this.screenPathParser);

  void _disposeAllEntries() {
    for (final entry in screens) {
      entry.dispose();
    }
  }

  @override
  void push({required String screenName, Map<String, String> params = const {}, Object? volatileParam}) {
    final screen = screenPathParser.getScreenFromPathSegment(screenName, params, volatileParam);
    assert(screen != null, "ScreenPathParser failed to parse '$screenName'. Did you forget to add this screen in presentation/navigator/routes.dart?");
    if (screen != null) {
      screens.add(screen);
      notifyListeners();
    }
  }

  @override
  ScreenEntry? pop() {
    if (!canPop()) {
      return null;
    }
    final item = screens.removeLast();
    item.dispose();
    notifyListeners();
    return item;
  }

  @override
  bool canPop() => screens.length > 1;

  @override
  void setNewState(List<ScreenEntry> navigationEntries) {
    _disposeAllEntries();
    screens = navigationEntries;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposeAllEntries();
    super.dispose();
  }

  @override
  void popUntil(String screenName) {
    if (!canPop()) {
      return;
    }

    var screenIndex = -1;
    for (var i = screens.length - 1; i >= 0; i--) {
      if (screens[i].screenName != screenName) {
        screens[i].dispose();
        continue;
      }
      screenIndex = i;
      break;
    }

    if (screenIndex >= 0) {
      screens.removeRange(screenIndex + 1, screens.length);
      notifyListeners();
    }
  }
}
