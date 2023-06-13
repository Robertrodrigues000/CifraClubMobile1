// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/dialogs/default_dialog.dart';
import 'package:cifraclub/presentation/widgets/buttons/button_type.dart';
import 'package:cifraclub/presentation/widgets/buttons/cifra_button.dart';
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
        style: context.typography.title4.copyWith(color: context.colors.textPrimary),
      ),
      description: description,
      buttons: hasVerticalButtons
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CifraButton(
                  type: ButtonType.solidBlack,
                  // coverage:ignore-start
                  onPressed: onFirstButtonTap,
                  // coverage:ignore-end
                  child: Text(firstButtonText),
                ),
                const SizedBox(
                  height: 16,
                ),
                CifraButton(
                  type: ButtonType.outline,
                  // coverage:ignore-start
                  onPressed: onSecondButtonTap,
                  // coverage:ignore-end
                  child: Text(secondButtonText),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: CifraButton(
                    type: ButtonType.outline,
                    // coverage:ignore-start
                    onPressed: onSecondButtonTap,
                    // coverage:ignore-end
                    child: Text(secondButtonText),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: CifraButton(
                    type: ButtonType.solidBlack,
                    // coverage:ignore-start
                    onPressed: onFirstButtonTap,
                    // coverage:ignore-end
                    child: Text(firstButtonText),
                  ),
                ),
              ],
            ),
    );
  }
}
