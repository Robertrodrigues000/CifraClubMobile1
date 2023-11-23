// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/dialogs/default_dialog.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/button_type.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:flutter/material.dart';

class ConfirmRegisterDialog extends StatelessWidget {
  const ConfirmRegisterDialog({super.key});

  // coverage:ignore-start
  static Future<T?> show<T>({required BuildContext context}) {
    return showDialog(
      context: context,
      builder: (context) {
        return const ConfirmRegisterDialog();
      },
    );
  }
  // coverage:ignore-end

  @override
  Widget build(BuildContext context) {
    return DefaultDialog(
      hasCloseIcon: true,
      width: context.appDimensionScheme.listOperationDialogWidth,
      image: AppWebp.registeredEmail,
      title: Text(
        context.text.successEmailRegisterTitle,
        style: context.typography.title5,
        textAlign: TextAlign.center,
      ),
      description: Text(
        context.text.successEmailRegisterDescription,
        style: context.typography.body10,
        textAlign: TextAlign.center,
      ),
      buttons: CifraClubButton(
        type: ButtonType.outline,
        width: double.infinity,
        child: Text(context.text.gotIt),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
