// coverage:ignore-file
import 'package:cifraclub/presentation/style/app_color_scheme/app_color_scheme.dart';
import 'package:cifraclub/presentation/style/app_typography_scheme/app_typography_scheme.dart';
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
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
    final colors = AppColorScheme.of(context);
    final typography = AppTypographyScheme.of(context);
    return ContainerWithRippleEffect(
      height: 32,
      onTap: onTap,
      decoration: BoxDecoration(
          color: isSelected ? colors.filterCapsuleSelectedColor : colors.filterCapsuleUnselectedColor,
          border: Border.all(
            color: isSelected ? colors.filterCapsuleSelectedBorderColor : colors.filterCapsuleUnselectedBorderColor,
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
                style: isSelected ? typography.filterCapsuleSelectedStyle : typography.filterCapsuleUnselectedStyle,
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
