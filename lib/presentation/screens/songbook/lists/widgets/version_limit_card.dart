import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
import 'package:flutter/widgets.dart';

class VersionLimitCard extends StatelessWidget {
  const VersionLimitCard({
    super.key,
    required this.versionsCount,
    required this.limit,
    required this.isPro,
    required this.isWithinLimit,
    required this.onTap,
    this.isList = true,
  });

  final int versionsCount;
  final int limit;
  final bool isPro;
  final bool isWithinLimit;
  final VoidCallback onTap;
  final bool isList;
  @override
  Widget build(BuildContext context) {
    final bool hasBorder = isPro ? !isList : true;

    return ContainerWithRippleEffect(
      onTap: isPro ? null : onTap,
      height: isPro ? context.appDimensionScheme.heightLimitCardPro : context.appDimensionScheme.heightLimitCardFree,
      decoration: hasBorder
          ? BoxDecoration(
              color: context.colors.neutralPrimary,
              border: Border.all(
                width: 1,
                color: context.colors.neutralTertiary,
              ),
              borderRadius: BorderRadius.circular(8),
            )
          : null,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
        child: Stack(alignment: Alignment.center, children: [
          Align(
            alignment: isPro ? Alignment.center : Alignment.centerLeft,
            child: RichText(
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              text: TextSpan(
                style: context.typography.subtitle5,
                children: [
                  TextSpan(
                    text: "$versionsCount",
                    style: context.typography.subtitle4
                        .copyWith(color: isWithinLimit ? context.colors.textSecondary : context.colors.errorPrimary),
                  ),
                  TextSpan(
                    text: "/$limit ${context.text.versions}",
                  ),
                ],
              ),
            ),
          ),
          if (!isPro)
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                key: const Key('label'),
                context.text.increaseLimit,
                style: context.typography.subtitle4.copyWith(color: context.colors.successPrimary),
              ),
            ),
        ]),
      ),
    );
  }
}
