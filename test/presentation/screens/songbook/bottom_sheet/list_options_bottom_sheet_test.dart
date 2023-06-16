import 'dart:async';

import 'package:cifraclub/presentation/screens/songbook/bottom_sheet/list_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../shared_mocks/presentation/navigator/nav_mock.dart';
import '../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets(
      "When open bottom sheet and isUserlist is true should show all options and return correctly OptionsBottomSheet",
      (widgetTester) async {
    final completer = Completer<ListOptionsBottomSheetItem>();

    await widgetTester.pumpWidgetWithWrapper(
      ListOptionsBottomSheet(
        isUserList: true,
        ccid: 1,
        songbookId: 1,
        onTap: (e, [rect]) {
          completer.complete(e);
        },
        isPublic: true,
      ),
    );

    expect(find.byType(IconTextTile), findsNWidgets(5));

    await widgetTester.tap(find.byType(IconTextTile).at(1));
    await widgetTester.pump();

    expect(await completer.future, ListOptionsBottomSheetItem.rename);
  });

  testWidgets(
      "When open bottom sheet and isUserlist is false should show only 1 option and return correctly OptionsBottomSheet",
      (widgetTester) async {
    final completer = Completer<ListOptionsBottomSheetItem>();

    await widgetTester.pumpWidgetWithWrapper(
      ListOptionsBottomSheet(
        isUserList: false,
        onTap: (e, [rect]) {
          completer.complete(e);
        },
        isPublic: false,
      ),
    );

    expect(find.byType(IconTextTile), findsOneWidget);
    await widgetTester.tap(find.byType(IconTextTile));
    expect(await completer.future, ListOptionsBottomSheetItem.clear);
  });

  testWidgets("When open bottom sheet and click in share should create share callback", (widgetTester) async {
    final completer = Completer<ListOptionsBottomSheetItem>();
    final nav = NavMock.getDummy();

    await widgetTester.pumpWidgetWithWrapper(
      ListOptionsBottomSheet(
        isUserList: true,
        ccid: 1,
        songbookId: 1,
        onTap: (e, [rect]) {
          completer.complete(e);
        },
        isPublic: true,
      ),
      nav: nav,
    );

    expect(find.byType(IconTextTile), findsNWidgets(5));

    await widgetTester.tap(find.byType(IconTextTile).first);
    await widgetTester.pump();

    expect(await completer.future, ListOptionsBottomSheetItem.share);
  });

  testWidgets("When tap open bottom sheet", (widgetTester) async {
    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return InkWell(
            onTap: () {
              ListOptionsBottomSheet(
                isUserList: true,
                onTap: (p0, [rect]) {},
                isPublic: false,
              ).show(context);
            },
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();
    expect(find.byType(ListOptionsBottomSheet), findsOneWidget);
  });
}
