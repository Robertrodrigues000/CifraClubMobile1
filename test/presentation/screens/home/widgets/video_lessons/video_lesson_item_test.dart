import 'dart:async';

import 'package:cifraclub/presentation/screens/home/widgets/video_lessons/video_lesson_item.dart';
import 'package:cifraclub/presentation/widgets/remote_image/remote_image_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../shared_mocks/domain/home/models/video_lessons_mock.dart';
import '../../../../../test_helpers/fake_cache_manager.dart';
import '../../../../../test_helpers/image_data.dart';
import '../../../../../test_helpers/test_wrapper.dart';

void main() {
  late FakeCacheManager cacheManager;

  setUp(() {
    cacheManager = FakeCacheManager();
  });

  tearDown(() {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  });
  testWidgets("when video lesson item title is tapped, should trigger onTap callback", (widgetTester) async {
    final videoLesson = getFakeVideoLessons();
    final completer = Completer();
    cacheManager.returns(videoLesson.images.medium, kTransparentImage);

    await widgetTester.pumpWidget(
      TestWrapper(
        child: Scaffold(
          body: RemoteImageCacheManager(
            cacheManager: cacheManager,
            child: VideoLessonItem(videoLesson: videoLesson, width: 100, height: 100, onTap: completer.complete),
          ),
        ),
      ),
    );

    await widgetTester.pumpAndSettle();

    await widgetTester.tap(
      find.text(
        videoLesson.title,
      ),
    );
    expect(completer.isCompleted, isTrue);
  });
}
