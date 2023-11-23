// coverage:ignore-file
import 'dart:io';

import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar_action.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar_autoscroll.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar_font_size.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar_main.dart';
import 'package:flutter/material.dart';

class FloatingFooterBar extends StatefulWidget {
  final FloatingFooterBarMode mode;
  final bool isAutoScrollRunning;
  final double autoScrollSpeedFactor;
  final bool isVisible;
  final bool isVideoOpen;
  final String? videoThumb;
  final bool isFontDecreaseEnabled;
  final bool isFontIncreaseEnabled;
  final void Function(FloatingFooterBarAction) onAction;

  const FloatingFooterBar({
    super.key,
    required this.mode,
    required this.isAutoScrollRunning,
    required this.autoScrollSpeedFactor,
    required this.isVisible,
    required this.onAction,
    required this.isVideoOpen,
    required this.isFontDecreaseEnabled,
    required this.isFontIncreaseEnabled,
    this.videoThumb,
  });

  @override
  State<FloatingFooterBar> createState() => _FloatingFooterBarState();
}

class _FloatingFooterBarState extends State<FloatingFooterBar> {
  FloatingFooterBarMode? _currentMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Platform.isIOS ? const EdgeInsets.only(bottom: 16) : EdgeInsets.zero,
      child: AnimatedSlide(
        offset: Offset(0, widget.isVisible && ((_currentMode ?? FloatingFooterBarMode.main) == widget.mode) ? 0 : 1.2),
        duration: const Duration(milliseconds: 200),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConstrainedBox(
            constraints: BoxConstraints.loose(const Size.fromWidth(440)),
            child: LayoutBuilder(builder: (context, constraints) {
              var collapsed = constraints.maxWidth < 320;
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 40,
                  color: context.colors.neutralSecondary,
                  child: switch (_currentMode ?? FloatingFooterBarMode.main) {
                    FloatingFooterBarMode.main => FloatingFooterBarMain(
                        onAction: widget.onAction,
                        collapsed: collapsed,
                        isVideoOpen: widget.isVideoOpen,
                        videoThumb: widget.videoThumb,
                      ),
                    FloatingFooterBarMode.autoscroll => FloatingFooterBarAutoscroll(
                        isAutoScrollRunning: widget.isAutoScrollRunning,
                        onAction: widget.onAction,
                        autoScrollSpeedFactor: widget.autoScrollSpeedFactor,
                      ),
                    FloatingFooterBarMode.fontSize => FloatingFooterBarFontSize(
                        onAction: widget.onAction,
                        collapsed: collapsed,
                        isDecreaseEnabled: widget.isFontDecreaseEnabled,
                        isIncreaseEnabled: widget.isFontIncreaseEnabled,
                      ),
                  },
                ),
              );
            }),
          ),
        ),
        onEnd: () {
          setState(() {
            _currentMode = widget.mode;
          });
        },
      ),
    );
  }
}

enum FloatingFooterBarMode {
  main,
  autoscroll,
  fontSize,
}
