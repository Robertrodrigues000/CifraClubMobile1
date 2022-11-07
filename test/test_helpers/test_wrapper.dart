import 'package:cifraclub/di/inherited_widget_dependencies.dart';
import 'package:cifraclub/presentation/localizations/supported_locales.dart';
import 'package:cifraclub/presentation/navigator/app_navigator.dart';
import 'package:cifraclub/presentation/themes/cifraclub_dark_theme.dart';
import 'package:cifraclub/presentation/themes/cifraclub_light_theme.dart';
import 'package:cifraclub/presentation/themes/text_theme/cifraclub_dark_text_theme.dart';
import 'package:cifraclub/presentation/themes/text_theme/cifraclub_light_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../shared_mocks/presentation/navigator/app_navigator_mock.dart';

class TestWrapper extends StatelessWidget {
  final Widget child;
  final AppNavigator? appNavigator;

  const TestWrapper({Key? key, required this.child, this.appNavigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InheritedDependenciesWidget(
      appNavigator: appNavigator ?? AppNavigatorMock.getDummy(),
      child: MaterialApp(
        home: child,
        supportedLocales: supportedLocales,
        darkTheme: cifraClubDarkTheme.copyWith(extensions: [cifraDarkClubTextStyle]),
        theme: cifraClubLightTheme.copyWith(extensions: [cifraClubLightTextStyle]),
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
