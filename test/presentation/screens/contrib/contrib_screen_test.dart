import 'package:cifraclub/presentation/bottom_sheets/contrib_help_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/contrib/contrib_screen.dart';
import 'package:cifraclub/presentation/screens/contrib/contrib_screen_bloc.dart';
import 'package:cifraclub/presentation/screens/contrib/contrib_screen_state.dart';
import 'package:cifraclub/presentation/screens/contrib/widgets/contrib_bottom_rules.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _ContribBlocMock extends Mock implements ContribBloc {}

void main() {
  late ContribBloc bloc;

  setUpAll(() {
    bloc = _ContribBlocMock();
    bloc.mockStream(const ContribState(isLoading: false));
    when(() => bloc.openUrl(any())).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When user tap help bottom and should open bottom sheet", (widgetTester) async {
    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<ContribBloc>.value(
          value: bloc,
          child: const ContribScreen(),
        ),
      ),
    );

    await widgetTester.tap(find.byKey(const Key("Open contrib help")));
    await widgetTester.pump();

    expect(find.byType(ContribHelpBottomSheet), findsOneWidget);
  });

  testWidgets("When contrib rules url is tapped, should open browser", (tester) async {
    when(() => bloc.openUrl(any()))
        .thenAnswer((_) => SynchronousFuture(null));

    await tester.pumpWidgetWithWrapper(
      BlocProvider<ContribBloc>.value(
        value: bloc,
        child: const ContribScreen(),
      ),
    );

    await tester.tap(find.byType(ContribBottomRules));
    verify(() => bloc.openUrl(any())).called(1);
  });
}
