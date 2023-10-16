import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/version_tile.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/songbook_information_section.dart';
import 'package:cifraclub/presentation/screens/songbook/versions_shared/versions_shared_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/versions_shared/versions_shared_fixed_header.dart';
import 'package:cifraclub/presentation/screens/songbook/versions_shared/versions_shared_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/versions_shared/versions_shared_state.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../shared_mocks/domain/songbook/models/songbook_mock.dart';
import '../../../../shared_mocks/domain/version/models/version_mock.dart';
import '../../../../shared_mocks/presentation/navigator/nav_mock.dart';
import '../../../../test_helpers/bloc_stream.dart';
import '../../../../test_helpers/test_wrapper.dart';

class _VersionsSharedBlocMock extends Mock implements VersionsSharedBloc {}

void main() {
  late VersionsSharedBloc bloc;

  setUpAll(() {
    registerFallbackValue(getFakeSongbook());
    registerFallbackValue(getFakeVersion());

    bloc = _VersionsSharedBlocMock();
    when(() => bloc.init(any())).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.shareLink(any(), any())).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.getPreview()).thenReturn([]);
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets('When start should load screen correctly', (widgetTester) async {
    bloc.mockStream(
        VersionsSharedState(versions: [getFakeVersion(), getFakeVersion()], songbook: getFakeSongbook(isPublic: true)));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsSharedBloc>.value(
        value: bloc,
        child: const VersionsSharedScreen(
          songbookId: 1,
        ),
      ),
    );

    expect(find.byType(CosmosSearchBar), findsNothing);
    expect(find.byType(SongbookInformationSection), findsOneWidget);
    expect(find.byType(VersionsSharedFixedHeader), findsOneWidget);
    expect(find.byType(VersionTile, skipOffstage: false), findsNWidgets(2));
  });

  testWidgets('When start and songbook is private should not show share icon should omit the share icon',
      (widgetTester) async {
    bloc.mockStream(VersionsSharedState(
        versions: [getFakeVersion(), getFakeVersion()], songbook: getFakeSongbook(isPublic: false)));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsSharedBloc>.value(
        value: bloc,
        child: const VersionsSharedScreen(
          userId: 1,
          songbookId: 1,
        ),
      ),
    );

    final finder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SvgPicture &&
          widget.pictureProvider is ExactAssetPicture &&
          (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.shareIcon,
      description: 'share icon',
    );

    expect(finder, findsNothing);
  });

  testWidgets('When start and is not user list type should omit the share icon', (widgetTester) async {
    bloc.mockStream(VersionsSharedState(
        versions: [getFakeVersion(), getFakeVersion()],
        songbook: getFakeSongbook(listType: ListType.favorites, isPublic: true)));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsSharedBloc>.value(
        value: bloc,
        child: const VersionsSharedScreen(
          userId: 1,
          songbookId: 1,
        ),
      ),
    );

    final finder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SvgPicture &&
          widget.pictureProvider is ExactAssetPicture &&
          (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.shareIcon,
      description: 'share icon',
    );

    expect(finder, findsNothing);
  });

  testWidgets('When is phone as click to back should call pop', (widgetTester) async {
    widgetTester.view.physicalSize = const Size(460, 800);
    widgetTester.view.devicePixelRatio = 1.0;
    bloc.mockStream(VersionsSharedState(songbook: getFakeSongbook(isPublic: true)));

    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsSharedBloc>.value(
        value: bloc,
        child: const VersionsSharedScreen(
          songbookId: 1,
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

    await widgetTester.tap(finder, warnIfMissed: false);
    await widgetTester.pumpAndSettle();

    verify(nav.pop).called(1);
  });

  testWidgets('When click in share should call lib', (widgetTester) async {
    widgetTester.view.physicalSize = const Size(460, 800);
    widgetTester.view.devicePixelRatio = 1.0;
    bloc.mockStream(VersionsSharedState(songbook: getFakeSongbook(isPublic: true)));

    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsSharedBloc>.value(
        value: bloc,
        child: const VersionsSharedScreen(
          songbookId: 1,
          userId: 1,
        ),
      ),
      nav: nav,
    );

    final finder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SvgPicture &&
          widget.pictureProvider is ExactAssetPicture &&
          (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.shareIcon,
      description: 'share icon',
    );
    expect(finder, findsOneWidget);

    await widgetTester.tap(finder, warnIfMissed: false);

    verify(() => bloc.shareLink(any(), any())).called(1);
  });

  testWidgets('When state has error should show error widget', (widgetTester) async {
    bloc.mockStream(VersionsSharedState(error: ServerError()));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<VersionsSharedBloc>.value(
        value: bloc,
        child: const VersionsSharedScreen(
          songbookId: 1,
        ),
      ),
    );

    expect(find.byType(ErrorDescriptionWidget, skipOffstage: false), findsOneWidget);
  });
}
