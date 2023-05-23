// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/list_operation_dialogs/list_operation_dialog.dart';
import 'package:flutter/material.dart';

class ClearDialog extends StatelessWidget {
  const ClearDialog({super.key});

  static Future<bool?> show<bool>(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => const ClearDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListOperationDialog(
      title: context.text.cleanListDialogTitle,
      description: Text(
        context.text.cleanListDialogDescription,
        style: context.typography.body10,
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
      firstButtonText: context.text.yes,
      secondButtonText: context.text.no,
      onFirstButtonTap: () => Navigator.pop(context, true),
      onSecondButtonTap: () => Navigator.pop(context, false),
    );
  }
}
