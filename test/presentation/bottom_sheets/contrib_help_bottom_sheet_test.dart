import 'package:cifraclub/presentation/bottom_sheets/contrib_help_bottom_sheet.dart';
import 'package:cifraclub/presentation/dialogs/video_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets(
    "When bottom sheet is open",
    (widgetTester) async {
      await mockNetworkImagesFor(() async {
        await widgetTester.pumpWidgetWithWrapper(
          ContribHelpBottomSheet(
            onTap: () {},
            youtubeThumbnail: null,
          ),
        );
      });

      expect(find.byKey(const Key("open-video")), findsOneWidget);
    },
  );

  testWidgets(
    "should open dialog when tap on video",
    (widgetTester) async {
      await mockNetworkImagesFor(() async {
        await widgetTester.pumpWidgetWithWrapper(
          ContribHelpBottomSheet(
            onTap: () {},
            youtubeThumbnail: null,
          ),
        );
      });

      await widgetTester.tap(find.byKey(const Key("open-video")));
      await widgetTester.pumpAndSettle();

      expect(find.byType(VideoDialog), findsOneWidget);
    },
  );
}
