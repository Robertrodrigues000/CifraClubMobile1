import 'package:cifraclub/domain/user/models/user.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/screens/home/home_bloc.dart';
import 'package:cifraclub/presentation/screens/home/home_screen.dart';
import 'package:cifraclub/presentation/screens/home/home_state/home_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _HomeBlocMock extends Mock implements HomeBloc {}

void main() {
  late HomeBloc bloc;

  setUpAll(() {
    bloc = _HomeBlocMock();
    when(bloc.requestHomeData).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.initGenres).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When user is not logged shoud show Log in option", (widgetTester) async {
    bloc.mockStream(const HomeState(user: null, isPro: false));

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

  testWidgets("when user is pro should show cifra club pro logo", (widgetTester) async {
    bloc.mockStream(const HomeState(user: User(), isPro: true));

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

  testWidgets("When state isLoading is true then loading should be displayed", (widgetTester) async {
    bloc.mockStream(const HomeState(selectedGenre: "", genres: [], isLoading: true));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<HomeBloc>.value(
          value: bloc,
          child: const HomeScreen(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
