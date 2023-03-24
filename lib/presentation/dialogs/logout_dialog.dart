import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/widgets/buttons/stroked_button.dart';
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
              child: StrokedButton(
                text: context.text.cancel,
                onClick: () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  onLogout();
                  Navigator.pop(context);
                },
                child: Text(context.text.logout),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
