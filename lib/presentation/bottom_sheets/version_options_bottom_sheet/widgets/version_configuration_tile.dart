import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

class VersionConfigurationTile extends StatelessWidget {
  const VersionConfigurationTile({super.key, required this.name, required this.onTap, required this.child});

  final String name;
  final VoidCallback onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.neutralPrimary,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 56,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: context.typography.subtitle3,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (child != null) child!
              ],
            ),
          ),
        ),
      ),
    );
  }
}
