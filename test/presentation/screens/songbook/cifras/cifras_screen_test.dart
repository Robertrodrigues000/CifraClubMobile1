import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/cifras_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/cifras_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/cifras_state.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/widgets/cifras_collapsed_header.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/widgets/cifras_fixed_header.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../shared_mocks/domain/songbook/models/songbook_mock.dart';
import '../../../../shared_mocks/presentation/navigator/nav_mock.dart';
import '../../../../test_helpers/bloc_stream.dart';
import '../../../../test_helpers/test_wrapper.dart';

class _CifrasBlocMock extends Mock implements CifrasBloc {}

void main() {
  late CifrasBloc bloc;
  final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    bloc = _CifrasBlocMock();
    when(() => bloc.getSongbook(any())).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets('When start should load screen correctly', (widgetTester) async {
    bloc.mockStream(const CifrasState(isPublic: true));
    final songbook = getFakeSongbook();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<CifrasBloc>.value(
        value: bloc,
        child: CifrasScreen(
          isTablet: true,
          songbook: songbook,
        ),
      ),
    );

    expect(find.byType(CifrasCollapsedHeader), findsOneWidget);
    expect(find.byType(CifrasFixedHeader), findsOneWidget);
  });

  testWidgets('When is phone as click to back should call pop', (widgetTester) async {
    // ignore: deprecated_member_use
    binding.window.physicalSizeTestValue = const Size(460, 800);
    // ignore: deprecated_member_use
    binding.window.devicePixelRatioTestValue = 1.0;
    bloc.mockStream(const CifrasState(isPublic: true));

    final songbook = getFakeSongbook();
    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<CifrasBloc>.value(
        value: bloc,
        child: CifrasScreen(
          isTablet: false,
          songbook: songbook,
        ),
      ),
      nav: nav,
    );

    final finder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SvgPicture &&
          widget.pictureProvider is ExactAssetPicture &&
          (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.backArrowIcon,
      description: 'widget with back arrow',
    );
    expect(finder, findsOneWidget);

    await widgetTester.tap(finder);
    await widgetTester.pumpAndSettle();

    verify(nav.pop).called(1);
  });
}
