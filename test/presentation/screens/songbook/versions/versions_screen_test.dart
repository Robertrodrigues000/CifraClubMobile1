import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_state.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/versions_collapsed_header.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/versions_fixed_header.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_screen_builder.dart';
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

class _VersionsBlocMock extends Mock implements VersionsBloc {}

class _EditListScreenBuilderMock extends Mock implements EditListScreenBuilder {}

void main() {
  late VersionsBloc bloc;
  final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    bloc = _VersionsBlocMock();
    when(() => bloc.getSongbook(any())).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets('When start should load screen correctly', (widgetTester) async {
    bloc.mockStream(const VersionsState(isPublic: true));
    final songbook = getFakeSongbook();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          isTablet: true,
          songbook: songbook,
          editListScreenBuilder: _EditListScreenBuilderMock(),
        ),
      ),
    );

    expect(find.byType(VersionsCollapsedHeader), findsOneWidget);
    expect(find.byType(VersionsFixedHeader), findsOneWidget);
  });

  testWidgets('When is phone as click to back should call pop', (widgetTester) async {
    // ignore: deprecated_member_use
    binding.window.physicalSizeTestValue = const Size(460, 800);
    // ignore: deprecated_member_use
    binding.window.devicePixelRatioTestValue = 1.0;
    bloc.mockStream(const VersionsState(isPublic: true));

    final songbook = getFakeSongbook();
    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsBloc>.value(
        value: bloc,
        child: VersionsScreen(
          isTablet: false,
          songbook: songbook,
          editListScreenBuilder: _EditListScreenBuilderMock(),
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
