// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterCapsule extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final String? trailingIconUri;
  final String? leadingIconUri;
  final EdgeInsets labelPadding;
  const FilterCapsule({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.trailingIconUri,
    this.leadingIconUri,
    this.labelPadding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CosmosColorScheme.of(context);
    final typography = context.typography;
    return ContainerWithRippleEffect(
      height: 32,
      onTap: onTap,
      decoration: BoxDecoration(
          color: isSelected ? colors.textPrimary : colors.neutralPrimary,
          border: Border.all(
            color: isSelected ? colors.textPrimary : colors.neutralTertiary,
          ),
          borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: (leadingIconUri != null || trailingIconUri != null) ? 8.0 : 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leadingIconUri != null) SvgPicture.asset(leadingIconUri!),
            Padding(
              padding: trailingIconUri != null ? const EdgeInsets.symmetric(horizontal: 8.0) : labelPadding,
              child: Text(
                label,
                style: isSelected ? typography.body6.copyWith(color: colors.textOnPrimary) : typography.body6,
              ),
            ),
            if (trailingIconUri != null)
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(shape: BoxShape.circle, color: CosmosColorScheme.of(context).neutralTertiary),
                child: SvgPicture.asset(
                  trailingIconUri!,
                  color: CosmosColorScheme.of(context).textSecondary,
                  fit: BoxFit.none,
                ),
              )
          ],
        ),
      ),
    );
  }
}
