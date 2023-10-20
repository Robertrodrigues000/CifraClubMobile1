// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class FloatingFooterBarButton extends StatelessWidget {
  const FloatingFooterBarButton({
    super.key,
    required this.text,
    required this.icon,
    required this.collapsed,
    this.padding,
    required this.onTap,
  });

  final String text;
  final String icon;
  final bool collapsed;
  final double? padding;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ContainerWithRippleEffect(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!collapsed) ...[
                SvgImage(assetPath: icon, color: context.colors.textSecondary),
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: context.typography.body9.copyWith(color: context.colors.neutralNonary),
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                  applyHeightToLastDescent: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
