import 'package:cifraclub/presentation/screens/version/middlewares/floating_footer_bar_middleware.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar_action.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../shared_mocks/domain/version/models/version_data_mock.dart';
import '../../../../shared_mocks/domain/version/models/version_data_video_lesson.dart';

void main() {
  test('When FloatingFooterBarAction is FloatingFooterBarDidTapOnAutoscroll', () async {
    final middleware = FloatingFooterBarMiddleware();
    var actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnFloatingFooterBarModeChange>().having(
          (e) => e.mode,
          "mode",
          FloatingFooterBarMode.autoscroll,
        ),
        isA<OnAutoScrollStart>(),
      ]),
    );

    middleware.onAction(OnFloatingFooterBarAction(action: FloatingFooterBarDidTapOnAutoscroll()), const VersionState(),
        (action) {
      actionStream.add(action);
    });

    actionStream.close();
  });
  test('When FloatingFooterBarAction is FloatingFooterBarDidTapOnCloseAutoScroll', () async {
    final middleware = FloatingFooterBarMiddleware();
    var actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnAutoScrollStop>(),
        isA<OnFloatingFooterBarModeChange>().having(
          (e) => e.mode,
          "mode",
          FloatingFooterBarMode.main,
        ),
      ]),
    );

    middleware.onAction(
        OnFloatingFooterBarAction(action: FloatingFooterBarDidTapOnCloseAutoScroll()), const VersionState(), (action) {
      actionStream.add(action);
    });

    actionStream.close();
  });

  test('When FloatingFooterBarAction is FloatingFooterBarDidTapOnOptions', () async {
    final middleware = FloatingFooterBarMiddleware();
    var actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnShowOptionsBottomSheet>(),
      ]),
    );

    middleware.onAction(OnFloatingFooterBarAction(action: FloatingFooterBarDidTapOnOptions()), const VersionState(),
        (action) {
      actionStream.add(action);
    });

    actionStream.close();
  });

  test('When FloatingFooterBarAction is FloatingFooterBarDidTapOnListen', () async {
    final middleware = FloatingFooterBarMiddleware();
    var actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnShowListenBottomSheet>(),
      ]),
    );

    middleware.onAction(OnFloatingFooterBarAction(action: FloatingFooterBarDidTapOnListen()), const VersionState(),
        (action) {
      actionStream.add(action);
    });

    actionStream.close();
  });

  test('When FloatingFooterBarAction is FloatingFooterBarDidTapOnVideo', () async {
    final middleware = FloatingFooterBarMiddleware();
    var actionStream = PublishSubject<VersionAction>();
    var videoLesson = getFakeVersionDataVideoLesson();
    var versionData = getFakeVersionData(videoLesson: videoLesson);

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnYouTubeVideoSelected>().having(
          (e) => e.videoId,
          "videoId",
          videoLesson.youtubeId,
        ),
        isA<OnYouTubeVideoClosed>()
      ]),
    );

    middleware.onAction(
      OnFloatingFooterBarAction(action: FloatingFooterBarDidTapOnVideo()),
      VersionState(
        version: versionData,
        isYouTubeVisible: false,
      ),
      (action) {
        actionStream.add(action);
      },
    );

    middleware.onAction(
      OnFloatingFooterBarAction(action: FloatingFooterBarDidTapOnVideo()),
      VersionState(
        version: versionData,
        isYouTubeVisible: true,
      ),
      (action) {
        actionStream.add(action);
      },
    );

    actionStream.close();
  });

  test('When FloatingFooterBarAction is FloatingFooterBarDidTapOnPlayAutoScroll', () async {
    final middleware = FloatingFooterBarMiddleware();
    var actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnAutoScrollStart>(),
        isA<OnAutoScrollStop>(),
      ]),
    );

    middleware.onAction(
      OnFloatingFooterBarAction(action: FloatingFooterBarDidTapOnPlayAutoScroll()),
      const VersionState(
        autoScrollState: AutoScrollState(isAutoScrollRunning: false),
      ),
      (action) {
        actionStream.add(action);
      },
    );

    middleware.onAction(
      OnFloatingFooterBarAction(action: FloatingFooterBarDidTapOnPlayAutoScroll()),
      const VersionState(
        autoScrollState: AutoScrollState(isAutoScrollRunning: true),
      ),
      (action) {
        actionStream.add(action);
      },
    );

    actionStream.close();
  });
  test('When FloatingFooterBarAction is FloatingFooterBarDidSelectAutoScrollSpeed', () async {
    final middleware = FloatingFooterBarMiddleware();
    var actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnAutoScrollSpeedSelected>().having(
          (e) => e.speedFactor,
          "speedFactor",
          0.42,
        ),
      ]),
    );

    middleware.onAction(OnFloatingFooterBarAction(action: FloatingFooterBarDidSelectAutoScrollSpeed(speedFactor: 0.42)),
        const VersionState(), (action) {
      actionStream.add(action);
    });

    actionStream.close();
  });
}
