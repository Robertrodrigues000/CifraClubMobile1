import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/dialogs/default_dialog.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/button_type.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:flutter/material.dart';

class ListOperationDialog extends StatelessWidget {
  const ListOperationDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.firstButtonText,
      required this.secondButtonText,
      required this.onFirstButtonTap,
      required this.onSecondButtonTap,
      this.hasVerticalButtons = false});
  final String title;
  final Widget description;
  final String firstButtonText;
  final String secondButtonText;
  final VoidCallback? onFirstButtonTap;
  final VoidCallback? onSecondButtonTap;
  final bool hasVerticalButtons;

  @override
  Widget build(BuildContext context) {
    return DefaultDialog(
      width: context.appDimensionScheme.listOperationDialogWidth,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      hasCloseIcon: false,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: context.typography.title6.copyWith(color: context.colors.textPrimary),
      ),
      description: description,
      buttons: hasVerticalButtons
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CifraClubButton(
                  key: const Key("first-button"),
                  type: ButtonType.solidBlack,
                  onPressed: onFirstButtonTap,
                  child: Text(firstButtonText),
                ),
                const SizedBox(
                  height: 16,
                ),
                CifraClubButton(
                  type: ButtonType.outline,
                  onPressed: onSecondButtonTap,
                  child: Text(secondButtonText),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: CifraClubButton(
                    type: ButtonType.outline,
                    onPressed: onSecondButtonTap,
                    child: Text(secondButtonText),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: CifraClubButton(
                    key: const Key("first-button"),
                    type: ButtonType.solidBlack,
                    onPressed: onFirstButtonTap,
                    child: Text(firstButtonText),
                  ),
                ),
              ],
            ),
    );
  }
}
