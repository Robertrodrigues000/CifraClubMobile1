// coverage:ignore-file
import 'dart:io';

import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/di/inherited_widget_dependencies.dart';
import 'package:cifraclub/domain/app/use_cases/deep_link_handler.dart';
import 'package:cifraclub/domain/songbook/use_cases/clear_user_songbooks_on_logout.dart';
import 'package:cifraclub/domain/subscription/use_cases/watch_for_purchases.dart';
import 'package:cifraclub/domain/subscription/use_cases/watch_for_subscriptions.dart';
import 'package:cifraclub/domain/user/repository/authentication_repository.dart';
import 'package:cifraclub/presentation/localizations/supported_locales.dart';
import 'package:cifraclub/presentation/navigator/navigators_controller.dart';
import 'package:cifraclub/presentation/screens/main/main_entry.dart';
import 'package:cifraclub/presentation/style/typography/app_default_typography.dart';
import 'package:cosmos/cosmos.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lehttp_overrides/lehttp_overrides.dart';

Future<void> initializeCcid() {
  final ccid = getIt<AuthenticationRepository>();
  return ccid.init();
}

void initializeWatchForSubscriptions() {
  final watchForSubscriptions = getIt<WatchForSubscriptions>();
  watchForSubscriptions();
}

void initializeWatchForPurchases() {
  final watchForPurchases = getIt<WatchForPurchases>();
  watchForPurchases();
}

void initializeClearUserSongbooksOnLogout() {
  final clearUserSongbooksOnLogout = getIt<ClearUserSongbooksOnLogout>();
  clearUserSongbooksOnLogout();
}

NavigatorsController _getNavigatorsController({String? deepLinkPath}) {
  final navigators = getIt<NavigatorsController>(param1: deepLinkPath);
  return navigators..init();
}

/// Fix SSL certificate problems with Android 7.1.1 and below
Future<void> applyLeHttp() async {
  if (Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt < 26) {
      HttpOverrides.global = LEHttpOverrides();
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();
  await applyLeHttp();
  await initializeCcid();
  initializeWatchForPurchases();
  initializeWatchForSubscriptions();
  initializeClearUserSongbooksOnLogout();
  getIt<DeepLinkHandler>().handleDeepLinks();
  final deepLink = await getIt<DeepLinkHandler>().consumeOrGetFirstDeepLink();
  runApp(CifraClub(
    navigatorsController: _getNavigatorsController(deepLinkPath: deepLink),
  ));
}

class CifraClub extends StatelessWidget {
  static const _navigationRestorationScope = "MainRestorationScope";
  final NavigatorsController navigatorsController;

  const CifraClub({super.key, required this.navigatorsController});

  @override
  Widget build(BuildContext context) {
    return InheritedDependenciesWidget(
      colorApproximator: getIt(),
      osVersion: getIt(),
      child: MaterialApp(
        restorationScopeId: _navigationRestorationScope,
        darkTheme: getCosmosDarkTheme(const BrandColors.asCifra(), extensions: [
          getTypographyScheme(
            getCosmosDarkColorScheme(const BrandColors.asCifra()),
          ),
        ]),
        theme: getCosmosLightTheme(const BrandColors.asCifra(), extensions: [
          getTypographyScheme(
            getCosmosLightColorScheme(const BrandColors.asCifra()),
          ),
        ]),
        supportedLocales: supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: MainEntry(
          navigatorsController: navigatorsController,
        ),
      ),
    );
  }
}
