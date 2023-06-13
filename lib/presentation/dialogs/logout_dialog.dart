import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/dialogs/default_dialog.dart';
import 'package:cifraclub/presentation/widgets/buttons/button_type.dart';
import 'package:cifraclub/presentation/widgets/buttons/cifra_button.dart';
import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutDialog({super.key, required this.onLogout});

  static Future<T?> show<T>({required BuildContext context, required VoidCallback onLogout}) {
    return showDialog(
        context: context,
        builder: (context) {
          return LogoutDialog(onLogout: onLogout);
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultDialog(
      title: Text(
        context.text.logout,
        style: context.typography.title3,
        textAlign: TextAlign.center,
      ),
      description: Text(
        context.text.confirmLogoutDescription,
        style: context.typography.body10,
        textAlign: TextAlign.center,
      ),
      buttons: Row(
        children: [
          Expanded(
            child: CifraButton(
              type: ButtonType.outline,
              // coverage:ignore-start
              onPressed: () => Navigator.pop(context),
              // coverage:ignore-end
              child: Text(context.text.cancel),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: CifraButton(
              type: ButtonType.solidOrange,
              // coverage:ignore-start
              onPressed: () {
                onLogout();
                Navigator.pop(context);
              },
              // coverage:ignore-end
              child: Text(context.text.logout),
            ),
          ),
        ],
      ),
    );
  }
}
