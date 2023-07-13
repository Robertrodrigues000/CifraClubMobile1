import 'dart:async';

import 'package:cifraclub/presentation/screens/artist_songs/widgets/artist_video_lesson_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When tapping an item, should call onTap", (widgetTester) async {
    final completer = Completer();
    await mockNetworkImagesFor(
      () async {
        await widgetTester.pumpWidget(
          TestWrapper(
            child: ArtistVideoLessonItem(
              key: const Key("ArtistVideoLessonItem"),
              imageUrl: "",
              artistName: "artist",
              title: "title",
              views: "2000",
              duration: "20:00",
              versionLabel: "principal",
              onTap: completer.complete,
            ),
          ),
        );
      },
    );
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.byKey(const Key("ArtistVideoLessonItem")), warnIfMissed: false);
    expect(completer.isCompleted, isTrue);
  });
}
