import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/dialogs/default_dialog.dart';
import 'package:cifraclub/presentation/widgets/buttons/button_type.dart';
import 'package:cifraclub/presentation/widgets/buttons/cifra_button.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class ListLimitProDialog extends StatelessWidget {
  final bool isTabLimit;
  final int limitCount;

  const ListLimitProDialog({Key? key, required this.isTabLimit, required this.limitCount}) : super(key: key);

  // coverage:ignore-start
  static Future<T?> show<T>({required BuildContext context, required bool isTabLimit, required int limitCount}) {
    return showDialog(
        context: context,
        builder: (context) {
          return ListLimitProDialog(
            isTabLimit: isTabLimit,
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
          isTabLimit ? context.text.tabsLimitProTitle(limitCount) : context.text.listLimitProTitle(limitCount),
          style: typography.title4.copyWith(color: colorScheme.textPrimary),
          textAlign: TextAlign.center,
        ),
        description: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: isTabLimit ? context.text.tabsLimitProDescription1 : context.text.listLimitProDescription1,
            style: typography.body10,
            children: <TextSpan>[
              TextSpan(text: "$limitCount ", style: typography.body10.copyWith(fontWeight: FontWeight.w700)),
              TextSpan(
                text: isTabLimit ? context.text.tabsLimitProDescription2 : context.text.listLimitProDescription2,
              ),
            ],
          ),
        ),
        buttons: CifraButton(
          type: ButtonType.outline,
          padding: EdgeInsets.zero,
          child: Text(context.text.gotIt),
          onPressed: () => Navigator.pop(context),
        ));
  }
}
