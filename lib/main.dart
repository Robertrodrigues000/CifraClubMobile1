// coverage:ignore-file
import 'dart:io';

import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/di/inherited_widget_dependencies.dart';
import 'package:cifraclub/di/navigator_module.dart';
import 'package:cifraclub/domain/user/repository/autentication_repository.dart';
import 'package:cifraclub/presentation/localizations/supported_locales.dart';
import 'package:cifraclub/presentation/screens/academy/academy_entry.dart';
import 'package:cifraclub/presentation/screens/dev/dev_entry.dart';
import 'package:cifraclub/presentation/screens/genres/genres_entry.dart';
import 'package:cifraclub/presentation/screens/home/home_entry.dart';
import 'package:cifraclub/presentation/screens/main/main_entry.dart';
import 'package:cifraclub/presentation/screens/more/more_entry.dart';
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
  initializeCcid();

  runApp(const CifraClub());
}

class CifraClub extends StatelessWidget {
  static const _navigationRestorationScope = "NavigatorRestorationScope";

  const CifraClub({super.key});

  @override
  Widget build(BuildContext context) {
    return InheritedDependenciesWidget(
      colorApproximator: getIt(),
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
          bottomNavigationPages: [
            getIt(
              param1: NavConstructorParams(firstScreen: HomeEntry({}), restorationId: 'BottomNav1'),
            ),
            getIt(
              param1: NavConstructorParams(firstScreen: DevScreenEntry({}), restorationId: 'BottomNav2'),
            ),
            getIt(
              param1: NavConstructorParams(firstScreen: GenresEntry({}), restorationId: 'BottomNav3'),
            ),
            getIt(
              param1: NavConstructorParams(firstScreen: AcademyEntry({}), restorationId: 'BottomNav4'),
            ),
            getIt(
              param1: NavConstructorParams(firstScreen: MoreEntry({}), restorationId: 'BottomNav5'),
            ),
          ],
        ),
      ),
    );
  }
}
