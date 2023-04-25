import 'package:cifraclub/presentation/screens/main/bottom_navigation_item.dart';
import 'package:nav/nav.dart';

class MainState {
  final List<Nav> bottomNavigationNavs;
  final BottomNavigationItem selectedPage;

  const MainState({
    required this.bottomNavigationNavs,
    required this.selectedPage,
  });
}
