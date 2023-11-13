import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet_action.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/version_options_bottom_sheet_middleware.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  test("when VersionOptionsBottomSheetAction is OnVersionBottomSheetTapOnVersion", () async {
    final middleware = VersionOptionsBottomSheetMiddleware();
    var actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnShowSelectVersionBottomSheet>(),
      ]),
    );

    middleware.onAction(OnVersionOptionsAction(action: OnVersionBottomSheetTapOnVersion()), const VersionState(),
        (action) {
      actionStream.add(action);
    });

    actionStream.close();
  });

  test("when VersionOptionsBottomSheetAction is OnVersionBottomSheetTapOnTuning", () async {
    final middleware = VersionOptionsBottomSheetMiddleware();
    var actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnShowTuningBottomSheet>(),
      ]),
    );

    middleware.onAction(OnVersionOptionsAction(action: OnVersionBottomSheetTapOnTuning()), const VersionState(),
        (action) {
      actionStream.add(action);
    });

    actionStream.close();
  });

  test("when VersionOptionsBottomSheetAction is OnVersionBottomSheetTapOnCapo", () async {
    final middleware = VersionOptionsBottomSheetMiddleware();
    var actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnShowCapoBottomSheet>(),
      ]),
    );

    middleware.onAction(OnVersionOptionsAction(action: OnVersionBottomSheetTapOnCapo()), const VersionState(),
        (action) {
      actionStream.add(action);
    });

    actionStream.close();
  });

  test("when VersionOptionsBottomSheetAction is OnVersionBottomSheetTapOnFontSize", () async {
    final middleware = VersionOptionsBottomSheetMiddleware();
    var actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnFloatingFooterBarModeChange>().having(
          (e) => e.mode,
          "mode",
          FloatingFooterBarMode.fontSize,
        ),
      ]),
    );

    middleware.onAction(OnVersionOptionsAction(action: OnVersionBottomSheetTapOnFontSize()), const VersionState(),
        (action) {
      actionStream.add(action);
    });

    actionStream.close();
  });

  test("when VersionOptionsBottomSheetAction is OnVersionBottomSheetTapOnChangeKey", () async {
    final middleware = VersionOptionsBottomSheetMiddleware();
    var actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnChangeVersionKey>().having((e) => e.newKey, "new key", "E"),
      ]),
    );

    middleware.onAction(OnVersionOptionsAction(action: OnVersionBottomSheetTapOnChangeKey("E")), const VersionState(),
        (action) {
      actionStream.add(action);
    });

    actionStream.close();
  });
}
