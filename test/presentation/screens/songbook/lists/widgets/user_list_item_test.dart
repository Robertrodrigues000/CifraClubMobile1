import 'package:cifraclub/presentation/screens/songbook/lists/widgets/user_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../shared_mocks/domain/songbook/models/songbook_mock.dart';
import '../../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When list is selected, should show selection divider", (widgetTester) async {
    final songbook = getFakeSongbook();

    await widgetTester.pumpWidget(
      TestWrapper(
        child: UserListItem(
          songbook: songbook,
          onOptionsTap: () {},
          key: Key(songbook.name),
          onTap: () {},
          isSelected: true,
        ),
      ),
    );

    expect(find.byKey(Key(songbook.name)), findsOneWidget);
    expect(find.byType(VerticalDivider), findsOneWidget);
  });

  testWidgets("When songbook is not empty, should show subtitle", (widgetTester) async {
    final songbook = getFakeSongbook();

    await widgetTester.pumpWidget(
      TestWrapper(
        child: UserListItem(
          songbook: songbook,
          onOptionsTap: () {},
          key: Key(songbook.name),
          onTap: () {},
          isSelected: false,
        ),
      ),
    );

    expect(find.byKey(Key(songbook.name)), findsOneWidget);
    expect(find.byKey(const Key("Cifra Preview Subtitle")), findsOneWidget);
  });
}
