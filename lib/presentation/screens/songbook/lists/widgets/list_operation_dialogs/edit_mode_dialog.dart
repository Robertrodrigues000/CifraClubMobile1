// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/list_operation_dialogs/list_operation_dialog.dart';
import 'package:flutter/material.dart';

class EditModeDialog extends StatelessWidget {
  const EditModeDialog({super.key});

  static Future<bool?> show<bool>(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => const EditModeDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListOperationDialog(
      hasVerticalButtons: true,
      title: context.text.editListDialogTitle,
      description: Text(
        context.text.editListDialogDescription,
        textAlign: TextAlign.center,
        style: context.typography.body10,
        maxLines: 2,
      ),
      firstButtonText: context.text.editListDialogPrimaryButton,
      secondButtonText: context.text.exit,
      onFirstButtonTap: () => Navigator.pop(context, true),
      onSecondButtonTap: () => Navigator.pop(context, false),
    );
  }
}
