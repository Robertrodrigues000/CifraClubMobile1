import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppCard extends StatelessWidget {
  final String appName;
  final String appDescription;
  final String logo;
  final bool isInstalled;
  final VoidCallback onTap;

  const AppCard({
    super.key,
    required this.appName,
    required this.appDescription,
    required this.logo,
    required this.isInstalled,
    required this.onTap,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appName,
                      style: CosmosTypography.of(context).subtitle3,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      appDescription,
                      style: CosmosTypography.of(context).subtitle5,
                    )
                  ],
                ),
              ),
              const SizedBox(width: 16),
              SvgPicture.asset(
                isInstalled ? AppSvgs.openAppIcon : AppSvgs.downloadIcon,
                color: CosmosColorScheme.of(context).textPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
