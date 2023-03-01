// coverage:ignore-file
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class FilterCapsule extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget? trailing;
  final Widget? leading;
  final EdgeInsets labelPadding;
  const FilterCapsule({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.trailing,
    this.leading,
    this.labelPadding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CosmosColorScheme.of(context);
    final typography = CosmosTypography.of(context);
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) leading!,
            Padding(
              padding: labelPadding,
              child: Text(
                label,
                style: isSelected ? typography.body6.copyWith(color: colors.textOnPrimary) : typography.body6,
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
