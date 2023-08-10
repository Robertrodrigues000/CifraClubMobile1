import 'package:cifraclub/domain/app/models/app.dart';
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
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/user/models/user_mock.dart';
import '../../../shared_mocks/presentation/navigator/nav_mock.dart';
import '../../../test_helpers/app_localizations.dart';
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
    bloc.mockStream(const MoreState(user: null));
    when(bloc.openLoginPage).thenAnswer((_) => SynchronousFuture(null));

    await tester.pumpWidgetWithWrapper(
      BlocProvider<MoreBloc>.value(
        value: bloc,
        child: const MoreScreen(
          moreMenuList: [],
          socialNetworkList: [],
          appList: [],
        ),
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
          child: const MoreScreen(
            moreMenuList: [],
            socialNetworkList: [],
            appList: [],
          ),
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
          child: const MoreScreen(
            moreMenuList: [],
            socialNetworkList: [],
            appList: [],
          ),
        ),
      );

      await tester.tap(
          find.byWidgetPredicate(
            (Widget widget) => widget is SvgImage && widget.assetPath == AppSvgs.logoutIcon,
            description: 'widget with logout icon',
          ),
          warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(find.byType(LogoutDialog), findsOneWidget);

      await tester.tap(find.widgetWithText(CifraClubButton, "Log out"));
      verify(() => bloc.logout()).called(1);
    });
  });

  testWidgets("When menu item with external url is tapped, should open browser", (tester) async {
    bloc.mockStream(const MoreState());
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
    bloc.mockStream(const MoreState());
    final nav = NavMock.getDummy();

    MoreMenuItem item = const MoreMenuItem(
      title: '',
      imageAsset: AppSvgs.academyBottomNavIcon,
      destination: 'aaaaaaaaaa',
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
      nav: nav,
    );

    await tester.tap(find.byType(IconTextTile));
    verify(() => nav.push(screenName: item.destination)).called(1);
  });

  testWidgets("When app is tapped, should open app or store", (tester) async {
    bloc.mockStream(const MoreState());

    AppItem item = AppItem(
      imageAsset: AppWebp.appTuner,
      title: appTextEn.appTuner,
      subtitle: appTextEn.appTunerDescription,
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
    await tester.tap(find.widgetWithText(AppCard, appTextEn.appTuner));
  });

  testWidgets("Should create AppListItem with installed app information", (tester) async {
    AppItem item1 = AppItem(
      imageAsset: AppWebp.appTuner,
      title: appTextEn.appTuner,
      subtitle: appTextEn.appTunerDescription,
      app: App.afinador,
    );

    AppItem item2 = AppItem(
      imageAsset: AppWebp.appMetronome,
      title: appTextEn.appMetronome,
      subtitle: appTextEn.appMetronomeDescription,
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
    bloc.mockStream(const MoreState());

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
    final finder = find.byType(SocialNetworkCard, skipOffstage: false);
    await tester.scrollUntilVisible(finder, 100.0);
    await tester.pump();
    await tester.tap(finder, warnIfMissed: false);
    verify(() => bloc.openUrl(item.url)).called(1);
  });
}
