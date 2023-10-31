import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/presentation/widgets/limit_warning.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helpers/app_localizations.dart';
import '../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When ListLimitState is atWarning, should show atWarning text", (widgetTester) async {
    await widgetTester.pumpWidget(
      const TestWrapper(
        child: Scaffold(
          body: LimitWarning(
            limit: 10,
            isVersionLimit: false,
            count: 7,
            listLimitState: ListLimitState.atWarning,
            proLimit: 100,
            isPro: false,
          ),
        ),
      ),
    );
    expect(find.byType(LimitWarning), findsOneWidget);
    expect(find.text(appTextEn.joinCifraClubPro), findsOneWidget);
  });

  testWidgets("When ListLimitState is reached, should not show separeted text", (widgetTester) async {
    await widgetTester.pumpWidget(
      const TestWrapper(
        child: Scaffold(
          body: LimitWarning(
            limit: 10,
            isVersionLimit: false,
            count: 7,
            listLimitState: ListLimitState.reached,
            proLimit: 100,
            isPro: false,
          ),
        ),
      ),
    );
    expect(find.byType(LimitWarning), findsOneWidget);
    expect(find.text(appTextEn.joinCifraClubPro), findsNothing);
  });

  testWidgets("When ListLimitState is atWarning and is pro should show atWarning pro text", (widgetTester) async {
    await widgetTester.pumpWidget(
      const TestWrapper(
        child: Scaffold(
          body: LimitWarning(
            limit: 10,
            isVersionLimit: false,
            count: 7,
            listLimitState: ListLimitState.atWarning,
            proLimit: 100,
            isPro: true,
          ),
        ),
      ),
    );
    expect(find.byType(LimitWarning), findsOneWidget);
    expect(find.text(appTextEn.listLimitWarningPro), findsOneWidget);
  });

  testWidgets("When ListLimitState is reached and is pro should show reached pro text", (widgetTester) async {
    await widgetTester.pumpWidget(
      const TestWrapper(
        child: Scaffold(
          body: LimitWarning(
            limit: 10,
            isVersionLimit: false,
            count: 7,
            listLimitState: ListLimitState.reached,
            proLimit: 100,
            isPro: true,
          ),
        ),
      ),
    );
    expect(find.byType(LimitWarning), findsOneWidget);
    expect(find.text(appTextEn.listLimitReachedPro), findsOneWidget);
  });
}
