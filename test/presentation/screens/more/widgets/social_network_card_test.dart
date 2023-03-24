import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/screens/more/widgets/social_network_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/test_wrapper.dart';

void main() {
  group("when SocialNetworkListItem is called,", () {
    testWidgets("when widget is tapped, should call onTap callback", (tester) async {
      var isTapped = false;

      await tester.pumpWidget(
        TestWrapper(
          child: SocialNetworkCard(
            name: "name",
            username: "username",
            logo: AppWebp.socialInstagram,
            onTap: () => isTapped = true,
          ),
        ),
      );

      await tester.tap(find.byType(SocialNetworkCard));
      expect(isTapped, true);
    });

    testWidgets("should show name, username and logo", (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: SocialNetworkCard(
            name: "name",
            username: "username",
            logo: AppWebp.socialInstagram,
            onTap: () {},
          ),
        ),
      );

      expect(find.text("name"), findsOneWidget);
      expect(find.text("username"), findsOneWidget);
      expect(find.image(const AssetImage(AppWebp.socialInstagram)), findsOneWidget);
    });
  });
}
