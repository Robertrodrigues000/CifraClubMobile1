// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class IconTextTile extends StatelessWidget {
  const IconTextTile({
    super.key,
    required this.onClick,
    this.leadingIconAsset,
    this.leadingIconUrl,
    this.leadingIconPlaceholder,
    required this.text,
  }) : assert(leadingIconAsset == null || leadingIconUrl == null, "Should use a asset or a url for the icon, not both");

  final VoidCallback onClick;
  final String? leadingIconAsset;
  final String? leadingIconUrl;
  final String? leadingIconPlaceholder;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CosmosColorScheme.of(context).neutralPrimary,
      child: InkWell(
        onTap: onClick,
        child: SizedBox(
          height: 56,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
            child: Row(
              children: [
                SvgImage(
                  leadingIconAsset: leadingIconAsset,
                  leadingIconUrl: leadingIconUrl,
                  placeholderAsset: leadingIconPlaceholder,
                  width: 24,
                  height: 24,
                  color: CosmosColorScheme.of(context).textPrimary,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    text,
                    style: context.typography.subtitle3,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
