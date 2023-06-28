import 'package:cifraclub/domain/app/models/app.dart';
import 'package:cifraclub/presentation/screens/more/models/app_item.dart';
import 'package:cifraclub/presentation/screens/more/widgets/app_card.dart';
import 'package:flutter/material.dart';

class MoreInstalledApps extends StatelessWidget {
  final List<AppItem> allApps;
  final Function(App) onTap;
  final List<AppItem> installedApps;

  const MoreInstalledApps({Key? key, required this.allApps, required this.onTap, required this.installedApps})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final item = allApps[index];
          return AppCard(
            appName: item.title,
            appDescription: item.subtitle,
            logo: item.imageAsset,
            isInstalled: installedApps.contains(item),
            onTap: () => onTap(item.app),
          );
        },
        childCount: allApps.length,
      ),
    );
  }
}
