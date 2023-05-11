import 'package:cifraclub/presentation/screens/songbook/lists/widgets/list_limit_card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When user is free should show increase limit label", (widgetTester) async {
    await widgetTester.pumpWidget(
      TestWrapper(
          child: ListLimitCard(
        listCount: 5,
        limit: 10,
        isPro: false,
        isWithinLimit: true,
        onTap: () {},
      )),
    );

    expect(find.byType(ListLimitCard), findsOneWidget);
    expect(find.byKey(const Key("label")), findsOneWidget);
  });
}
