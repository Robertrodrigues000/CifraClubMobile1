import 'package:cifraclub/di/inherited_widget_dependencies.dart';
import 'package:cifraclub/presentation/localizations/supported_locales.dart';
import 'package:cifraclub/presentation/style/app_theme/app_dark_theme.dart';
import 'package:cifraclub/presentation/style/app_theme/app_light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nav/nav.dart';

class TestWrapper extends StatelessWidget {
  final Widget child;
  final Nav? nav;

  const TestWrapper({Key? key, required this.child, this.nav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InheritedDependenciesWidget(
      child: MaterialApp(
        home: child,
        supportedLocales: supportedLocales,
        darkTheme: appDarkTheme,
        theme: appLightTheme,
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

extension PumpWithWrapper on WidgetTester {
  Future<void> pumpWidgetWithWrapper(Widget widget,
      {Nav? nav, Duration? duration, EnginePhase phase = EnginePhase.sendSemanticsUpdate}) {
    return pumpWidget(
      TestWrapper(
        nav: nav,
        child: widget,
      ),
      duration,
      phase,
    );
  }
}
