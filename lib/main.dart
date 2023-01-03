// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/di/inherited_widget_dependencies.dart';
import 'package:cifraclub/presentation/localizations/supported_locales.dart';
import 'package:cifraclub/presentation/screens/dev/dev_entry.dart';
import 'package:cifraclub/presentation/style/app_theme/app_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cifraclub/presentation/style/app_theme/app_light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();
  runApp(const CifraClub());
}

class CifraClub extends StatelessWidget {
  static const _navigationRestorationScope = "NavigatorRestorationScope";

  const CifraClub({super.key});

  @override
  Widget build(BuildContext context) {
    return InheritedDependenciesWidget(
      appNavigator: getIt(),
      child: MaterialApp.router(
        restorationScopeId: _navigationRestorationScope,
        routerDelegate: getIt(),
        routeInformationParser: getIt(param1: DevScreenEntry(const {})),
        darkTheme: appDarkTheme,
        theme: appLightTheme,
        supportedLocales: supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
