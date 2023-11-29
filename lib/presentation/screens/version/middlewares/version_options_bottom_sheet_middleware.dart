import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet_action.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/version_middleware.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar.dart';
import 'package:injectable/injectable.dart';

@injectable
class VersionOptionsBottomSheetMiddleware extends VersionMiddleware {
  @override
  void onAction(VersionAction action, VersionState state, ActionEmitter addAction) {
    if (action is! OnVersionOptionsAction) {
      return;
    }

    var versionOptionsAction = action.action;
    switch (versionOptionsAction) {
      case OnVersionBottomSheetTapOnVersion():
        addAction(OnShowSelectVersionBottomSheet());
      case OnVersionBottomSheetTapOnChangeKey():
        addAction(OnChangeVersionKey(versionOptionsAction.newKey));
      case OnVersionBottomSheetTapOnTuning():
        addAction(OnShowTuningBottomSheet());
      case OnVersionBottomSheetTapOnCapo():
        addAction(OnShowCapoBottomSheet());
      case OnVersionBottomSheetTapOnFontSize():
        addAction(OnFloatingFooterBarModeChange(mode: FloatingFooterBarMode.fontSize));
      case OnVersionBottomSheetTapOnTabsVisibility():
        addAction(OnChangeTabsVisibility(versionOptionsAction.newVisibility));
    }
  }
}
