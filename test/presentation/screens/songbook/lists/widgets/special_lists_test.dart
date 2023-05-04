import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/special_list_item.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/special_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../shared_mocks/domain/songbook/models/songbook_mock.dart';
import '../../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When has special lists, should show all special lists", (widgetTester) async {
    final songbooks = [
      getFakeSongbook(listType: ListType.recents),
      getFakeSongbook(listType: ListType.favorites),
      getFakeSongbook(listType: ListType.canPlay),
    ];

    await widgetTester.pumpWidget(
      TestWrapper(
        child: CustomScrollView(slivers: [
          SpecialLists(
            lists: songbooks,
          ),
        ]),
      ),
    );

    expect(find.byType(SpecialListItem), findsNWidgets(3));
  });

  testWidgets("When special list is recents, should show correct icon asset", (widgetTester) async {
    final songbooks = [
      getFakeSongbook(listType: ListType.recents),
    ];

    await widgetTester.pumpWidget(
      TestWrapper(
        child: CustomScrollView(slivers: [
          SpecialLists(
            lists: songbooks,
          ),
        ]),
      ),
    );

    expect(find.byKey(Key(songbooks.first.name)), findsOneWidget);
    expect(
        find.byWidgetPredicate(
          (Widget widget) {
            return widget is SvgPicture &&
                widget.pictureProvider is ExactAssetPicture &&
                (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.songbookRecentsIcon;
          },
          description: 'widget with recents icon',
        ),
        findsOneWidget);
  });
}
