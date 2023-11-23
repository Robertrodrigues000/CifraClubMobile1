// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar_action.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar_button.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class FloatingFooterBarFontSize extends StatelessWidget {
  final bool collapsed;
  final bool isIncreaseEnabled;
  final bool isDecreaseEnabled;
  final void Function(FloatingFooterBarAction) onAction;

  const FloatingFooterBarFontSize({
    super.key,
    required this.onAction,
    required this.collapsed,
    required this.isDecreaseEnabled,
    required this.isIncreaseEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 4),
        FloatingFooterBarButton(
          text: context.text.restore,
          icon: AppSvgs.floatingBarFontReset,
          padding: 12,
          collapsed: collapsed,
          onTap: () => onAction(FloatingFooterBarDidTapOnResetFontSize()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            color: context.colors.neutralTertiary,
            width: 1,
            height: 32,
          ),
        ),
        Expanded(
          child: ContainerWithRippleEffect(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            onTap: isDecreaseEnabled ? () => onAction(FloatingFooterBarDidTapOnDecreaseFontSize()) : null,
            child: SvgImage(
              assetPath: AppSvgs.floatingBarFontSmaller,
              color: isDecreaseEnabled ? context.colors.textPrimary : context.colors.neutralSextenary,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            color: context.colors.neutralTertiary,
            width: 1,
            height: 32,
          ),
        ),
        Expanded(
          child: ContainerWithRippleEffect(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            onTap: isIncreaseEnabled ? () => onAction(FloatingFooterBarDidTapOnIncreaseFontSize()) : null,
            child: SvgImage(
              assetPath: AppSvgs.floatingBarFontBigger,
              color: isIncreaseEnabled ? context.colors.textPrimary : context.colors.neutralSextenary,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            color: context.colors.neutralTertiary,
            width: 1,
            height: 32,
          ),
        ),
        FloatingFooterBarButton(
          text: context.text.done,
          icon: AppSvgs.floatingBarFontConfirm,
          padding: 12,
          collapsed: collapsed,
          onTap: () => onAction(FloatingFooterBarDidTapOnConfirmFontSize()),
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}
