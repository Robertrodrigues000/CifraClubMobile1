import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/screens/more/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/test_wrapper.dart';

void main() {
  group("when AppListItem is called,", () {
    testWidgets("when widget is tapped, should call onTap callback", (tester) async {
      var isTapped = false;

      await tester.pumpWidget(
        TestWrapper(
          child: AppCard(
            appName: "name",
            appDescription: "description",
            isInstalled: false,
            logo: AppWebp.bassBadge,
            onTap: () => isTapped = true,
          ),
        ),
      );

      await tester.tap(find.byType(AppCard));
      expect(isTapped, true);
    });

    testWidgets("should show title and subtitle", (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: AppCard(
            appName: "name",
            appDescription: "description",
            logo: AppWebp.bassBadge,
            isInstalled: false,
            onTap: () {},
          ),
        ),
      );

      expect(find.text("name"), findsOneWidget);
      expect(find.text("description"), findsOneWidget);
    });

    testWidgets("should show download icon if app is not installed", (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: AppCard(
            appName: "name",
            appDescription: "description",
            logo: AppWebp.bassBadge,
            isInstalled: false,
            onTap: () {},
          ),
        ),
      );

      expect(
          find.byWidgetPredicate(
            (Widget widget) {
              return widget is SvgPicture &&
                  widget.pictureProvider is ExactAssetPicture &&
                  (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.downloadIcon;
            },
            description: 'widget with download icon',
          ),
          findsOneWidget);
    });

    testWidgets("should show open icon if app is installed", (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: AppCard(
            appName: "name",
            appDescription: "description",
            logo: AppWebp.bassBadge,
            isInstalled: true,
            onTap: () {},
          ),
        ),
      );

      expect(
          find.byWidgetPredicate(
            (Widget widget) {
              return widget is SvgPicture &&
                  widget.pictureProvider is ExactAssetPicture &&
                  (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.openAppIcon;
            },
            description: 'widget with open icon',
          ),
          findsOneWidget);
    });
  });
}
