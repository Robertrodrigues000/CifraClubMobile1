import 'package:cifraclub/presentation/navigator/app_navigator.dart';
import 'package:cifraclub/presentation/navigator/page_builder.dart';
import 'package:flutter/widgets.dart';

class AppRouterDelegate extends RouterDelegate<AppNavigator> with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final AppNavigator appNavigator;

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouterDelegate({
    required this.appNavigator,
    required this.navigatorKey,
  }) : super() {
    appNavigator.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    int screenIndex = 0;
    return Navigator(
      key: navigatorKey,
      pages: appNavigator.screens.map((e) {
        return PageBuilder(screenEntry: e, key: ValueKey("${screenIndex++}:${e.key.value ?? ""}"));
      }).toList(growable: false),
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        appNavigator.pop();
        return true;
      },
    );
  }

  @override
  AppNavigator get currentConfiguration => appNavigator;

  @override
  Future<void> setNewRoutePath(AppNavigator configuration) async {
    appNavigator.setNewState(configuration.screens);
  }

  @override
  void dispose() {
    appNavigator.removeListener(notifyListeners);
    super.dispose();
  }
}
