import 'package:cifraclub/presentation/screens/home/widgets/video_lessons/video_lesson_item.dart';
import 'package:cifraclub/presentation/screens/home/widgets/video_lessons/video_lessons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../shared_mocks/domain/home/models/video_lessons_mock.dart';
import '../../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("when video lessons list is not empty, should show video lesson items", (widgetTester) async {
    final videoLessons = [getFakeVideoLessons(), getFakeVideoLessons()];
    await widgetTester.pumpWidget(
      TestWrapper(
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              VideoLessons(
                list: videoLessons,
                onTap: (videoLesson) {},
              )
            ],
          ),
        ),
      ),
    );

    await widgetTester.pumpAndSettle();

    expect(find.byType(VideoLessonItem), findsNWidgets(2));
  });
}
