// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/list_operation_dialog.dart';
import 'package:flutter/material.dart';

class DeleteVersionDialog extends StatelessWidget {
  const DeleteVersionDialog({super.key, required this.versionName});
  final String versionName;

  static Future<bool?> show<bool>({required BuildContext context, required String versionName}) {
    return showDialog<bool>(
      context: context,
      builder: (context) => DeleteVersionDialog(
        versionName: versionName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListOperationDialog(
      title: versionName,
      description: Text(
        context.text.deleteVersionDialogDescription,
        style: context.typography.body10,
        maxLines: 1,
      ),
      firstButtonText: context.text.yes,
      secondButtonText: context.text.no,
      onFirstButtonTap: () => Navigator.pop(context, true),
      onSecondButtonTap: () => Navigator.pop(context, false),
    );
  }
}
