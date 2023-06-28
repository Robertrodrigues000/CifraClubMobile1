import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/dialogs/default_dialog.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/button_type.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets('when default dialog is called, should show Dialog', (tester) async {
    await tester.pumpWidgetWithWrapper(
      const DefaultDialog(
        hasCloseIcon: false,
        title: Text("Default Dialog"),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(Dialog), findsOneWidget);
  });

  testWidgets("when description is not null, should show description widget", (tester) async {
    await tester.pumpWidgetWithWrapper(
      const DefaultDialog(
        hasCloseIcon: true,
        title: Text("Default Dialog"),
        description: Text("Description"),
      ),
    );

    expect(find.text("Description"), findsOneWidget);
  });

  testWidgets("when buttons is not null, should show buttons widget", (tester) async {
    await tester.pumpWidgetWithWrapper(
      const DefaultDialog(
        hasCloseIcon: false,
        title: Text("Default Dialog"),
        buttons: CifraClubButton(type: ButtonType.solidGreen, padding: EdgeInsets.all(8)),
      ),
    );

    expect(find.byType(CifraClubButton), findsOneWidget);
  });

  testWidgets("when image is not null, should show image asset", (tester) async {
    await tester.pumpWidgetWithWrapper(
      const DefaultDialog(
        hasCloseIcon: true,
        title: Text("Default Dialog"),
        image: AppWebp.withoutConnectionLight,
      ),
    );

    expect(find.image(const AssetImage(AppWebp.withoutConnectionLight)), findsOneWidget);
  });

  testWidgets('when close icon is tapped, should close dialog', (tester) async {
    await tester.pumpWidgetWithWrapper(
      const DefaultDialog(
        hasCloseIcon: true,
        title: Text("Default Dialog"),
      ),
    );

    await tester.pumpAndSettle();

    final closeFinder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SvgPicture &&
          widget.pictureProvider is ExactAssetPicture &&
          (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.closeIcon,
      description: 'widget with close icon',
    );

    expect(closeFinder, findsOneWidget);
    await tester.tap(closeFinder);

    await tester.pumpAndSettle();
    expect(find.byType(DefaultDialog), findsNothing);
  });
}
