import 'package:cifraclub/extensions/build_context.dart';
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
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      title: Text(context.text.logout),
      children: [
        Text(context.text.confirmLogoutDescription),
        Row(
          children: [
            Expanded(
              child: CifraButton(
                type: ButtonType.outline,
                // coverage:ignore-start
                onPressed: () => Navigator.pop(context),
                // coverage:ignore-end
                padding: const EdgeInsets.all(8),
                child: Text(context.text.cancel),
              ),
            ),
            Expanded(
              child: CifraButton(
                type: ButtonType.primary,
                // coverage:ignore-start
                onPressed: () {
                  onLogout();
                  Navigator.pop(context);
                },
                // coverage:ignore-end
                padding: const EdgeInsets.all(8),
                child: Text(context.text.logout),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
