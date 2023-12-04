// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar_action.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class FloatingFooterBarAutoscroll extends StatefulWidget {
  final void Function(FloatingFooterBarAction) onAction;
  final bool isAutoScrollRunning;
  final double autoScrollSpeedFactor;

  const FloatingFooterBarAutoscroll({
    super.key,
    required this.onAction,
    required this.isAutoScrollRunning,
    required this.autoScrollSpeedFactor,
  });

  @override
  State<FloatingFooterBarAutoscroll> createState() => _FloatingFooterBarAutoscrollState();
}

class _FloatingFooterBarAutoscrollState extends State<FloatingFooterBarAutoscroll> {
  late double _currentSliderValue = widget.autoScrollSpeedFactor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 4),
        ContainerWithRippleEffect(
          alignment: Alignment.center,
          width: 40,
          height: 32,
          child: SvgImage(
            assetPath: AppSvgs.floatingBarAutoscrollClose,
            color: context.colors.textSecondary,
            width: 24,
            height: 24,
          ),
          onTap: () => widget.onAction(FloatingFooterBarDidTapOnCloseAutoScroll()),
        ),
        const SizedBox(width: 16),
        Stack(
          children: [
            SvgImage(
              assetPath: AppSvgs.floatingBarAutoscrollSlow,
              color: context.colors.neutralQuaternary,
            ),
            Opacity(
              opacity: (1 - 2 * _currentSliderValue).clamp(0, 1),
              child: SvgImage(
                assetPath: AppSvgs.floatingBarAutoscrollSlow,
                color: context.colors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration:
                    BoxDecoration(color: context.colors.neutralQuaternary, borderRadius: BorderRadius.circular(1)),
                height: 2,
              ),
              SliderTheme(
                data: SliderThemeData(
                    overlayShape: SliderComponentShape.noOverlay,
                    trackHeight: 0,
                    thumbColor: context.colors.neutralOctonary),
                child: Slider(
                  value: _currentSliderValue,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                    widget.onAction(FloatingFooterBarDidSelectAutoScrollSpeed(speedFactor: value));
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Stack(
          children: [
            SvgImage(
              assetPath: AppSvgs.floatingBarAutoscrollFast,
              color: context.colors.neutralQuaternary,
            ),
            Opacity(
              opacity: (2 * _currentSliderValue - 1).clamp(0, 1),
              child: SvgImage(
                assetPath: AppSvgs.floatingBarAutoscrollFast,
                color: context.colors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        ContainerWithRippleEffect(
          alignment: Alignment.center,
          width: 40,
          height: 32,
          child: SvgImage(
            assetPath: widget.isAutoScrollRunning ? AppSvgs.pauseIcon : AppSvgs.playIcon,
            color: context.colors.textSecondary,
          ),
          onTap: () => widget.onAction(FloatingFooterBarDidTapOnPlayAutoScroll()),
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}
