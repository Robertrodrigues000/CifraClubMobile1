import 'dart:async';

import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/user_card.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../shared_mocks/domain/user/models/user_mock.dart';
import '../../test_helpers/app_localizations.dart';
import '../../test_helpers/test_wrapper.dart';

void main() {
  group("when UserCard is called", () {
    group("and User is null", () {
      testWidgets("should show sign in text", (tester) async {
        await tester.pumpWidget(
          TestWrapper(
            child: UserCard(
              onLogoutTap: () {},
              onTap: () {},
            ),
          ),
        );
        expect(find.text(appTextEn.login), findsAtLeastNWidgets(1));
      });

      testWidgets("should not show logout icon", (tester) async {
        await tester.pumpWidget(
          TestWrapper(
            child: UserCard(
              onLogoutTap: () {},
              onTap: () {},
            ),
          ),
        );

        expect(
            find.byWidgetPredicate(
              (Widget widget) => widget is SvgImage && widget.assetPath == AppSvgs.logoutIcon,
              description: 'widget with logout icon',
            ),
            findsNothing);
      });
    });

    group("when User is not null", () {
      final user = getFakeUser();

      testWidgets("should show user name and email", (tester) async {
        await tester.pumpWidget(
          TestWrapper(
            child: UserCard(
              user: user,
              onLogoutTap: () {},
              onTap: () {},
            ),
          ),
        );

        expect(find.text(user.name!), findsOneWidget);
        expect(find.text(user.email!), findsOneWidget);
      });

      testWidgets("should show logout icon with tap callback", (tester) async {
        var isLogoutTapped = false;

        await tester.pumpWidget(
          TestWrapper(
            child: UserCard(
              user: user,
              onLogoutTap: () => isLogoutTapped = true,
              onTap: () {},
            ),
          ),
        );

        final logoutFinder = find.byWidgetPredicate(
          (Widget widget) => widget is SvgImage && widget.assetPath == AppSvgs.logoutIcon,
          description: 'widget with logout icon',
        );

        expect(logoutFinder, findsOneWidget);
        await tester.tap(logoutFinder, warnIfMissed: false);
        expect(isLogoutTapped, true);
      });

      testWidgets("should execute click in sync button", (widgetTester) async {
        final completer = Completer();

        await mockNetworkImagesFor(() async {
          await widgetTester.pumpWidget(
            TestWrapper(
              child: UserCard(
                user: user,
                onLogoutTap: () {},
                onTap: () {},
                onSync: completer.complete,
              ),
            ),
          );
        });

        await widgetTester.pumpAndSettle();

        final logoutFinder = find.byWidgetPredicate(
          (Widget widget) => widget is SvgImage && widget.assetPath == AppSvgs.refreshIcon,
        );

        expect(logoutFinder, findsOneWidget);
        await widgetTester.tap(logoutFinder, warnIfMissed: false);

        expect(completer.isCompleted, isTrue);
      });
    });
  });
}
