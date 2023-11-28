// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/dialogs/default_dialog.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/button_type.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:flutter/material.dart';

class IncompatibleVersionDialog extends StatelessWidget {
  final VoidCallback onChangeVersion;
  final VoidCallback onKeepVersion;

  const IncompatibleVersionDialog({super.key, required this.onChangeVersion, required this.onKeepVersion});

  static Future<T?> show<T>(
      {required BuildContext context, required VoidCallback onChangeVersion, required VoidCallback onKeepVersion}) {
    return showDialog(
        context: context,
        builder: (context) {
          return IncompatibleVersionDialog(onChangeVersion: onChangeVersion, onKeepVersion: onKeepVersion);
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultDialog(
      title: Text(
        context.text.changeVersionDialogTitle,
        style: context.typography.title5,
        textAlign: TextAlign.center,
      ),
      description: Text(
        context.text.changeVersionDialogDescription,
        style: context.typography.body10,
        textAlign: TextAlign.center,
      ),
      buttons: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CifraClubButton(
            type: ButtonType.outline,
            onPressed: () {
              onKeepVersion();
              Navigator.pop(context);
            },
            child: Text(context.text.keepChanges),
          ),
          const SizedBox(
            height: 16,
          ),
          CifraClubButton(
            type: ButtonType.solidOrange,
            // coverage:ignore-start
            onPressed: () {
              onChangeVersion();
              Navigator.pop(context);
            },
            // coverage:ignore-end
            child: Text(context.text.resetVersion),
          ),
        ],
      ),
    );
  }
}
