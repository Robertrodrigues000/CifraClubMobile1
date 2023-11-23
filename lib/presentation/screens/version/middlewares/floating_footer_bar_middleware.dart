import 'package:cifraclub/presentation/screens/version/middlewares/version_middleware.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar_action.dart';
import 'package:injectable/injectable.dart';

@injectable
class FloatingFooterBarMiddleware extends VersionMiddleware {
  @override
  void onAction(VersionAction action, VersionState state, ActionEmitter addAction) {
    if (action is! OnFloatingFooterBarAction) {
      return;
    }

    var floatingFooterAction = action.action;
    switch (floatingFooterAction) {
      case FloatingFooterBarDidTapOnResetFontSize():
        addAction(OnFontSizeRestore());
      case FloatingFooterBarDidTapOnIncreaseFontSize():
        addAction(OnFontSizeIncrease());
      case FloatingFooterBarDidTapOnDecreaseFontSize():
        addAction(OnFontSizeDecrease());
      case FloatingFooterBarDidTapOnConfirmFontSize():
        addAction(OnFloatingFooterBarModeChange(mode: FloatingFooterBarMode.main));
      case FloatingFooterBarDidTapOnAutoscroll():
        addAction(OnFloatingFooterBarModeChange(mode: FloatingFooterBarMode.autoscroll));
        addAction(OnAutoScrollStart());
      case FloatingFooterBarDidTapOnCloseAutoScroll():
        addAction(OnAutoScrollStop());
        addAction(OnFloatingFooterBarModeChange(mode: FloatingFooterBarMode.main));
      case FloatingFooterBarDidTapOnOptions():
        addAction(OnShowOptionsBottomSheet());
      case FloatingFooterBarDidTapOnListen():
        addAction(OnShowListenBottomSheet());
      case FloatingFooterBarDidTapOnVideo():
        state.isYouTubeVisible && state.version?.videoLesson?.youtubeId != null
            ? addAction(OnYouTubeVideoClosed())
            : addAction(OnYouTubeVideoSelected(state.version!.videoLesson!.youtubeId));
      case FloatingFooterBarDidTapOnPlayAutoScroll():
        addAction(state.autoScrollState.isAutoScrollRunning ? OnAutoScrollStop() : OnAutoScrollStart());
      case FloatingFooterBarDidSelectAutoScrollSpeed():
        addAction(OnAutoScrollSpeedSelected(floatingFooterAction.speedFactor));
    }
  }
}
