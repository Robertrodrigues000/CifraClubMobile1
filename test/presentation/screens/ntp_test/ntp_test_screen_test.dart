import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/presentation/screens/ntp_test/ntp_test_bloc.dart';
import 'package:cifraclub/presentation/screens/ntp_test/ntp_test_screen.dart';
import 'package:cifraclub/presentation/screens/ntp_test/ntp_test_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/appLocalizations.dart';
import '../../../test_helpers/test_wrapper.dart';

class _BlocMock extends MockCubit<NtpTestState> implements NtpTestBloc {}

void main() {
  group("When screen is on `NtpTestInitialState`", () {
    testWidgets("When screen is on `NtpTestInitialState` ", (widgetTester) async {
      final bloc = _BlocMock();

      whenListen(bloc, const Stream<NtpTestState>.empty(), initialState: NtpTestInitialState());

      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<NtpTestBloc>.value(
            value: bloc,
            child: const NtpTestScreen(color: Colors.black),
          ),
        ),
      );

      expect(find.text(appTextEn.pressTheButtonToGetTheCurrentTime), findsOneWidget);
    });
  });

  group("When ${appTextEn.getIt} button is pressed, invoke `requireCurrentTime` function", () {
    testWidgets("When screen is on `NtpTestInitialState` ", (widgetTester) async {
      final bloc = _BlocMock();
      when(bloc.requireCurrentTime).thenAnswer((invocation) => SynchronousFuture(null));
      whenListen(bloc, const Stream<NtpTestState>.empty(), initialState: NtpTestInitialState());

      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<NtpTestBloc>.value(
            value: bloc,
            child: const NtpTestScreen(color: Colors.black),
          ),
        ),
      );

      await widgetTester.tap(find.text(appTextEn.getIt));

      verify(bloc.requireCurrentTime).called(1);
    });
  });
}
