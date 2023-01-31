import 'package:injectable/injectable.dart';
import 'package:cifraclub/presentation/navigator/deep_link_parser.dart';
import 'package:cifraclub/presentation/navigator/routes.dart';
import 'package:nav/nav.dart';

// coverage:ignore-file
@module
abstract class NavigatorModule {
  DeepLinkParser getDeepLinkParser() => DeepLinkParser.getDefault();

  Nav getMainScreenNavigator(
    @factoryParam NavConstructorParams navConstructorParams,
    DeepLinkParser deepLinkParser,
  ) {
    return Nav(
      firstScreen: navConstructorParams.firstScreen,
      initialRoute: [],
      restorationId: navConstructorParams.restorationId,
      routes: routes,
    );
  }
}

class NavConstructorParams {
  final String restorationId;
  final ScreenEntry firstScreen;
  final String? deepLinkPath;

  const NavConstructorParams({
    required this.restorationId,
    required this.firstScreen,
    this.deepLinkPath,
  });
}
