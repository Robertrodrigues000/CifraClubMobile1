// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class IconTextTile extends StatelessWidget {
  const IconTextTile({
    super.key,
    required this.onClick,
    this.leadingIconAsset,
    this.leadingIconUrl,
    this.leadingIconPlaceholder,
    required this.text,
    this.trailingIcon,
  }) : assert(leadingIconAsset == null || leadingIconUrl == null, "Should use a asset or a url for the icon, not both");

  final VoidCallback onClick;
  final String? leadingIconAsset;
  final String? leadingIconUrl;
  final String? leadingIconPlaceholder;
  final String text;
  final String? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.neutralPrimary,
      child: InkWell(
        onTap: onClick,
        child: SizedBox(
          height: 56,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgImage(
                  assetPath: leadingIconAsset,
                  url: leadingIconUrl,
                  placeholderAsset: leadingIconPlaceholder,
                  width: 24,
                  height: 24,
                  color: context.colors.textPrimary,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    text,
                    style: context.typography.subtitle3,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (trailingIcon != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: SvgImage(
                      assetPath: trailingIcon,
                      width: 16,
                      height: 16,
                      color: context.colors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
