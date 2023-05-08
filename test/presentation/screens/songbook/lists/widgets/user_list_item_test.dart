import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/user_list_item.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When list is selected, should show selection divider", (widgetTester) async {
    final songbook = Songbook(
      id: faker.randomGenerator.integer(1000),
      createdAt: faker.date.dateTime(),
      lastUpdated: faker.date.dateTime(),
      name: faker.animal.name(),
      isPublic: faker.randomGenerator.boolean(),
      type: ListType.user,
      totalSongs: faker.randomGenerator.integer(10),
    );

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
    final songbook = Songbook(
      id: faker.randomGenerator.integer(1000),
      createdAt: faker.date.dateTime(),
      lastUpdated: faker.date.dateTime(),
      name: faker.animal.name(),
      isPublic: faker.randomGenerator.boolean(),
      type: ListType.user,
      totalSongs: 3,
    );

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
