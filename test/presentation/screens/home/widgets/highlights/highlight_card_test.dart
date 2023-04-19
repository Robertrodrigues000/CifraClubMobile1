import 'package:cached_network_image/cached_network_image.dart';
import 'package:cifraclub/domain/home/models/highlight.dart';
import 'package:cifraclub/presentation/screens/home/widgets/highlights/highlight_card.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../shared_mocks/domain/home/models/highlight_mock.dart';
import '../../../../../shared_mocks/domain/home/models/home_image_mock.dart';
import '../../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When highlight have description and icon not empty should show badge in card", (widgetTester) async {
    final highlight = getFakeHighlight();
    await widgetTester.pumpWidget(
      TestWrapper(
        child: HighlightCard(
          internalPadding: 16,
          size: 150,
          borderRadius: 1,
          highlight: highlight,
          imageProvider: const CachedNetworkImageProvider(""),
        ),
      ),
    );

    await widgetTester.pumpAndSettle();

    expect(find.text(highlight.description), findsOneWidget);
  });

  testWidgets("When highlight have description and icon empty should not show the badge", (widgetTester) async {
    final highlight = Highlight(
      url: faker.internet.httpUrl(),
      title: faker.company.position(),
      subtitle: faker.animal.name(),
      icon: "",
      description: "",
      contentDescription: faker.geo.latitude().toStringAsExponential(),
      images: getFakeHomeImage(),
    );

    await widgetTester.pumpWidget(
      TestWrapper(
        child: HighlightCard(
          internalPadding: 16,
          size: 150,
          borderRadius: 1,
          highlight: highlight,
          imageProvider: const CachedNetworkImageProvider(""),
        ),
      ),
    );

    await widgetTester.pumpAndSettle();

    expect(find.text(highlight.description), findsNothing);
  });
}
