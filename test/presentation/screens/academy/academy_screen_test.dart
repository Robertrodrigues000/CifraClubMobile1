// ignore_for_file: deprecated_member_use

import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/screens/academy/academy_bloc.dart';
import 'package:cifraclub/presentation/screens/academy/academy_screen.dart';
import 'package:cifraclub/presentation/screens/academy/academy_state.dart';
import 'package:cifraclub/presentation/screens/academy/widgets/academy_screen_phone.dart';
import 'package:cifraclub/presentation/screens/academy/widgets/academy_screen_tablet.dart';
import 'package:cifraclub/presentation/screens/academy/widgets/instructor_card.dart';
import 'package:cifraclub/presentation/screens/academy/widgets/instructors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _AcademyBlocMock extends Mock implements AcademyBloc {}

void main() {
  late AcademyBloc bloc;

  setUpAll(() {
    bloc = _AcademyBlocMock();
    when(bloc.initInstructors).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.openAppOrStore).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("When instructors lists is empty, should show a container", (widgetTester) async {
    binding.window.physicalSizeTestValue = const Size(850, 1000);
    binding.window.devicePixelRatioTestValue = 1.0;

    bloc.mockStream(
      AcademyState(
        isAcademyInstalled: true,
        instructors: [],
      ),
    );

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<AcademyBloc>.value(
          value: bloc,
          child: const AcademyScreen(),
        ),
      ),
    );

    await widgetTester.pump(const Duration(seconds: 1));

    expect(find.byType(AcademyScreenTablet), findsNothing);
    expect(find.byType(AcademyScreenPhone), findsNothing);
    expect(find.byType(Container), findsOneWidget);
  });

  testWidgets("When device is tablet, should show screen for tablet", (widgetTester) async {
    binding.window.physicalSizeTestValue = const Size(850, 1000);
    binding.window.devicePixelRatioTestValue = 1.0;

    bloc.mockStream(
      AcademyState(
        isAcademyInstalled: true,
        instructors: [
          AppWebp.cardViolaoIntermediario,
          AppWebp.cardFingerstyle,
        ],
      ),
    );

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<AcademyBloc>.value(
          value: bloc,
          child: const AcademyScreen(),
        ),
      ),
    );

    await widgetTester.pump(const Duration(seconds: 1));

    expect(find.byType(AcademyScreenTablet), findsOneWidget);
    expect(find.byType(Instructors), findsNWidgets(2));
    expect(find.byType(InstructorCard), findsNWidgets(8));
  });

  testWidgets("When device is phone, should show screen for phone", (widgetTester) async {
    binding.window.physicalSizeTestValue = const Size(460, 800);
    binding.window.devicePixelRatioTestValue = 1.0;

    bloc.mockStream(
      AcademyState(
        isAcademyInstalled: true,
        instructors: [
          AppWebp.cardViolaoIntermediario,
          AppWebp.cardFingerstyle,
        ],
      ),
    );

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<AcademyBloc>.value(
          value: bloc,
          child: const AcademyScreen(),
        ),
      ),
    );

    await widgetTester.pump(const Duration(seconds: 1));

    expect(find.byType(AcademyScreenPhone), findsOneWidget);
    expect(find.byType(Instructors), findsOneWidget);
    expect(find.byType(InstructorCard), findsNWidgets(4));
  });

  testWidgets("When device is small, should show screen for phone with small dimensions", (widgetTester) async {
    binding.window.physicalSizeTestValue = const Size(320, 533);
    binding.window.devicePixelRatioTestValue = 1.0;

    bloc.mockStream(
      AcademyState(
        isAcademyInstalled: true,
        instructors: [
          AppWebp.cardViolaoIntermediario,
          AppWebp.cardFingerstyle,
        ],
      ),
    );

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<AcademyBloc>.value(
          value: bloc,
          child: const AcademyScreen(),
        ),
      ),
    );

    await widgetTester.pump(const Duration(seconds: 1));

    expect(find.byType(AcademyScreenPhone), findsOneWidget);
    expect(find.byType(Instructors), findsOneWidget);
    expect(find.byType(InstructorCard), findsNWidgets(4));
  });
}
