import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/dialogs/default_dialog.dart';
import 'package:cifraclub/presentation/widgets/buttons/button_type.dart';
import 'package:cifraclub/presentation/widgets/buttons/cifra_button.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class ListLimitDialog extends StatelessWidget {
  final bool isTabLimit;
  final int limitCount;

  const ListLimitDialog({Key? key, required this.isTabLimit, required this.limitCount}) : super(key: key);

  // coverage:ignore-start
  static Future<T?> show<T>({required BuildContext context, required bool isTabLimit, required int limitCount}) {
    return showDialog(
        context: context,
        builder: (context) {
          return ListLimitDialog(
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
        image: context.isDarkMode ? AppWebp.listLimitDark : AppWebp.listLimitLight,
        title: Text(
          isTabLimit ? context.text.tabsLimitTitle : context.text.listLimitTitle,
          style: typography.title4.copyWith(color: colorScheme.textPrimary),
          textAlign: TextAlign.center,
        ),
        description: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: isTabLimit
                ? context.text.tabsLimitDescription1(limitCount)
                : context.text.listLimitDescription1(limitCount),
            style: typography.body10,
            children: <TextSpan>[
              TextSpan(
                  text: isTabLimit ? context.text.tenTimes : context.text.hundredTimes,
                  style: typography.body10.copyWith(fontWeight: FontWeight.w700)),
              TextSpan(
                text: isTabLimit ? context.text.listLimitDescription2 : context.text.listLimitDescription2,
              ),
              TextSpan(
                  text: context.text.cifraClubProLimit, style: typography.body10.copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        buttons: Column(
          children: [
            CifraButton(
              type: ButtonType.tertiary,
              padding: EdgeInsets.zero,
              child: Text(context.text.testPro),
              //TODO: direct to pro screen
            ),
            const SizedBox(
              height: 16,
            ),
            CifraButton(
              type: ButtonType.ghost,
              padding: EdgeInsets.zero,
              child: Text(context.text.notNow),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ));
  }
}
