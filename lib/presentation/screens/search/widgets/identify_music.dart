import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class IdentifyMusic extends StatelessWidget {
  final VoidCallback onTap;

  const IdentifyMusic({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
      child: ContainerWithRippleEffect(
        height: context.appDimensionScheme.identifyMusicHeight,
        padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
        decoration: BoxDecoration(
          color: context.colors.neutralPrimary,
          border: Border.all(color: context.colors.neutralTertiary),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        onTap: onTap,
        child: Row(
          children: [
            SvgImage(
              assetPath: AppSvgs.identifyMusicIcon,
              color: context.colors.primary,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(context.text.identifyMusic,
                    style: context.typography.subtitle5.copyWith(color: context.colors.textPrimary)),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 22,
              decoration: BoxDecoration(
                color: context.colors.primaryContainer,
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Center(
                child: Text(
                  context.text.newVersion,
                  style: context.typography.body9.copyWith(color: context.colors.primary),
                  textAlign: TextAlign.center,
                  textHeightBehavior: const TextHeightBehavior(
                    applyHeightToFirstAscent: false,
                    applyHeightToLastDescent: false,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
