import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_urls.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:flutter/material.dart';

class SocialNetwork {
  final String socialNetworkName;
  final String username;
  final String imageAsset;
  final String url;

  SocialNetwork({required this.socialNetworkName, required this.username, required this.imageAsset, required this.url});

  // coverage:ignore-start
  static List<SocialNetwork> getAll(BuildContext context) {
    return [
      SocialNetwork(
        socialNetworkName: context.text.instagram,
        username: context.text.atCifraClub,
        imageAsset: AppWebp.socialInstagram,
        url: AppUrls.instagramUrl,
      ),
      SocialNetwork(
        socialNetworkName: context.text.youtube,
        username: context.text.slashCifraClub,
        imageAsset: AppWebp.socialYoutube,
        url: AppUrls.youtubeUrl,
      ),
      SocialNetwork(
        socialNetworkName: context.text.facebook,
        username: context.text.slashCifraClub,
        imageAsset: AppWebp.socialFacebook,
        url: AppUrls.facebookUrl,
      ),
      SocialNetwork(
        socialNetworkName: context.text.tiktok,
        username: context.text.atCifraClub,
        imageAsset: AppWebp.socialTiktok,
        url: AppUrls.tiktokUrl,
      ),
      SocialNetwork(
        socialNetworkName: context.text.twitter,
        username: context.text.atCifraClub,
        imageAsset: AppWebp.socialTwitter,
        url: AppUrls.twitterUrl,
      ),
    ];
  }
  // coverage:ignore-end
}
