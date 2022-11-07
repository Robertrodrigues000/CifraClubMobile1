import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:cifraclub/presentation/navigator/app_navigator.dart';
import 'package:cifraclub/presentation/navigator/app_router_delegate.dart';
import 'package:cifraclub/presentation/navigator/app_router_information_parser.dart';
import 'package:cifraclub/presentation/navigator/deep_link_parser.dart';
import 'package:cifraclub/presentation/navigator/routes.dart';
import 'package:cifraclub/presentation/navigator/screen_entry.dart';
import 'package:cifraclub/presentation/navigator/screen_path_parser.dart';

// coverage:ignore-file
@module
abstract class NavigatorModule {
  @singleton
  AppNavigator getAppNavigator(ScreenPathParser screenPathParser) {
    return AppNavigator.getDefaultImplementation(screenPathParser);
  }

  ScreenPathParser getScreenPathParser() => ScreenPathParser.getDefault(cifraScreenBuilders);

  DeepLinkParser getDeepLinkParser() => DeepLinkParser.getDefault();

  @singleton
  GlobalKey<NavigatorState> getNavigatorStateKey() => GlobalKey<NavigatorState>();

  RouterDelegate<Object> getAppRouterDelegate(AppNavigator appNavigator, GlobalKey<NavigatorState> key) {
    return AppRouterDelegate(appNavigator: appNavigator, navigatorKey: key);
  }

  RouteInformationParser<Object> getAppRouterInformationParser(
    AppNavigator appNavigator,
    ScreenPathParser urlParser,
    DeepLinkParser deepLinkParser,
    @factoryParam ScreenEntry? firstScreen,
  ) {
    assert(firstScreen != null);
    return AppRouterInformationParser(
      deepLinkParser: deepLinkParser,
      screenPathParser: urlParser,
      firstScreen: firstScreen!,
      appNavigator: appNavigator,
    );
  }
}
