import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

class SocialNetworkCard extends StatelessWidget {
  final VoidCallback onTap;
  final String name;
  final String username;
  final String logo;

  const SocialNetworkCard({
    super.key,
    required this.onTap,
    required this.name,
    required this.username,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.appDimensionScheme.screenMargin,
            vertical: 16,
          ),
          child: Row(
            children: [
              Image.asset(
                logo,
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 16),
              Text(
                name,
                style: context.typography.subtitle3,
              ),
              const SizedBox(width: 12),
              Text(
                username,
                style: context.typography.subtitle5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
