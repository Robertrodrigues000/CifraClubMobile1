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
    this.hasBackground = false,
  });

  final int versionsCount;
  final int limit;
  final bool isPro;
  final bool isWithinLimit;
  final VoidCallback onTap;
  final bool hasBackground;
  @override
  Widget build(BuildContext context) {
    return ContainerWithRippleEffect(
      onTap: isPro || versionsCount == 0 ? null : onTap,
      decoration: hasBackground
          ? null
          : BoxDecoration(
              border: Border.all(
                width: 1,
                color: context.colors.neutralTertiary,
              ),
              borderRadius: BorderRadius.circular(8),
              color: context.colors.neutralPrimary,
            ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Stack(alignment: Alignment.center, children: [
          Align(
            alignment: isPro ? Alignment.center : Alignment.centerLeft,
            child: RichText(
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
                  style: context.typography.subtitle4.copyWith(color: context.colors.successPrimary)),
            ),
        ]),
      ),
    );
  }
}
