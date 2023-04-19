import 'package:cifraclub/domain/app/model/app.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/dialogs/logout_dialog.dart';
import 'package:cifraclub/presentation/screens/more/models/app_item.dart';
import 'package:cifraclub/presentation/screens/more/models/more_menu_item.dart';
import 'package:cifraclub/presentation/screens/more/models/social_network.dart';
import 'package:cifraclub/presentation/screens/more/more_bloc.dart';
import 'package:cifraclub/presentation/screens/more/more_screen.dart';
import 'package:cifraclub/presentation/screens/more/more_state.dart';
import 'package:cifraclub/presentation/screens/more/widgets/app_card.dart';
import 'package:cifraclub/presentation/screens/more/widgets/social_network_card.dart';
import 'package:cifraclub/presentation/widgets/user_card.dart';
import 'package:cifraclub/presentation/widgets/buttons/cifra_button.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/user/models/user_mock.dart';
import '../../../shared_mocks/presentation/navigator/nav_mock.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _MoreBlocMock extends Mock implements MoreBloc {}

void main() {
  late MoreBloc bloc;

  setUpAll(() {
    bloc = _MoreBlocMock();
    when(() => bloc.init(any())).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When user is logged out, should open login when tapping user card", (tester) async {
    bloc.mockStream(MoreState(user: null));
    when(bloc.openLoginPage).thenAnswer((_) => SynchronousFuture(null));

    await tester.pumpWidgetWithWrapper(
      BlocProvider<MoreBloc>.value(
        value: bloc,
        child: const MoreScreen(moreMenuList: [], socialNetworkList: [], appList: []),
      ),
    );

    await tester.tap(find.byType(UserCard));
    verify(() => bloc.openLoginPage()).called(1);
  });

  group("When user is logged in", () {
    testWidgets("should open edit profile when tapping user card", (tester) async {
      bloc.mockStream(MoreState(user: getFakeUser()));
      when(bloc.openUserProfilePage).thenAnswer((_) => SynchronousFuture(null));

      await tester.pumpWidgetWithWrapper(
        BlocProvider<MoreBloc>.value(
          value: bloc,
          child: const MoreScreen(moreMenuList: [], socialNetworkList: [], appList: []),
        ),
      );

      await tester.tap(find.byType(UserCard));
      verify(() => bloc.openUserProfilePage()).called(1);
    });

    testWidgets("should open dialog when tapping logout button", (tester) async {
      bloc.mockStream(MoreState(user: getFakeUser()));
      when(bloc.logout).thenAnswer((_) => SynchronousFuture(null));

      await tester.pumpWidgetWithWrapper(
        BlocProvider<MoreBloc>.value(
          value: bloc,
          child: const MoreScreen(moreMenuList: [], socialNetworkList: [], appList: []),
        ),
      );

      await tester.tap(find.byWidgetPredicate(
        (Widget widget) => widget is SvgImage && widget.assetPath == AppSvgs.logoutIcon,
        description: 'widget with logout icon',
      ));
      await tester.pumpAndSettle();
      expect(find.byType(LogoutDialog), findsOneWidget);

      await tester.tap(find.widgetWithText(CifraButton, "Log out"));
      verify(() => bloc.logout()).called(1);
    });
  });

  testWidgets("When menu item with external url is tapped, should open browser", (tester) async {
    bloc.mockStream(MoreState());
    when(() => bloc.openUrl(any())).thenAnswer((_) => SynchronousFuture(null));
    MoreMenuItem item = const MoreMenuItem(
      title: '',
      imageAsset: AppSvgs.academyBottomNavIcon,
      destination: 'http://aaaaaaaaaa.com/',
    );
    await tester.pumpWidgetWithWrapper(
      BlocProvider<MoreBloc>.value(
        value: bloc,
        child: MoreScreen(
          moreMenuList: [item],
          socialNetworkList: const [],
          appList: const [],
        ),
      ),
    );

    await tester.tap(find.byType(IconTextTile));
    verify(() => bloc.openUrl(item.destination)).called(1);
  });

  testWidgets("When menu item with internal route is tapped, should push to a new screen", (tester) async {
    bloc.mockStream(MoreState());
    final nav = NavMock.getDummy();

    MoreMenuItem item = const MoreMenuItem(
      title: '',
      imageAsset: AppSvgs.academyBottomNavIcon,
      destination: 'aaaaaaaaaa',
    );
    await tester.pumpWidgetWithWrapper(
      BlocProvider<MoreBloc>.value(
        value: bloc,
        child: MoreScreen(moreMenuList: [item], socialNetworkList: const [], appList: const []),
      ),
      nav: nav,
    );

    await tester.tap(find.byType(IconTextTile));
    verify(() => nav.push(screenName: item.destination)).called(1);
  });

  testWidgets("When app is tapped, should open app or store", (tester) async {
    bloc.mockStream(MoreState());

    AppItem item = const AppItem(
      imageAsset: AppWebp.appTuner,
      title: 'legal',
      subtitle: 'olha só',
      app: App.afinador,
    );
    when(() => bloc.openAppOrStore(item.app)).thenAnswer((_) => SynchronousFuture(null));

    await tester.pumpWidgetWithWrapper(
      BlocProvider<MoreBloc>.value(
        value: bloc,
        child: MoreScreen(
          moreMenuList: const [],
          socialNetworkList: const [],
          appList: [item],
        ),
      ),
    );
    await tester.tap(find.byType(AppCard));
  });

  testWidgets("Should create AppListItem with installed app information", (tester) async {
    AppItem item1 = const AppItem(
      imageAsset: AppWebp.appTuner,
      title: 'legal',
      subtitle: 'olha só',
      app: App.afinador,
    );
    AppItem item2 = const AppItem(
      imageAsset: AppWebp.appMetronome,
      title: 'legal',
      subtitle: 'olha só',
      app: App.metronomo,
    );

    bloc.mockStream(MoreState(installedApps: [item1]));

    await tester.pumpWidgetWithWrapper(
      BlocProvider<MoreBloc>.value(
        value: bloc,
        child: MoreScreen(
          moreMenuList: const [],
          socialNetworkList: const [],
          appList: [item1, item2],
        ),
      ),
    );

    expect(
      find.byWidgetPredicate((Widget widget) => widget is AppCard && widget.isInstalled),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate((Widget widget) => widget is AppCard && !widget.isInstalled),
      findsOneWidget,
    );
  });

  testWidgets("When social network item is tapped, should open the social network", (tester) async {
    bloc.mockStream(MoreState());

    SocialNetwork item = SocialNetwork(
      socialNetworkName: 'olha só',
      username: '@qlegal',
      imageAsset: AppWebp.socialYoutube,
      url: 'https://google.com',
    );

    when(() => bloc.openUrl(item.url)).thenAnswer((_) => SynchronousFuture(null));

    await tester.pumpWidgetWithWrapper(
      BlocProvider<MoreBloc>.value(
        value: bloc,
        child: MoreScreen(
          moreMenuList: const [],
          socialNetworkList: [item],
          appList: const [],
        ),
      ),
    );
    await tester.tap(find.byType(SocialNetworkCard));
    verify(() => bloc.openUrl(item.url)).called(1);
  });
}
