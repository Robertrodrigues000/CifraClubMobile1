// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconTextTile extends StatelessWidget {
  const IconTextTile({
    super.key,
    required this.onClick,
    this.leadingIcon,
    this.leadingIconUrl,
    required this.text,
  }) : assert(leadingIcon == null || leadingIconUrl == null, "Should use a asset or a url for the icon, not both");

  final VoidCallback onClick;
  final String? leadingIcon;
  final String? leadingIconUrl;
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
                if (leadingIcon != null)
                  SvgPicture.asset(
                    leadingIcon!,
                    width: 24,
                    height: 24,
                    color: CosmosColorScheme.of(context).textPrimary,
                  )
                else if (leadingIconUrl != null)
                  SvgPicture.network(
                    leadingIconUrl!,
                    width: 24,
                    height: 24,
                    color: CosmosColorScheme.of(context).textPrimary,
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    text,
                    style: CosmosTypography.of(context).subtitle3,
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
