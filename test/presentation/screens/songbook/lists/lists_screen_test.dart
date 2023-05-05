import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_state.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:cifraclub/presentation/widgets/user_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../shared_mocks/domain/songbook/models/songbook_mock.dart';
import '../../../../shared_mocks/domain/user/models/user_mock.dart';
import '../../../../test_helpers/bloc_stream.dart';
import '../../../../test_helpers/test_wrapper.dart';

class _ListsBlocMock extends Mock implements ListsBloc {}

void main() {
  late ListsBloc bloc;

  setUpAll(() {
    bloc = _ListsBlocMock();
    when(bloc.init).thenReturn(null);
    when(bloc.openLoginPage).thenReturn(null);
    when(bloc.openUserProfilePage).thenReturn(null);
    when(() => bloc.deleteSongbook(any())).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.logout).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.createNewSongbook(any())).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.initListLimitStreams).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When user is logged out, should open login when tapping user card", (widgetTester) async {
    bloc.mockStream(const ListsState(user: null));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(onTapSongbook: (_) {}),
      ),
    );

    await widgetTester.tap(find.byType(UserCard));
    verify(bloc.openLoginPage).called(1);
  });

  testWidgets("When user is logged in and user card is tapped, should open profile", (widgetTester) async {
    bloc.mockStream(ListsState(user: getFakeUser()));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(onTapSongbook: (_) {}),
      ),
    );

    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.byType(UserCard));
    verify(bloc.openUserProfilePage).called(1);
  });

  testWidgets("When user is logged in and logout button is tapped, should logout user", (widgetTester) async {
    bloc.mockStream(ListsState(user: getFakeUser()));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(onTapSongbook: (_) {}),
      ),
    );

    final logoutFinder = find.byWidgetPredicate(
      (Widget widget) => widget is SvgImage && widget.assetPath == AppSvgs.logoutIcon,
    );
    expect(logoutFinder, findsOneWidget);

    await widgetTester.pumpAndSettle();
    await widgetTester.tap(logoutFinder);

    verify(bloc.logout).called(1);
  });

  testWidgets("Tapping add icon should create a new songbook", (widgetTester) async {
    bloc.mockStream(const ListsState());

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(
          onTapSongbook: (_) {},
        ),
      ),
    );

    final addIconFinder = find.byWidgetPredicate((widget) =>
        widget is SvgPicture &&
        widget.pictureProvider is ExactAssetPicture &&
        (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.addIcon);
    expect(addIconFinder, findsOneWidget);

    await widgetTester.pumpAndSettle();
    await widgetTester.tap(addIconFinder);

    verify(() => bloc.createNewSongbook(any())).called(1);
  });

  testWidgets("Tapping songbook tile should call delete songbook", (widgetTester) async {
    final songbook = getFakeSongbook();
    bloc.mockStream(ListsState(userLists: [getFakeSongbook(), songbook]));

    await widgetTester.pumpWidgetWithWrapper(
      BlocProvider<ListsBloc>.value(
        value: bloc,
        child: ListsScreen(onTapSongbook: (_) {}),
      ),
    );

    final songbookTile = find.text(songbook.name, skipOffstage: false);

    expect(songbookTile, findsOneWidget);
    await widgetTester.scrollUntilVisible(find.text(songbook.name), 100);
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(songbookTile);

    verify(() => bloc.deleteSongbook(songbook.id)).called(1);
  });
}
