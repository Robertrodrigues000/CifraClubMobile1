import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/special_list_item.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When special list is selected, should show selection divider", (widgetTester) async {
    final songbook = Songbook(
      id: faker.randomGenerator.integer(1000),
      createdAt: faker.date.dateTime(),
      lastUpdated: faker.date.dateTime(),
      name: faker.animal.name(),
      isPublic: faker.randomGenerator.boolean(),
      type: ListType.cantPlay,
      totalSongs: faker.randomGenerator.integer(10),
      preview: const [],
    );

    await widgetTester.pumpWidget(
      TestWrapper(
        child: SpecialListItem(
          key: Key(songbook.name),
          type: songbook.type,
          onTap: () {},
          isSelected: true,
        ),
      ),
    );

    expect(find.byKey(Key(songbook.name)), findsOneWidget);
    expect(find.byType(VerticalDivider), findsOneWidget);
    expect(
        find.byWidgetPredicate(
          (Widget widget) {
            return widget is SvgPicture &&
                widget.pictureProvider is ExactAssetPicture &&
                (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.songbookWillPlayIcon;
          },
          description: 'widget with cant play icon',
        ),
        findsOneWidget);
  });
}
