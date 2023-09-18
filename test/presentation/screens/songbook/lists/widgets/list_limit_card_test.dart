import 'package:cifraclub/presentation/screens/songbook/lists/widgets/list_limit_card.dart';
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/app_localizations.dart';
import '../../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When user is Pro and list is not empty should not show border", (widgetTester) async {
    await widgetTester.pumpWidget(
      TestWrapper(
        child: ListLimitCard(
          listCount: 5,
          limit: 10,
          isPro: true,
          isWithinLimit: true,
          onTap: () {},
        ),
      ),
    );

    expect(find.byType(ListLimitCard), findsOneWidget);
    expect(find.byWidgetPredicate((Widget widget) => widget is ContainerWithRippleEffect && widget.decoration == null),
        findsOneWidget);
  });

  testWidgets("When user is free and list is not empty should show border", (widgetTester) async {
    await widgetTester.pumpWidget(
      TestWrapper(
        child: ListLimitCard(
          listCount: 5,
          limit: 10,
          isPro: false,
          isWithinLimit: true,
          onTap: () {},
        ),
      ),
    );

    expect(find.byType(ListLimitCard), findsOneWidget);
    expect(find.byWidgetPredicate((Widget widget) => widget is ContainerWithRippleEffect && widget.decoration != null),
        findsOneWidget);
  });

  testWidgets("When listCount is empty should show empty list label", (widgetTester) async {
    await widgetTester.pumpWidget(
      TestWrapper(
        child: ListLimitCard(
          listCount: 0,
          limit: 10,
          isPro: true,
          isWithinLimit: true,
          onTap: () {},
        ),
      ),
    );

    expect(find.byType(ListLimitCard), findsOneWidget);
    expect(find.text(appTextEn.emptyLists), findsOneWidget);
  });

  testWidgets("When user is free and listCount is not empty, should show increase limit label", (widgetTester) async {
    await widgetTester.pumpWidget(
      TestWrapper(
        child: ListLimitCard(
          listCount: 5,
          limit: 10,
          isPro: false,
          isWithinLimit: true,
          onTap: () {},
        ),
      ),
    );

    expect(find.byType(ListLimitCard), findsOneWidget);
    expect(find.text(appTextEn.increaseLimit), findsOneWidget);
  });
}
