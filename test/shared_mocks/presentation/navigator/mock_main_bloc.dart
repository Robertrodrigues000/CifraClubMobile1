import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/presentation/screens/main/bottom_navigation_item.dart';
import 'package:cifraclub/presentation/screens/main/main_bloc.dart';
import 'package:cifraclub/presentation/screens/main/main_state.dart';

import 'nav_mock.dart';

class MockMainBloc extends MockCubit<MainState> implements MainBloc {
  MockMainBloc();

  MockMainBloc.dummy({Stream<MainState>? statesStream}) {
    whenListen<MainState>(
      this,
      statesStream ?? Stream.fromIterable([]),
      initialState: MainState(bottomNavigationNavs: [NavMock.getDummy()], selectedPage: BottomNavigationItem.search),
    );
  }
}
