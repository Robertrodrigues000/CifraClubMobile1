import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
import 'package:flutter/widgets.dart';

class ListLimitCard extends StatelessWidget {
  const ListLimitCard({
    super.key,
    required this.listCount,
    required this.limit,
    required this.isPro,
    required this.isWithinLimit,
    required this.onTap,
  });

  final int listCount;
  final int limit;
  final bool isPro;
  final bool isWithinLimit;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ContainerWithRippleEffect(
      onTap: isPro || listCount == 0 ? null : onTap,
      decoration: BoxDecoration(
        border: listCount != 0
            ? Border.all(
                width: 1,
                color: context.colors.neutralTertiary,
              )
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: listCount == 0 ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Stack(alignment: Alignment.center, children: [
          Align(
            alignment: (listCount == 0 && !isPro) ? Alignment.topRight : Alignment.topLeft,
            child: RichText(
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              text: TextSpan(
                style: context.typography.subtitle5,
                children: [
                  TextSpan(
                    text: "$listCount",
                    style: context.typography.subtitle4
                        .copyWith(color: isWithinLimit ? context.colors.textSecondary : context.colors.errorPrimary),
                  ),
                  TextSpan(
                    text: "/$limit ${context.text.lists.toLowerCase()}",
                  ),
                ],
              ),
            ),
          ),
          if (!isPro)
            Align(
              alignment: listCount != 0 ? Alignment.centerRight : Alignment.centerLeft,
              child: Text(
                key: const Key('label'),
                listCount == 0 ? context.text.emptyLists : context.text.increaseLimit,
                style: listCount != 0
                    ? context.typography.subtitle4.copyWith(color: context.colors.successPrimary)
                    : context.typography.subtitle5,
              ),
            ),
        ]),
      ),
    );
  }
}
