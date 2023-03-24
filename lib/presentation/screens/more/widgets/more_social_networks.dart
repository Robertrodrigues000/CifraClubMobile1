import 'package:cifraclub/presentation/screens/more/models/social_network.dart';
import 'package:cifraclub/presentation/screens/more/widgets/social_network_card.dart';
import 'package:flutter/material.dart';

class MoreSocialNetworks extends StatelessWidget {
  final List<SocialNetwork> socialNetworks;
  final Function(String) onTap;
  const MoreSocialNetworks({Key? key, required this.socialNetworks, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 32),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final item = socialNetworks[index];
            return SocialNetworkCard(
              name: item.socialNetworkName,
              username: item.username,
              logo: item.imageAsset,
              onTap: () => onTap(item.url),
            );
          },
          childCount: socialNetworks.length,
        ),
      ),
    );
  }
}
