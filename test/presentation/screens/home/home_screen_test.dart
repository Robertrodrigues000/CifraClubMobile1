import 'package:cifraclub/domain/user/models/user.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/screens/home/home_bloc.dart';
import 'package:cifraclub/presentation/screens/home/home_screen.dart';
import 'package:cifraclub/presentation/screens/home/home_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _MockHomeBloc extends Mock implements HomeBloc {}

void main() {
  late HomeBloc bloc;

  setUpAll(() {
    bloc = _MockHomeBloc();
    when(bloc.requestHomeData).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When state is HomeInitialState, user is not logged", (widgetTester) async {
    bloc.mockStream(HomeInitialState(user: null, isPro: false));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<HomeBloc>.value(
          value: bloc,
          child: const HomeScreen(),
        ),
      ),
    );

    expect(find.text("Log in"), findsOneWidget);
    expect(find.image(const AssetImage(AppWebp.logoCifraClub)), findsOneWidget);
  });

  testWidgets("When state is HomeInitialState and user is pro", (widgetTester) async {
    bloc.mockStream(HomeInitialState(user: const User(), isPro: true));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<HomeBloc>.value(
          value: bloc,
          child: const HomeScreen(),
        ),
      ),
    );

    expect(find.image(const AssetImage(AppWebp.logoCifraClubPro)), findsOneWidget);
  });
}
