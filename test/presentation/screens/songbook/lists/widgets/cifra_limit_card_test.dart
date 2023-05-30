import 'package:cifraclub/presentation/screens/songbook/lists/widgets/cifra_limit_card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When user is not pro should show increase limit", (widgetTester) async {
    await widgetTester.pumpWidget(
      TestWrapper(
          child: CifraLimitCard(
        tabsCount: 5,
        limit: 10,
        isPro: false,
        isWithinLimit: true,
        onTap: () {},
      )),
    );

    expect(find.byType(CifraLimitCard), findsOneWidget);
    expect(find.byKey(const Key("label")), findsOneWidget);
  });
}
