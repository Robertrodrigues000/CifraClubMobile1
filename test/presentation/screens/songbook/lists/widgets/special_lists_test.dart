import 'dart:async';

import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
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
            onTap: (_) {},
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
            onTap: (_) {},
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

  testWidgets("When in a songbook should return songbook tapped", (widgetTester) async {
    final songbooks = [
      getFakeSongbook(listType: ListType.recents),
      getFakeSongbook(listType: ListType.favorites),
    ];
    final completer = Completer<Songbook>();

    await widgetTester.pumpWidgetWithWrapper(
      CustomScrollView(slivers: [
        SpecialLists(
          lists: songbooks,
          onTap: (songbook) {
            completer.complete(songbook);
          },
        ),
      ]),
    );

    expect(find.byType(SpecialListItem), findsNWidgets(2));

    await widgetTester.tap(find.byType(SpecialListItem).first);

    expect(await completer.future, songbooks.first);
  });
}
