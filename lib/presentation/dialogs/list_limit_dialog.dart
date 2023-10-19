import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/dialogs/default_dialog.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/button_type.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class ListLimitDialog extends StatelessWidget {
  final bool isVersionLimit;
  final int limitCount;

  const ListLimitDialog({Key? key, required this.isVersionLimit, required this.limitCount}) : super(key: key);

  // coverage:ignore-start
  static Future<T?> show<T>({required BuildContext context, required bool isVersionLimit, required int limitCount}) {
    return showDialog(
        context: context,
        builder: (context) {
          return ListLimitDialog(
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
        image: context.isDarkMode ? AppWebp.listLimitDark : AppWebp.listLimitLight,
        title: Text(
          isVersionLimit ? context.text.versionsLimitTitle : context.text.listLimitTitle,
          style: typography.title6,
          textAlign: TextAlign.center,
        ),
        description: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: isVersionLimit
                ? context.text.versionsLimitDescription1(limitCount)
                : context.text.listLimitDescription1(limitCount),
            style: typography.body10,
            children: <TextSpan>[
              TextSpan(
                  text: isVersionLimit ? context.text.tenTimes : context.text.hundredTimes,
                  style: typography.body9.copyWith(color: colorScheme.textSecondary)),
              TextSpan(
                text: context.text.listLimitDescription2,
              ),
              TextSpan(
                  text: context.text.cifraClubProLimit,
                  style: typography.body9.copyWith(color: colorScheme.textSecondary)),
            ],
          ),
        ),
        buttons: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CifraClubButton(
              type: ButtonType.solidGreen,
              child: Text(context.text.testPro),
              //TODO: direct to pro screen
            ),
            const SizedBox(
              height: 16,
            ),
            CifraClubButton(
              type: ButtonType.ghostWhite,
              child: Text(context.text.notNow),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ));
  }
}
