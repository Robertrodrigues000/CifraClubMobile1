// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
import 'package:cifraclub/presentation/widgets/default_placeholder.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar_action.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar_button.dart';
import 'package:cifraclub/presentation/widgets/remote_image/remote_image.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class FloatingFooterBarMain extends StatelessWidget {
  final bool collapsed;
  final bool isVideoOpen;
  final String? videoThumb;
  final void Function(FloatingFooterBarAction) onAction;

  const FloatingFooterBarMain({
    super.key,
    required this.onAction,
    required this.collapsed,
    required this.isVideoOpen,
    this.videoThumb,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FloatingFooterBarButton(
            text: context.text.listen,
            icon: AppSvgs.floatingBarListen,
            collapsed: collapsed,
            onTap: () => onAction(FloatingFooterBarDidTapOnListen()),
          ),
        ),
        Expanded(
          child: FloatingFooterBarButton(
            text: context.text.scroll,
            icon: AppSvgs.floatingBarAutoscroll,
            collapsed: collapsed,
            onTap: () => onAction(FloatingFooterBarDidTapOnAutoscroll()),
          ),
        ),
        Expanded(
          child: FloatingFooterBarButton(
            text: context.text.options,
            icon: AppSvgs.floatingBarSettings,
            collapsed: collapsed,
            onTap: () => onAction(FloatingFooterBarDidTapOnOptions()),
          ),
        ),
        const SizedBox(width: 4),
        if (videoThumb != null) ...[
          ContainerWithRippleEffect(
            width: 60,
            height: 34,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: isVideoOpen
                ? Container(
                    width: 60,
                    height: 34,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: context.colors.neutralPrimary,
                        strokeAlign: BorderSide.strokeAlignInside,
                        width: 2,
                      ),
                    ),
                    child: SvgImage(
                      color: context.colors.textSecondary,
                      assetPath: AppSvgs.floatingBarMinifyVideo,
                    ),
                  )
                : RemoteImage(
                    imageUrl: videoThumb,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 60,
                      height: 34,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: const DefaultPlaceholder(
                      height: 32,
                      width: 60,
                      svgIcon: AppSvgs.videoPlaceholder,
                      isLarge: false,
                    ),
                  ),
            onTap: () => onAction(FloatingFooterBarDidTapOnVideo()),
          ),
          const SizedBox(width: 4),
        ],
      ],
    );
  }
}
