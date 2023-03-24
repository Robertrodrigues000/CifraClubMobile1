import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/more/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../shared_mocks/domain/user/models/user_mock.dart';
import '../../../../test_helpers/app_localizations.dart';
import '../../../../test_helpers/test_wrapper.dart';

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
              (Widget widget) =>
                  widget is ImageIcon && widget.image is Svg && (widget.image as Svg).path == AppSvgs.logoutIcon,
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
          (Widget widget) =>
              widget is ImageIcon && widget.image is Svg && (widget.image as Svg).path == AppSvgs.logoutIcon,
          description: 'widget with logout icon',
        );

        expect(logoutFinder, findsOneWidget);
        await tester.tap(logoutFinder);
        expect(isLogoutTapped, true);
      });
    });
  });
}
