import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/dialogs/default_dialog.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/button_type.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class ListLimitProDialog extends StatelessWidget {
  final bool isVersionLimit;
  final int limitCount;

  const ListLimitProDialog({Key? key, required this.isVersionLimit, required this.limitCount}) : super(key: key);

  // coverage:ignore-start
  static Future<T?> show<T>({required BuildContext context, required bool isVersionLimit, required int limitCount}) {
    return showDialog(
        context: context,
        builder: (context) {
          return ListLimitProDialog(
            isVersionLimit: isVersionLimit,
            limitCount: limitCount,
          );
        });
  }
  // coverage:ignore-end

  @override
  Widget build(BuildContext context) {
    final colorScheme = CosmosColorScheme.of(context);
    final typography = context.typography;
    return DefaultDialog(
        hasCloseIcon: true,
        image: context.isDarkMode ? AppWebp.listLimitProDark : AppWebp.listLimitProLight,
        title: Text(
          isVersionLimit ? context.text.versionsLimitProTitle(limitCount) : context.text.listLimitProTitle(limitCount),
          style: typography.title6,
          textAlign: TextAlign.center,
        ),
        description: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: isVersionLimit ? context.text.versionsLimitProDescription1 : context.text.listLimitProDescription1,
            style: typography.body10,
            children: <TextSpan>[
              TextSpan(text: "$limitCount ", style: typography.body9.copyWith(color: colorScheme.textSecondary)),
              TextSpan(
                text:
                    isVersionLimit ? context.text.versionsLimitProDescription2 : context.text.listLimitProDescription2,
              ),
            ],
          ),
        ),
        buttons: CifraClubButton(
          width: double.infinity,
          type: ButtonType.outline,
          child: Text(context.text.gotIt),
          onPressed: () => Navigator.pop(context),
        ));
  }
}
