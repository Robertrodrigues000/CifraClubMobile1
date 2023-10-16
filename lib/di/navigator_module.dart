import 'package:cifraclub/presentation/navigator/navigators_controller.dart';
import 'package:cifraclub/presentation/navigator/use_case/set_screen_from_url.dart';
import 'package:cifraclub/presentation/screens/academy/academy_entry.dart';
import 'package:cifraclub/presentation/screens/home/home_entry.dart';
import 'package:cifraclub/presentation/screens/main/bottom_navigation_item.dart';
import 'package:cifraclub/presentation/screens/more/more_entry.dart';
import 'package:cifraclub/presentation/screens/search/search_entry.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_entry.dart';
import 'package:injectable/injectable.dart';
import 'package:cifraclub/presentation/navigator/deep_link_parser.dart';
import 'package:cifraclub/presentation/navigator/routes.dart';
import 'package:nav/nav.dart';

// coverage:ignore-file
@module
abstract class NavigatorModule {
  DeepLinkParser getDeepLinkParser() => DeepLinkParser();

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

  static NavigatorsController? _navigatorsController;

  NavigatorsController getNavigatorsController(
    @factoryParam String? deepLinkPath,
    DeepLinkParser deepLinkParser,
    OnNewScreenSet onNewScreenSet,
  ) {
    final cached = _navigatorsController;
    if (cached != null) {
      return cached;
    }
    final newInstance = NavigatorsController(
      navs: _getBottomNavigationNavs(deepLinkPath, deepLinkParser),
      onNewScreenSet: onNewScreenSet,
      restorableBottomNavigationIndex: RestorableBottomNavigationItem(),
    );
    _navigatorsController = newInstance;
    return newInstance;
  }

  static List<Nav> _getBottomNavigationNavs(
    String? deepLinkPath,
    DeepLinkParser deepLinkParser,
  ) {
    Nav getNav({required String restorationId, required ScreenEntry firstScreen, String? deepLinkPath}) {
      return Nav(
        firstScreen: firstScreen,
        initialRoute: deepLinkPath != null ? deepLinkParser.parseUrl(deepLinkPath) : null,
        restorationId: restorationId,
        routes: routes,
      );
    }

    return [
      getNav(
        firstScreen: HomeEntry({}),
        deepLinkPath: deepLinkPath,
        restorationId: 'BottomNav1',
      ),
      getNav(
        firstScreen: SongbookEntry({}),
        restorationId: 'BottomNav2',
      ),
      getNav(
        firstScreen: const SearchEntry({}),
        restorationId: 'BottomNav3',
      ),
      getNav(
        firstScreen: AcademyEntry({}),
        restorationId: 'BottomNav4',
      ),
      getNav(
        firstScreen: MoreEntry({}),
        restorationId: 'BottomNav5',
      ),
    ];
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
