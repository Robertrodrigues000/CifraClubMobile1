import 'package:cifraclub/presentation/screens/home/widgets/highlights/highlight_section.dart';
import 'package:cifraclub/presentation/screens/home/widgets/highlights/highlights.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../shared_mocks/domain/home/models/highlight_mock.dart';
import '../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("when highlights list is not empty, should show highlight cards", (widgetTester) async {
    final highlights = [getFakeHighlight(), getFakeHighlight()];
    await widgetTester.pumpWidget(
      TestWrapper(
        child: CustomScrollView(
          slivers: [
            Highlights(
              highlights: highlights,
            )
          ],
        ),
      ),
    );

    await widgetTester.pumpAndSettle();

    expect(find.byType(HighlightSection), findsNWidgets(2));
  });
}
