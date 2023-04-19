import 'dart:async';

import 'package:cifraclub/domain/user/models/user.dart';
import 'package:cifraclub/presentation/screens/home/widgets/profile_bottom_sheet/profile_bottom_sheet.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When open bottom sheet should show correctly user info", (widgetTester) async {
    const email = "test@gmail.com";
    const name = "Teste";

    await widgetTester.pumpWidget(
      TestWrapper(
        child: ProfileBottomSheet(
          user: const User(email: email, name: name),
          onOpenProfile: () {},
          onLogout: () {},
        ),
      ),
    );

    expect(find.text(email), findsOneWidget);
    expect(find.text(name), findsOneWidget);
  });

  testWidgets("When click in edit profile should call callback action", (widgetTester) async {
    final completer = Completer<void>();

    await widgetTester.pumpWidget(
      TestWrapper(
        child: ProfileBottomSheet(
          user: const User(),
          onOpenProfile: completer.complete,
          onLogout: () {},
        ),
      ),
    );

    await widgetTester.tap(find.text("Edit profile"));
    expect(completer.isCompleted, isTrue);
  });

  testWidgets("When click in log out should call callback action", (widgetTester) async {
    final completer = Completer<void>();

    await widgetTester.pumpWidget(
      TestWrapper(
        child: ProfileBottomSheet(
          user: const User(),
          onOpenProfile: () {},
          onLogout: completer.complete,
        ),
      ),
    );

    await widgetTester.tap(find.text("Log out"));

    expect(completer.isCompleted, isTrue);
  });
}
