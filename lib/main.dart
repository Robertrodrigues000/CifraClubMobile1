// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/di/inherited_widget_dependencies.dart';
import 'package:cifraclub/domain/user/repository/autentication_repository.dart';
import 'package:cifraclub/di/navigator_module.dart';
import 'package:cifraclub/presentation/localizations/supported_locales.dart';
import 'package:cifraclub/presentation/screens/dev/dev_entry.dart';
import 'package:cifraclub/presentation/screens/genres/genres_entry.dart';
import 'package:cifraclub/presentation/screens/home/home_entry.dart';
import 'package:cifraclub/presentation/screens/main/main_entry.dart';
import 'package:cifraclub/presentation/screens/ntp_test/ntp_test_entry.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> initializeCcid() {
  final ccid = getIt<AuthenticationRepository>();
  return ccid.init();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();
  initializeCcid();
  runApp(const CifraClub());
}

class CifraClub extends StatelessWidget {
  static const _navigationRestorationScope = "NavigatorRestorationScope";

  const CifraClub({super.key});

  @override
  Widget build(BuildContext context) {
    return InheritedDependenciesWidget(
      child: MaterialApp(
        restorationScopeId: _navigationRestorationScope,
        darkTheme: getCosmosDarkTheme(BrandColors.asCifra()),
        theme: getCosmosLightTheme(BrandColors.asCifra()),
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
              param1: NavConstructorParams(firstScreen: NtpTestEntry({}), restorationId: 'BottomNav4'),
            ),
            getIt(
              param1: NavConstructorParams(firstScreen: NtpTestEntry({}), restorationId: 'BottomNav5'),
            ),
          ],
        ),
      ),
    );
  }
}
