import 'package:cifraclub/presentation/screens/main/bottom_navigation_item.dart';
import 'package:nav/nav.dart';

abstract class MainState {}

class MainInitialState implements MainState {
  final List<Nav> bottomNavigationNavs;
  final BottomNavigationItem selectedPage;

  const MainInitialState({
    required this.bottomNavigationNavs,
    required this.selectedPage,
  });
}
